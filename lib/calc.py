from typing import *
from mpmath import mpc


def calc(expr: List[Tuple[mpc, int]], num: Union[mpc, int, float]):
    ans = mpc(0)
    for mul, powe in expr:
        ans += mul * mpc(num) ** powe
    return ans
