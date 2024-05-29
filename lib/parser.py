from mpmath import mpc
from typing import *


def parse(expr: str) -> List[Tuple[mpc, int]]:
    expr = expr.replace(" ", "")
    if expr[0] != "+" and expr[0] != "-":
        expr = "+" + expr
    term_idx = []
    for i in range(len(expr)):
        if expr[i] == "+" or expr[i] == "-":
            term_idx.append(i)
    term_idx.append(len(expr))

    terms = []
    for i in range(len(term_idx) - 1):
        terms.append(expr[term_idx[i] : term_idx[i + 1]])

    to_ret = []
    for i in terms:
        to_ret.append(parse_term(i))
    return sorted(to_ret, key=lambda x: -x[1])


def parse_term(term: str) -> Tuple[mpc, mpc]:
    x_idx = term.find("x")
    if x_idx == -1:
        return (mpc(term), 0)

    if x_idx == 1:
        if term[0] == "+":
            coeff = mpc(1)
        else:
            coeff = mpc(-1)
    else:
        coeff = mpc(term[:x_idx].strip("*"))
    term = term[x_idx:]

    *_, exp = term.split("^")
    if exp == "x":
        return (coeff, 1)
    else:
        return (coeff, int(exp))
