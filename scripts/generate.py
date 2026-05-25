"""
scripts/generate.py
Generates a synthetc enterprise portfolio: infrastructue+ applications +
dependencies+ security findings + operational metrics. Reproducible via fixed RNG(Random Number Generator) seed.

Usage:
   uv run python scripts/generate.py                 # default:50 , seed=42
   uv run python scripts/generate.py --wipe          # wipe DB first
   uv run python scripts/generate.py --n 100         # different size
   uv run python scripts/generate.py --seed 999      # different portfolio 
"""

import argparse
import random
from datetime import date, timedelta
from typing import List
import os
import sys

from faker import Faker
from sqlalchemy.orm import session

project_root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
if project_root not in sys.path:
    sys.path.append(project_root)

from db.session import SessionLocal
from db.models import Infrastructure,Application
from api.schemas import(
    EnvironmentType,ArchetypeType,CriticalityLevel
)

#Archetype distribution - weights drawn from data_design.md

ARCHETYPE_WEIGHTS= [
    (ArchetypeType.LEGACY_MONOLITH,     0.30),
    (ArchetypeType.MODERN_MICROSERVICE, 0.25),
    (ArchetypeType.COTS_VENDOR,         0.20),
    (ArchetypeType.INTERNAL_TOOL,       0.15),
    (ArchetypeType.COMPLIANCE_CRITICAL,  0.10),
]

def pick_archetype(rng: random.Random) -> ArchetypeType:
    """Weighted random archetype selection."""
    archetypes, weights =zip(*ARCHETYPE_WEIGHTS)
    return rng.choices(archetypes,weights=weights,k=1)[0]

def make_infra(archetype: ArchetypeType, rng: random.Random, fake: Faker) -> Infrastructure:
    """One Infrastructure row per archetype, with realistic value ranges from data_design.md"""
    
    # Generate a reproducible unique short key matching your database structure
    infra_id = f"infra-{fake.uuid4()[:8]}"
    
    if archetype == ArchetypeType.LEGACY_MONOLITH:
        # Legacy Monolith: Ancient operating systems that are already past their End-Of-Life dates
        os_options = [
            ("Windows Server 2008 R2", date(2020, 1, 14)),
            ("Windows Server 2012 R2", date(2023, 10, 10)),
            ("RedHat Enterprise Linux 6", date(2020, 11, 30)),
        ]
        os_name, eol_date = rng.choice(os_options)
        
        return Infrastructure(
            id=infra_id,
            environment_type=EnvironmentType.ON_PREM_VM, # Heavily anchored to traditional setups
            os_name=os_name,
            os_eol_date=eol_date,
            cpu_cores=rng.choice([8, 16, 32]),          # Massive unoptimized footprints
            memory_gb=rng.choice([32, 64, 128]),
            location=rng.choice(["Hyderabad DC", "Mumbai DC", "On-Prem East"]),
            owner_team="Windows Core OS Team"
        )

    elif archetype == ArchetypeType.MODERN_MICROSERVICE:
        # Modern Microservice: Fully cloud-native, right-sized, running on container clusters
        return Infrastructure(
            id=infra_id,
            environment_type=EnvironmentType.KUBERNETES,
            os_name="Ubuntu Server 22.04 LTS",
            os_eol_date=date(2027, 4, 30),              # Safely inside vendor support windows
            cpu_cores=rng.choice([1, 2, 4]),             # Small distributed horizontal nodes
            memory_gb=rng.choice([2, 4, 8]),
            location="AWS ap-south-1 (EKS)",
            owner_team="Cloud Platform Engineering"
        )

    elif archetype == ArchetypeType.COTS_VENDOR:
        # Vendor COTS: Heavy standard platforms, usually running on enterprise-tier virtual machines
        os_options = [
            ("Windows Server 2019", date(2029, 1, 9)),
            ("RedHat Enterprise Linux 7", date(2024, 6, 30)),
        ]
        os_name, eol_date = rng.choice(os_options)
        
        return Infrastructure(
            id=infra_id,
            environment_type=EnvironmentType.ON_PREM_VM,
            os_name=os_name,
            os_eol_date=eol_date,
            cpu_cores=rng.choice([4, 8]),                # Moderate, static allocation footprint
            memory_gb=rng.choice([16, 32, 64]),
            location=rng.choice(["Hyderabad DC", "AWS ap-south-1 (EC2)"]),
            owner_team="Enterprise Systems Hosting"
        )

    elif archetype == ArchetypeType.INTERNAL_TOOL:
        # Internal Tool: Low-cost infrastructure where resource conservation is key
        return Infrastructure(
            id=infra_id,
            environment_type=EnvironmentType.ON_PREM_VM,
            os_name="Debian 11",
            os_eol_date=date(2026, 6, 30),
            cpu_cores=rng.choice([1, 2]),                 # Smallest profile available 
            memory_gb=rng.choice([2, 4]),
            location="Shared Internal Support Cluster",
            owner_team="IT Infrastructure Support"
        )

    elif archetype == ArchetypeType.COMPLIANCE_CRITICAL:
        # Compliance Critical: Isolated, heavily hardened dedicated computing modules
        return Infrastructure(
            id=infra_id,
            environment_type=EnvironmentType.ON_PREM_VM,   # Kept on-prem for high-security isolation rules
            os_name="Hardened RedHat Enterprise Linux 8",
            os_eol_date=date(2029, 5, 31),
            cpu_cores=rng.choice([8, 16]),
            memory_gb=rng.choice([32, 64]),
            location="Isolated Secure Vault Zone",
            owner_team="SecOps Core Infrastructure"
        )

    else:
        raise ValueError(f"Unknown architectural classification archetype: {archetype}")

