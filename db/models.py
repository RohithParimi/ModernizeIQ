# db/models.py
from datetime import date
from typing import Optional, List

from sqlalchemy import (
    String, Integer, Float, Date, Text, ForeignKey,
    Enum as SQLEnum,
)
from sqlalchemy.dialects.postgresql import ARRAY
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column, relationship

# Reuse the enums you already defined in the API schema layer.
# Single source of truth — the same enum drives both validation (Pydantic)
# and the database column type (SQLAlchemy).
from api.schemas import (
    ArchetypeType,
    CriticalityLevel,
    SeverityLevel,
    EnvironmentType,
    SixRDecision,
)


class Base(DeclarativeBase):
    """Parent class for every SQLAlchemy model. Alembic introspects this."""
    pass


class Infrastructure(Base):
    __tablename__ = "infrastructure"

    id: Mapped[str] = mapped_column(String(50), primary_key=True)
    environment_type: Mapped[EnvironmentType] = mapped_column(SQLEnum(EnvironmentType))
    os_name: Mapped[str] = mapped_column(String(100))
    os_eol_date: Mapped[date] = mapped_column(Date)
    cpu_cores: Mapped[int] = mapped_column(Integer)
    memory_gb: Mapped[int] = mapped_column(Integer)
    location: Mapped[str] = mapped_column(String(100))
    owner_team: Mapped[str] = mapped_column(String(100))

    # An infra host can carry many applications
    applications: Mapped[List["Application"]] = relationship(
        back_populates="infrastructure"
    )


class Application(Base):
    __tablename__ = "applications"

    id: Mapped[str] = mapped_column(String(50), primary_key=True)
    name: Mapped[str] = mapped_column(String(100))
    archetype: Mapped[ArchetypeType] = mapped_column(SQLEnum(ArchetypeType))
    language: Mapped[str] = mapped_column(String(50))
    runtime_version: Mapped[str] = mapped_column(String(50))
    criticality: Mapped[CriticalityLevel] = mapped_column(SQLEnum(CriticalityLevel))
    owner_team: Mapped[str] = mapped_column(String(100))
    app_owner_name: Mapped[str] = mapped_column(String(100))

    infrastructure_id: Mapped[str] = mapped_column(ForeignKey("infrastructure.id"))

    # Navigation in both directions
    infrastructure: Mapped["Infrastructure"] = relationship(back_populates="applications")
    security_findings: Mapped[List["SecurityFinding"]] = relationship(
        back_populates="application", cascade="all, delete-orphan"
    )
    operational_metrics: Mapped[List["OperationalMetric"]] = relationship(
        back_populates="application", cascade="all, delete-orphan"
    )
    recommendation: Mapped[Optional["Recommendation"]] = relationship(
        back_populates="application", uselist=False
    )

    # Dependencies where THIS app is calling something else (upstream→)
    outgoing_dependencies: Mapped[List["Dependency"]] = relationship(
        foreign_keys="Dependency.source_app_id",
        back_populates="source_app",
        cascade="all, delete-orphan",
    )
    # Dependencies where THIS app is being called by something else (→downstream)
    incoming_dependencies: Mapped[List["Dependency"]] = relationship(
        foreign_keys="Dependency.target_app_id",
        back_populates="target_app",
        cascade="all, delete-orphan",
    )


class Dependency(Base):
    __tablename__ = "dependencies"

    id: Mapped[str] = mapped_column(String(50), primary_key=True)
    source_app_id: Mapped[str] = mapped_column(ForeignKey("applications.id"))
    target_app_id: Mapped[str] = mapped_column(ForeignKey("applications.id"))
    protocol: Mapped[str] = mapped_column(String(20))
    criticality: Mapped[CriticalityLevel] = mapped_column(
        SQLEnum(CriticalityLevel), default=CriticalityLevel.MEDIUM
    )

    # Because both relationships go to the same table (applications),
    # we have to spell out which FK column powers each one.
    source_app: Mapped["Application"] = relationship(
        foreign_keys=[source_app_id],
        back_populates="outgoing_dependencies",
    )
    target_app: Mapped["Application"] = relationship(
        foreign_keys=[target_app_id],
        back_populates="incoming_dependencies",
    )


class SecurityFinding(Base):
    __tablename__ = "security_findings"

    id: Mapped[str] = mapped_column(String(50), primary_key=True)
    application_id: Mapped[str] = mapped_column(ForeignKey("applications.id"))
    cve_id: Mapped[str] = mapped_column(String(30))
    title: Mapped[str] = mapped_column(String(200))
    severity: Mapped[SeverityLevel] = mapped_column(SQLEnum(SeverityLevel))
    cvss_score: Mapped[float] = mapped_column(Float)
    discovered_date: Mapped[date] = mapped_column(Date)
    remediation_available: Mapped[bool] = mapped_column(default=False)
    remediation_steps: Mapped[Optional[str]] = mapped_column(Text, nullable=True)
    mitigation_status: Mapped[Optional[str]] = mapped_column(Text, nullable=True)

    application: Mapped["Application"] = relationship(back_populates="security_findings")


class OperationalMetric(Base):
    __tablename__ = "operational_metrics"

    id: Mapped[str] = mapped_column(String(50), primary_key=True)
    application_id: Mapped[str] = mapped_column(ForeignKey("applications.id"))
    incidents_last_quarter: Mapped[int] = mapped_column(Integer, default=0)
    mttr_hours: Mapped[float] = mapped_column(Float, default=0.0)
    availability_pct: Mapped[float] = mapped_column(Float, default=100.0)
    cpu_utilization_pct: Mapped[float] = mapped_column(Float, default=80.0)

    application: Mapped["Application"] = relationship(back_populates="operational_metrics")


class Wave(Base):
    __tablename__ = "waves"

    id: Mapped[str] = mapped_column(String(50), primary_key=True)
    wave_number: Mapped[int] = mapped_column(Integer)
    theme: Mapped[str] = mapped_column(String(200))
    target_start_date: Mapped[date] = mapped_column(Date)
    target_end_date: Mapped[date] = mapped_column(Date)

    recommendations: Mapped[List["Recommendation"]] = relationship(back_populates="wave")


class Recommendation(Base):
    __tablename__ = "recommendations"

    id: Mapped[str] = mapped_column(String(50), primary_key=True)
    application_id: Mapped[str] = mapped_column(ForeignKey("applications.id"))
    readiness_score: Mapped[int] = mapped_column(Integer)
    sixr_decision: Mapped[SixRDecision] = mapped_column(SQLEnum(SixRDecision))
    confidence_score: Mapped[float] = mapped_column(Float)
    reasoning: Mapped[str] = mapped_column(Text)
    dependency_warnings: Mapped[List[str]] = mapped_column(
        ARRAY(String), default=list
    )
    wave_id: Mapped[Optional[str]] = mapped_column(ForeignKey("waves.id"), nullable=True)

    application: Mapped["Application"] = relationship(back_populates="recommendation")
    wave: Mapped[Optional["Wave"]] = relationship(back_populates="recommendations")