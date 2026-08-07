import importlib.util
from pathlib import Path

_spec = importlib.util.spec_from_file_location(
    "math_mod", Path(__file__).resolve().parent.parent / "math.py"
)
_math_mod = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(_math_mod)
add = _math_mod.add


def test_add():
    assert add(2, 2) == 4


def test_add_neg():
    assert add(-1, 1) == 0