def make_app(archetype: ArchetypeType, infra: Infrastructure, rng: random.Random, fake: Faker) -> Application:
    """One application row, linked to its infrastructure host with realistic stack mappings."""
    
    app_id = f"app-{fake.uuid4()[:8]}"
    
    # Generate realistic corporate department names for ownership
    business_units = ["Global Wealth Management", "Core Banking Platform", "Enterprise Risk Ops", "Digital Channel Delivery", "Supply Chain Logistics", "HR Services Tech"]
    owner_team = f"{rng.choice(business_units)} DevTeam"
    app_owner_name = fake.name()

    if archetype == ArchetypeType.LEGACY_MONOLITH:
        # Monoliths: Heavy back-office names, old enterprise tech
        app_names = ["GlobalPayrollEngine", "CoreBillingLedger", "MainframeSettlementWrapper", "LegacyClearingHouse", "PolicyBatchProcessor"]
        name = f"{rng.choice(app_names)}-{rng.randint(100, 999)}"
        
        # Mapping ancient runtimes to match our past EOL OS layers
        tech_stack = rng.choice([
            ("Java 6", "1.6.0_45"),
            ("Java 7", "1.7.0_80"),
            (".NET Framework 4.0", "4.0.30319"),
            ("C++ / MFC", "Native v140"),
            ("COBOL", "IBM Enterprise v4.2")
        ])
        language, runtime_version = tech_stack
        
        return Application(
            id=app_id,
            name=name,
            archetype=archetype,
            language=language,
            runtime_version=runtime_version,
            # Monoliths run core operations, so they are rarely "Low" criticality
            criticality=rng.choices(
                [CriticalityLevel.MISSION_CRITICAL, CriticalityLevel.HIGH, CriticalityLevel.MEDIUM],
                weights=[0.40, 0.50, 0.10],
                k=1
            )[0],
            owner_team=owner_team,
            app_owner_name=app_owner_name,
            infrastructure_id=infra.id
        )

    elif archetype == ArchetypeType.MODERN_MICROSERVICE:
        # Microservices: Lightweight, domain-driven names, cloud-native tech stacks
        domains = ["auth", "payment-api", "user-profile", "notification", "analytics", "cart-service"]
        name = f"svc-{rng.choice(domains)}-{fake.word()}"
        
        tech_stack = rng.choice([
            ("Python", "3.11.5"),
            ("Go", "1.21.4"),
            ("Node.js", "v20.9.0"),
            ("Java 21", "Spring Boot 3.2.0")
        ])
        language, runtime_version = tech_stack
        
        return Application(
            id=app_id,
            name=name,
            archetype=archetype,
            language=language,
            runtime_version=runtime_version,
            # Microservices are distributed, meaning individual ones range across all criticalities
            criticality=rng.choices(
                [CriticalityLevel.HIGH, CriticalityLevel.MEDIUM, CriticalityLevel.LOW],
                weights=[0.20, 0.50, 0.30],
                k=1
            )[0],
            owner_team="Digital Engineering Hub", # Usually central cloud teams run these
            app_owner_name=app_owner_name,
            infrastructure_id=infra.id
        )

    elif archetype == ArchetypeType.COTS_VENDOR:
        # Vendor COTS: Recognizable enterprise-grade commercial platforms
        vendor_products = [
            ("SAP ERP Central Component", "ECC 6.0 EHP8"),
            ("Tivoli Identity Manager", "v7.0.1"),
            ("Carbon Black App Control", "v8.9.2"),
            ("Oracle Access Manager", "12c R2"),
            ("Informatica PowerCenter", "v10.5")
        ]
        name, runtime_version = rng.choice(vendor_products)
        
        return Application(
            id=app_id,
            name=name,
            archetype=archetype,
            language="Pre-compiled Binary",
            runtime_version=runtime_version,
            # Vendors run heavy operational lifting
            criticality=rng.choices(
                [CriticalityLevel.MISSION_CRITICAL, CriticalityLevel.HIGH],
                weights=[0.60, 0.40],
                k=1
            )[0],
            owner_team="Enterprise Vendor Applications Team",
            app_owner_name=app_owner_name,
            infrastructure_id=infra.id
        )

    elif archetype == ArchetypeType.INTERNAL_TOOL:
        # Internal Tools: Practical administrative utility names, simple open-source setups
        tools = ["AssetTracker", "OfficeFloorMapper", "SurveyCollector", "ShiftScheduler", "TechSupportLogs"]
        name = f"Internal-{rng.choice(tools)}"
        
        tech_stack = rng.choice([
            ("PHP", "7.4.33 (Legacy)"),
            ("Python (Flask)", "2.3.2"),
            ("JavaScript (Express)", "4.18.2")
        ])
        language, runtime_version = tech_stack
        
        return Application(
            id=app_id,
            name=name,
            archetype=archetype,
            language=language,
            runtime_version=runtime_version,
            criticality=CriticalityLevel.LOW, # Internal tools are strictly low business risk
            owner_team="Corporate IT Utilities",
            app_owner_name=app_owner_name,
            infrastructure_id=infra.id
        )

    elif archetype == ArchetypeType.COMPLIANCE_CRITICAL:
        # Compliance Critical: High-security ledger or audit terminology
        secure_apps = ["AuditTrailVault", "KyvValidationLedger", "PciTransactionTunnel", "HipaaRecordEncryptor"]
        name = f"Secure-{rng.choice(secure_apps)}"
        
        tech_stack = rng.choice([
            ("Java 17", "OpenJDK 17.0.9 (Hardened)"),
            ("C# / .NET 8", "v8.0.100")
        ])
        language, runtime_version = tech_stack
        
        return Application(
            id=app_id,
            name=name,
            archetype=archetype,
            language=language,
            runtime_version=runtime_version,
            criticality=CriticalityLevel.MISSION_CRITICAL, # Enforced by spec
            owner_team="SecOps Risk Compliance Engineering",
            app_owner_name=app_owner_name,
            infrastructure_id=infra.id
        )

    else:
        raise ValueError(f"Unknown archetype mapped: {archetype}")

