from uuid import uuid4
from datetime import date
from enum import Enum
from pydantic import BaseModel, Field
from typing import List, Optional

# =====================================================================
# 1. ENUMS (Pre-defined standard choices for our system)
# =====================================================================

class ArchetypeType(str, Enum):
    LEGACY_MONOLITH = "Legacy Monolith"
    MODERN_MICROSERVICE = "Modern Microservice"
    COTS_VENDOR = "Vendor COTS Application"
    INTERNAL_TOOL = "Internal Tool"
    COMPLIANCE_CRITICAL = "Compliance Critical"

class CriticalityLevel(str, Enum):
    LOW = "Low"
    MEDIUM = "Medium"
    HIGH = "High"
    MISSION_CRITICAL = "Mission Critical"

class SeverityLevel(str, Enum):
    LOW = "Low"
    MEDIUM = "Medium"
    HIGH = "High"
    CRITICAL = "Critical"

class EnvironmentType(str, Enum):
    ON_PREM_VM = "On-Prem VM"
    AWS_EC2 = "AWS EC2"
    AZURE_VM = "Azure VM"
    KUBERNETES = "Kubernetes"

class SixRDecision(str, Enum):
    REHOST = "Rehost"
    REPLATFORM = "Replatform"
    REFACTOR = "Refactor"
    RETIRE = "Retire"
    REPLACE = "Replace"
    RETAIN = "Retain"

# =====================================================================
# 2. PYDANTIC SCHEMAS (The structural blueprints for data validation)
# =====================================================================

class InfrastructureSchema(BaseModel):
    # Generates a random unique ID starting with 'infra-', e.g., infra-a1b2c3d4
    id: str = Field(default_factory=lambda: f"infra-{uuid4().hex[:8]}")
    environment_type: EnvironmentType
    os_name: str = Field(..., description="e.g., Windows Server 2012 R2 or RedHat Enterprise Linux 7")
    os_eol_date: date = Field(..., description="Date when vendor support ends")
    cpu_cores: int = Field(..., ge=1, description="Number of CPU cores allocated")
    memory_gb: int = Field(..., ge=1, description="Gigabytes of RAM allocated")
    location: str = Field(..., description="e.g., Hyderabad DataCenter, AWS ap-south-1")
    owner_team: str = Field(..., description="e.g., Windows Core OS Team, Cloud Infra Team")

    model_config = {"from_attributes": True}


class DependencySchema(BaseModel):
    id: str = Field(default_factory=lambda: f"dep-{uuid4().hex[:8]}")
    source_app_id: str = Field(..., description="The ID of the application making the call (Upstream)")
    target_app_id: str = Field(..., description="The ID of the application receiving the call (Downstream)")
    protocol: str = Field(..., description="e.g., HTTPS, gRPC, JDBC, MQ")
    criticality: CriticalityLevel = Field(default=CriticalityLevel.MEDIUM, description="How vital is this specific link?")

    model_config = {"from_attributes": True}


class ApplicationSchema(BaseModel):
    id: str = Field(default_factory=lambda: f"app-{uuid4().hex[:8]}")
    name: str = Field(..., description="e.g., Carbon Black App Control")
    archetype: ArchetypeType
    language: str = Field(..., description="e.g., C++, Python, Java")
    runtime_version: str = Field(..., description="e.g., .NET 4.5, Java 8")
    criticality: CriticalityLevel
    owner_team: str = Field(..., description="e.g., AppSec Infrastructure Team")
    app_owner_name: str = Field(..., description="The specific point of contact engineer, e.g., Rohith Parimi")
    
    # Foreign Key Link: Points directly to an Infrastructure ID
    infrastructure_id: str

    model_config = {"from_attributes": True}

class SecurityFindingSchema(BaseModel):
    id: str = Field(default_factory=lambda: f"vuln-{uuid4().hex[:8]}")
    application_id: str
    cve_id: str = Field(..., description="e.g., CVE-2023-38831")
    title: str = Field(..., description="e.g., WinRAR Remote Code Execution")
    severity: SeverityLevel
    cvss_score: float = Field(..., ge=0.0, le=10.0, description="CVSS v3 Score from 0.0 to 10.0")
    discovered_date: date
    
    # NEW FIELDS: Handling the fix logic
    remediation_available: bool = Field(default=False, description="Is there an official patch or upgrade available?")
    remediation_steps: Optional[str] = Field(None, description="e.g., Upgrade Carbon Black App Control to version 8.10")
    mitigation_status: Optional[str] = Field(None, description="e.g., Isolated from internet access, protected by network firewalls")

    model_config = {"from_attributes": True}


class OperationalMetricSchema(BaseModel):
    id: str = Field(default_factory=lambda: f"metric-{uuid4().hex[:8]}")
    application_id: str
    incidents_last_quarter: int = Field(default=0, ge=0, description="Total unexpected production outages")
    mttr_hours: float = Field(default=0.0, ge=0.0, description="Mean Time To Recovery in hours")
    availability_pct: float = Field(default=100.0, ge=0.0, le=100.0, description="Uptime percentage, e.g., 99.95")
    cpu_utilization_pct: float= Field(default=80.0, ge=0.0, le=100.0, description="CPU Utilization percentage, e.g., 85.5%" )

    model_config = {"from_attributes": True}

class WaveSchema(BaseModel):
    # e.g., wave-1, wave-2
    id: str = Field(default_factory=lambda: f"wave-{uuid4().hex[:4]}")
    wave_number: int = Field(..., ge=0, description="0 = Foundations, 1 = Migration Wave 1, etc.")
    theme: str = Field(..., description="e.g., Low-Hanging Fruit, Core Database Uplift, Legacy Retirements")
    target_start_date: date
    target_end_date: date

    model_config = {"from_attributes": True}


class RecommendationSchema(BaseModel):
    id: str = Field(default_factory=lambda: f"rec-{uuid4().hex[:8]}")
    application_id: str
    
    # AI Analysis Outputs
    readiness_score: int = Field(..., ge=0, le=100, description="Overall modernization readiness from 0 to 100")
    sixr_decision: SixRDecision
    confidence_score: float = Field(..., ge=0.0, le=1.0, description="AI confidence level in this decision (0.0 to 1.0)")
    
    # Business-ready Synthesis
    reasoning: str = Field(..., description="Plain-language explanation detailing the 'WHY' for the executive team")
    dependency_warnings: Optional[List[str]] = Field(default=[], description="Any downstream blast-radius alerts flagged by the AI")
    
    # The Schedule Link
    wave_id: Optional[str] = Field(None, description="Links this specific recommendation to a scheduled migration wave")

    model_config = {"from_attributes": True}