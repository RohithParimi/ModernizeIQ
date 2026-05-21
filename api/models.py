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

# =====================================================================
# 2. PYDANTIC SCHEMAS (The structural blueprints for data validation)
# =====================================================================

class InfrastructureSchema(BaseModel):
    id: str = Field(default_factory=lambda: f"infra-{uuid4().hex[:8]}")
    os_name: str = Field(..., description="e.g., Windows Server 2012 R2")
    os_eol_date: date = Field(..., description="Date when vendor support ends")
    environment_type: str = Field(..., description="e.g., On-Prem VM, AWS EC2, Azure VM")

    class Config:
        from_attributes = True


class ApplicationSchema(BaseModel):
    id: str = Field(default_factory=lambda: f"app-{uuid4().hex[:8]}")
    name: str = Field(..., description="e.g., Carbon Black App Control")
    archetype: ArchetypeType
    language: str = Field(..., description="e.g., C++, Python, C#")
    runtime_version: str = Field(..., description="e.g., .NET 4.5, Java 8")
    criticality: CriticalityLevel
    owner_team: str = Field(..., description="e.g., AppSec Infrastructure Team")
    
    # This links the application directly to the infrastructure it runs on (Foreign Key concept)
    infrastructure_id: str

    class Config:
        from_attributes = True