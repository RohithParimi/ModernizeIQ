# agents/context.py
from db.session import SessionLocal
from db.models import Application, Infrastructure, OperationalMetric, SecurityFinding, Dependency
from api.schemas import ApplicationContext

def build_application_context(app_id: str) -> ApplicationContext:
    """
    Queries distinct tables in the migration portfolio database and compiles 
    an application's complete contextual telemetry envelope.
    """
    with SessionLocal() as session:
        # Validate primary application existence
        app = session.get(Application, app_id)
        if not app:
            raise ValueError(f"No application found matching id: {app_id}")
            
        # Compile linked sub-entities
        infra = session.get(Infrastructure, app.infrastructure_id)
        metrics = session.query(OperationalMetric).filter_by(application_id=app_id).first()
        security_findings = session.query(SecurityFinding).filter_by(application_id=app_id).all()
        dependencies_out = session.query(Dependency).filter_by(source_app_id=app_id).all()
        
        # Hydrate and return unified context payload
        return ApplicationContext.model_validate({
            "application": app,
            "infrastructure": infra,
            "metrics": metrics,
            "security_findings": security_findings,
            "dependencies_out": dependencies_out,
        })