# eval/baseline.py
from eval.harness import RecResult
from api.schemas import SixRDecision, ArchetypeType
from db.session import SessionLocal
from db.models import Application, Infrastructure, OperationalMetric, SecurityFinding
from datetime import date

def baseline_recommender(app_id: str) -> RecResult:
    """A crude, non-AI rule engine that analyzes structural attributes to form decisions."""
    with SessionLocal() as s:
        app = s.get(Application, app_id)
        if not app:
            return RecResult(SixRDecision.RETAIN, "Application record missing.")
            
        infra = s.get(Infrastructure, app.infrastructure_id)
        om = s.query(OperationalMetric).filter_by(application_id=app_id).first()
        cves = s.query(SecurityFinding).filter_by(application_id=app_id).count()

    # Calculate infrastructure expiration date relative to our frozen target date
    eol = infra.os_eol_date < date(2026, 5, 1) if infra and infra.os_eol_date else False
    incidents = om.incidents_last_quarter if om else 0

    if app.archetype == ArchetypeType.INTERNAL_TOOL and incidents == 0:
        return RecResult(SixRDecision.RETIRE, "Low corporate usage, redundant capability, operational cost exceeds business value.")
        
    if app.archetype == ArchetypeType.MODERN_MICROSERVICE and cves <= 1:
        return RecResult(SixRDecision.RETAIN, "Modern microservice running on cloud-native container nodes, clean security profile.")
        
    if app.archetype == ArchetypeType.COTS_VENDOR:
        return RecResult(SixRDecision.REPLACE, "Standard vendor product. Commodity SaaS alternatives exist on the market.")
        
    if eol and cves >= 3:
        return RecResult(SixRDecision.REFACTOR, "Critical risk footprint. Outdated EOL operating system layer paired with excessive active CVE counts requires structural refactoring.")
        
    return RecResult(SixRDecision.REHOST, "Low operational complexity. Ideal candidate for an immediate lift-and-shift infrastructure relocation.")