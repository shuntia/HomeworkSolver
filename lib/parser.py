from mpmath import mpc
from typing import *


def parse(expr: str) -> List[Tuple[mpc, int]]:
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
    tmp = term.split("*")
    if len(tmp) == 1:
        return (mpc(tmp[0]), 0)
    else:
        tmp2 = tmp[1].split("^")
        if len(tmp2) == 1:
            return (mpc(tmp[0]), 1)
        else:
            return (mpc(tmp[0]), int(tmp2[1]))
