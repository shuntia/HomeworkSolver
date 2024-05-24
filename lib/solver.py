import lib.derivative as derivative
import lib.calc as calc
import lib.divide as divide
from mpmath import mpc, mpf, nprint
from typing import *


def newton_method(func, x0: mpc):
    EPS = mpf("10") ** -100
    df = derivative.Derivative(func)

    for _ in range(100):
        if df.calc(x0) == mpc(0):
            break
        x_new = mpc(x0 - func(x0) / df.calc(x0))
        if abs(func(x_new)) < EPS:
            break
        x0 = x_new

    return x0


def solve(expr: List[Tuple[mpc, int]]):
    to_ret = []
    for i in range(1000):
        # print(expr)
        if len(expr) == 2 and expr[0][1] == 1:
            to_ret.append(-expr[1][0] / expr[0][0])
            return to_ret
        x_root = newton_method(lambda x: calc.calc(expr, x), mpc(1, 1))
        if abs(x_root.real) < mpf("10") ** -20:
            x_root = mpc(0, x_root.imag)
        if abs(x_root.imag) < mpf("10") ** -20:
            x_root = mpc(x_root.real, 0)
        to_ret.append(x_root)
        expr = divide.divide(expr, [(mpc(1), 1), (-x_root, 0)])
        if expr == None or (len(expr) == 1 and expr[0][1] == 0):
            return to_ret