def wipe(session: session) -> None:
    """Delete all generated data in a dependency-safe order to prevent Foreign Key constraint crashes."""
    print("🧹 Wiping database portfolio records safely...")
    
    # Safely import all existing models from your DB structure
    # (Adjust these model class names if they vary slightly in your db/models.py file)
    from db.models import (
        Dependency, 
        SecurityFinding, 
        OperationalMetric,
        Recommendation, 
        Wave, 
        Application, 
        Infrastructure,
    )
    
    try:
        # Step 1: Drop Level 3 tables (Metrics and deep analytical recommendations)
        print(" -> Clearing Recommendation records...")
        session.query(Recommendation).delete()
        
        # Step 2: Drop Level 2 tables (Attributes directly childed to Application)
        print(" -> Clearing SecurityFinding, OperationalMetric, and Dependency networks...")
        session.query(SecurityFinding).delete()
        session.query(OperationalMetric).delete()
        session.query(Dependency).delete()
        
        # Step 3: Drop Level 1 tables (The Wave timeline, which links to recommendations)
        print(" -> Clearing Wave schedules...")
        session.query(Wave).delete()
        
        # Step 4: Drop the Core Application layer
        print(" -> Clearing Application rows...")
        session.query(Application).delete()
        
        # Step 5: Finally, safely drop the Infrastructure layer (The ultimate parent)
        print(" -> Clearing Infrastructure host foundations...")
        session.query(Infrastructure).delete()
        
        print("✨ Database completely cleared and set to a clean state.")
        
    except Exception as e:
        print(f"❌ CRITICAL error during wipe execution sequence: {str(e)}")
        session.rollback()
        raise e
    
def generate_portfolio(n: int = 50, seed: int = 42, do_wipe: bool = False) -> None:
    """Orchestrates generation using fixed seeds to validate contract models."""
    rng = random.Random(seed)
    fake = Faker()
    fake.seed_instance(seed)

    print(f"⚙️ Initializing Portfolio Generation Engine (Seed: {seed})...")
    
    with SessionLocal() as session:
        if do_wipe:
            wipe(session)
            session.commit()

        print(f"🚀 Injecting {n} synthetic architectural profiles into pgvector_db...")
        
        apps: List[Application] = []
        for _ in range(n):
            archetype = pick_archetype(rng)
            
            # 1. Generate the baseline data points via our archetype logic
            infra_row = make_infra(archetype, rng, fake)
            app_row = make_app(archetype, infra_row, rng, fake)
            
            # 2. Stage them in the session in parent -> child order
            session.add(infra_row)
            session.add(app_row)
            apps.append(app_row)

        # Bulk commit everything over the database network pipe
        session.commit()
        print(f"🎉 SUCCESS: Seeded {n} infrastructure + {n} application rows structurally matching specifications.")


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--n", type=int, default=50)
    parser.add_argument("--seed", type=int, default=42)
    parser.add_argument("--wipe", action="store_true")
    args = parser.parse_args()
    
    generate_portfolio(n=args.n, seed=args.seed, do_wipe=args.wipe)