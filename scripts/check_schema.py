# scripts/check_schema.py
import os
import sys
from datetime import date, timedelta

# Dynamically calculate the project root directory and add it to Python's search lane
project_root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
if project_root not in sys.path:
    sys.path.append(project_root)

from api.schemas import (
    InfrastructureSchema,
    ApplicationSchema,
    DependencySchema,
    SecurityFindingSchema,
    OperationalMetricSchema,
    WaveSchema,
    RecommendationSchema,
    EnvironmentType,
    ArchetypeType,
    CriticalityLevel,
    SeverityLevel,
    SixRDecision
)

def run_integration_smoke_test():
    print("🚀 Starting ModernizeIQ Week 2 Schema Integration Pass...")
    
    try:
        # 1. Instantiate Infrastructure
        infra = InfrastructureSchema(
            environment_type=EnvironmentType.ON_PREM_VM,
            os_name="Windows Server 2012 R2",
            os_eol_date=date(2023, 10, 10),
            cpu_cores=8,
            memory_gb=32,
            location="Hyderabad DataCenter",
            owner_team="Windows Core OS Team"
        )
        print(f"✅ Step 1: Infrastructure parsed successfully. ID: {infra.id}")

        # 2. Instantiate Application (Linked to Infra)
        app = ApplicationSchema(
            name="Carbon Black App Control",
            archetype=ArchetypeType.COTS_VENDOR,
            language="C++ / Native",
            runtime_version="8.5.x",
            criticality=CriticalityLevel.MISSION_CRITICAL,
            owner_team="AppSec Infrastructure Team",
            app_owner_name="Rohith Parimi",
            infrastructure_id=infra.id
        )
        print(f"✅ Step 2: Application parsed successfully. ID: {app.id}")

        # 3. Instantiate Dependency (Self-referential link mimicking a downstream app)
        dep = DependencySchema(
            source_app_id="app-some-upstream-web-ui",
            target_app_id=app.id,
            protocol="HTTPS",
            criticality=CriticalityLevel.HIGH
        )
        print(f"✅ Step 3: Dependency Link parsed successfully. ID: {dep.id}")

        # 4. Instantiate Security Finding
        vuln = SecurityFindingSchema(
            application_id=app.id,
            cve_id="CVE-2023-38831",
            title="WinRAR Remote Code Execution Vulnerability",
            severity=SeverityLevel.CRITICAL,
            cvss_score=9.8,
            discovered_date=date(2025, 4, 15),
            reremediation_available=False,
            mitigation_status="Isolated from direct public routing lanes"
        )
        print(f"✅ Step 4: Security Finding parsed successfully. ID: {vuln.id}")

        # 5. Instantiate Operational Telemetry
        metric = OperationalMetricSchema(
            application_id=app.id,
            incidents_last_quarter=4,
            mttr_hours=6.5,
            availability_pct=98.45,
            cpu_utilization_pct=88.5  # Your custom custom field addition!
        )
        print(f"✅ Step 5: Operational Metrics parsed successfully. ID: {metric.id}")

        # 6. Instantiate Wave Schedule
        wave = WaveSchema(
            wave_number=1,
            theme="Legacy Operating System Migration & Security Isolation",
            target_start_date=date(2026, 6, 1),
            target_end_date=date(2026, 6, 30)
        )
        print(f"✅ Step 6: Wave Schedule parsed successfully. ID: {wave.id}")

        # 7. Instantiate Final Recommendation (Binding all layers together)
        rec = RecommendationSchema(
            application_id=app.id,
            readiness_score=35,
            sixr_decision=SixRDecision.REPLATFORM,
            confidence_score=0.92,
            reasoning=(
                f"Application '{app.name}' is highly vulnerable due to running on an EOL host OS "
                f"({infra.os_name}) with {vuln.cve_id}. High resource allocation of {infra.memory_gb}GB "
                f"RAM can be optimized by Replatforming to a managed secure cluster instance."
            ),
            dependency_warnings=[f"Alert: Upstream dependency link {dep.id} must be updated during migration."],
            wave_id=wave.id
        )
        print(f"✅ Step 7: Final Recommendation Output parsed successfully. ID: {rec.id}")

        print("\n=======================================================")
        print("🎉 SUCCESS: ALL 7 DATA SCHEMAS COMPATIBLE & INTEGRATED!")
        print("=======================================================")
        
    except Exception as e:
        print(f"\n❌ CRITICAL: Schema Integration Failure spotted: {str(e)}")

if __name__ == "__main__":
    run_integration_smoke_test()