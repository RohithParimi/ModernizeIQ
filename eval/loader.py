import yaml
import pathlib
from eval.schema import Scenario

def load_scenarios(folder='eval/scenarios') -> list[Scenario]:
    """Scans and validates all scenario configuration files"""
    out=[]
    folder_path=pathlib.Path(folder)

    folder_path.mkdir(parents=True,exist_ok=True)

    for f in sorted(folder_path.glob("*.yaml")):
        out.append(Scenario(**yaml.safe_load(f.read_text())))
    return out