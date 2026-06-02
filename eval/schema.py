from pydantic import BaseModel, Field
from api.schemas import SixRDecision

class Scenario(BaseModel):
    scenario_id: str
    category: str             # clear_rehost | clear_retire | clear_replace
    app_id: str               # pinned frozen ID from data/seed.sql
    expected_6r: SixRDecision
    acceptable_alternatives: list[SixRDecision]=Field(default_factory=list)
    must_mention_keywords: list[str]=Field(default_factory=list)
    rationale:str
    