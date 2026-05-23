# scripts/seed.py
"""
Foundation seed: inserts the Carbon Black anchor app + its infrastructure host.
Uses SQLAlchemy + the Alembic-managed schema. Safe to re-run — uses merge()
so existing rows are updated rather than duplicated.
"""
from datetime import date
import os
import sys
project_root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
if project_root not in sys.path:
    sys.path.append(project_root)

from db.session import SessionLocal
from db.models import Infrastructure, Application
from api.schemas import (
    EnvironmentType,
    ArchetypeType,
    CriticalityLevel,
)


def seed_initial_data():
    print("Connecting via SQLAlchemy session...")

    with SessionLocal() as session:
        # Infrastructure host running an EOL Windows Server
        infra = Infrastructure(
            id="infra-cb-prod",
            environment_type=EnvironmentType.ON_PREM_VM,
            os_name="Windows Server 2012 R2",
            os_eol_date=date(2023, 10, 10),
            cpu_cores=8,
            memory_gb=32,
            location="Hyderabad DataCenter",
            owner_team="Windows Core OS Team",
        )

        # Carbon Black App Control running on that host
        app = Application(
            id="app-carbon-black",
            name="Carbon Black App Control",
            archetype=ArchetypeType.COTS_VENDOR,
            language="C++",
            runtime_version="8.5.x",
            criticality=CriticalityLevel.MISSION_CRITICAL,
            owner_team="AppSec Infrastructure Team",
            app_owner_name="Rohith Parimi",
            infrastructure_id=infra.id,
        )

        # merge() = INSERT if id is new, UPDATE if id exists. Idempotent — you
        # can run this script as many times as you want without duplicate-key errors.
        session.merge(infra)
        session.merge(app)
        session.commit()

        print(f"Seeded: {infra.id} ({infra.os_name}) -> {app.id} ({app.name})")


if __name__ == "__main__":
    seed_initial_data()