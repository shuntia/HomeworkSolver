from mpmath import mpc
from typing import *
from lib.polynomial import poly

def parse(expr: str) -> poly:
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

    to_ret = poly([])
    for i in terms:
        to_ret.polynomial.append(parse_term(i))
    simplified=simplify(poly(sorted(to_ret.polynomial, key=lambda x: -x[1])))
    return poly(simplified)

def simplify(terms: poly) -> poly:
    to_ret = poly([])
    to_append=mpc(0,0)
    current_exponent=terms.polynomial[0][1]
    for i in terms.polynomial:
        if i[1]==current_exponent:
            to_append+=i[0]
        else:
            to_ret.polynomial.append([to_append, current_exponent])
            current_exponent=i[1]
            to_append=i[0]
    to_ret.polynomial.append([to_append, current_exponent])
    return sorted(to_ret.polynomial, key=lambda x: -x[1])


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
