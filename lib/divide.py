from typing import *
from mpmath import mpc


# b must be linear and a must be divisible by b
def divide(a: List[Tuple[mpc, int]], b: List[Tuple[mpc, int]]):
    if len(a) < 2:
        return None
    term_cnt = {i[1] for i in a}
    for i in range(max(term_cnt)):
        if i not in term_cnt:
            a.append((0, i))
    a.sort(key=lambda x: -x[1])
    to_ret = []
    now = [a[0], a[1]]
    for i in range(len(a) - 1):
        to_ret.append((now[0][0] / b[0][0], now[0][1] - b[0][1]))
        now[1] = (now[1][0] - b[1][0] * (now[0][0] / b[0][0]), now[1][1])
        if i != len(a) - 2:
            now.append(a[i + 2])
        now.pop(0)
    return to_ret
