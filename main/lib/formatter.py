from mpmath import mpc, nstr


def formatter(n: mpc):
    return nstr(n).replace("j", " i")[1:-1]
