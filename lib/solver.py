import lib.derivative as derivative
import lib.calc as calc
import lib.divide as divide
from mpmath import mpc, mpf, nprint
from typing import *
from lib.polynomial import *


class newton:
    pass


class other:
    pass


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


def find_type(expr: poly):
    is_newton = True
    max_exponent = 0
    for i in range(1, len(expr.polynomial)):
        if expr.polynomial[i][1] > expr.polynomial[i - 1][1]:
            is_newton = False
    if is_newton:
        return newton()
    return other()


def solve(expr: poly):
    to_ret = []
    for i in range(1000):
        # print(expr.polynomial)
        if len(expr.polynomial) == 2 and expr.polynomial[0][1] <= 1:
            to_ret.append(-expr.polynomial[1][0] / expr.polynomial[0][0])
            return to_ret
        x_root = newton_method(lambda x: calc.calc(expr.polynomial, x), mpc(1, 1))
        if abs(x_root.real) < mpf("10") ** -20:
            x_root = mpc(0, x_root.imag)
        if abs(x_root.imag) < mpf("10") ** -20:
            x_root = mpc(x_root.real, 0)
        to_ret.append(x_root)
        expr = expr / poly([(mpc(1), 1), (-x_root, 0)])
        if expr.polynomial == None or (
            len(expr.polynomial) == 1 and expr.polynomial[0][1] == 0
        ):
            return to_ret
    raise Exception("Too many iterations.")
