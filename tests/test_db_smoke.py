# tests/test_db_smoke.py
"""
Integration smoke test for the SQLAlchemy + Alembic schema.

Exercises every entity and every relationship. Uses a session-rollback
fixture so each test leaves the DB exactly as it found it.
"""
import pytest
from datetime import date

from db.session import SessionLocal
from db.models import (
    Infrastructure, Application, Dependency,
    SecurityFinding, OperationalMetric, Wave, Recommendation,
)
from api.schemas import (
    EnvironmentType, ArchetypeType, CriticalityLevel,
    SeverityLevel, SixRDecision,
)


@pytest.fixture
def session():
    """A session that ALWAYS rolls back. Tests cannot pollute the DB."""
    s = SessionLocal()
    try:
        yield s
    finally:
        s.rollback()
        s.close()


def test_full_graph_insert_and_navigate(session):
    """Insert one of every entity, navigate the relationships both directions."""

    infra = Infrastructure(
        id="infra-t-001",
        environment_type=EnvironmentType.ON_PREM_VM,
        os_name="Test OS",
        os_eol_date=date(2023, 10, 10),
        cpu_cores=8, memory_gb=32,
        location="Test DC", owner_team="Test Team",
    )
    app = Application(
        id="app-t-001",
        name="Test App",
        archetype=ArchetypeType.COTS_VENDOR,
        language="C++", runtime_version="1.0",
        criticality=CriticalityLevel.MISSION_CRITICAL,
        owner_team="Test", app_owner_name="Test",
        infrastructure_id=infra.id,
    )
    vuln = SecurityFinding(
        id="vuln-t-001",
        application_id=app.id,
        cve_id="CVE-2023-99999",
        title="Test CVE",
        severity=SeverityLevel.CRITICAL,
        cvss_score=9.8,
        discovered_date=date(2025, 4, 15),
        remediation_available=False,
    )
    metric = OperationalMetric(
        id="metric-t-001",
        application_id=app.id,
        incidents_last_quarter=4,
        mttr_hours=6.5,
        availability_pct=98.45,
        cpu_utilization_pct=88.5,
    )
    wave = Wave(
        id="wave-t-001",
        wave_number=1,
        theme="Test Wave",
        target_start_date=date(2026, 6, 1),
        target_end_date=date(2026, 6, 30),
    )
    rec = Recommendation(
        id="rec-t-001",
        application_id=app.id,
        readiness_score=35,
        sixr_decision=SixRDecision.REPLATFORM,
        confidence_score=0.92,
        reasoning="Test reasoning",
        dependency_warnings=["warn-A", "warn-B"],
        wave_id=wave.id,
    )

    session.add_all([infra, app, vuln, metric, wave, rec])
    session.flush()  # sends to DB but doesn't commit

    # Forward: app -> infrastructure
    loaded = session.get(Application, "app-t-001")
    assert loaded.infrastructure.os_name == "Test OS"

    # Forward: app -> security_findings (one-to-many)
    assert len(loaded.security_findings) == 1
    assert loaded.security_findings[0].cve_id == "CVE-2023-99999"

    # Forward: app -> recommendation (one-to-one)
    assert loaded.recommendation.sixr_decision == SixRDecision.REPLATFORM
    assert loaded.recommendation.wave.wave_number == 1

    # ARRAY round-trip
    assert loaded.recommendation.dependency_warnings == ["warn-A", "warn-B"]

    # Backward: infra -> applications
    loaded_infra = session.get(Infrastructure, "infra-t-001")
    assert len(loaded_infra.applications) == 1


def test_dependency_self_reference(session):
    """An app can depend on another app via the dependencies edge table."""

    infra = Infrastructure(
        id="infra-dep-h",
        environment_type=EnvironmentType.KUBERNETES,
        os_name="Linux",
        os_eol_date=date(2030, 1, 1),
        cpu_cores=4, memory_gb=16,
        location="Test", owner_team="Test",
    )
    app_a = Application(
        id="app-dep-a", name="A",
        archetype=ArchetypeType.MODERN_MICROSERVICE,
        language="Python", runtime_version="3.11",
        criticality=CriticalityLevel.HIGH,
        owner_team="t", app_owner_name="t",
        infrastructure_id=infra.id,
    )
    app_b = Application(
        id="app-dep-b", name="B",
        archetype=ArchetypeType.MODERN_MICROSERVICE,
        language="Python", runtime_version="3.11",
        criticality=CriticalityLevel.HIGH,
        owner_team="t", app_owner_name="t",
        infrastructure_id=infra.id,
    )
    dep = Dependency(
        id="dep-t-001",
        source_app_id=app_a.id,
        target_app_id=app_b.id,
        protocol="HTTPS",
        criticality=CriticalityLevel.HIGH,
    )

    session.add_all([infra, app_a, app_b, dep])
    session.flush()

    loaded = session.get(Dependency, "dep-t-001")
    assert loaded.source_app_id == "app-dep-a"
    assert loaded.target_app_id == "app-dep-b"
    assert loaded.criticality == CriticalityLevel.HIGH