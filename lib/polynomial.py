from mpmath import mpc
from typing import *

class poly:
    def __init__(self, expr: List[Tuple[mpc, int]]):
        self.polynomial = expr
    def __truediv__(self, other):
        if len(self.polynomial) < 2:
            raise ValueError("Polynimial is too small to divide")
        if len(other.polynomial) != 2:
            raise ValueError("Divisor must be binomial")
        term_cnt = {i[1] for i in self.polynomial}
        for i in range(max(term_cnt)):
            if i not in term_cnt:
                self.polynomial.append((0, i))
        self.polynomial.sort(key=lambda x: -x[1])
        to_ret = []
        now = [self.polynomial[0], self.polynomial[1]]
        for i in range(len(self.polynomial) - 1):
            to_ret.append((now[0][0] / other.polynomial[0][0], now[0][1] - other.polynomial[0][1]))
            now[1] = (now[1][0] - other.polynomial[1][0] * (now[0][0] / other.polynomial[0][0]), now[1][1])
            if i != len(self.polynomial) - 2:
                now.append(self.polynomial[i + 2])
            now.pop(0)
        return to_ret
    def __str__(self):
        strexpr=""
        for i in self.polynomial:
            if i[0].real<0:
                strexpr.append("-")
            strexpr+=str(i[0].real)
            if i[0].imag<0:
                strexpr.append("-")
            else:
                strexpr.append("+")
            strexpr+=str(i[0].imag)+"i)"
            strexpr+="**"+str(i[1])
        return strexpr