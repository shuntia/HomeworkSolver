from mpmath import mpc


class Derivative:
    h = mpc(10) ** -100

    def __init__(self, func):
        self.func = func

    def calc(self, x):
        return (self.func(x + self.h) - self.func(x)) / self.h
