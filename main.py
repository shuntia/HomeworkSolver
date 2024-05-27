import sys
import os
import argparse
import lib.parser
import lib.calc
import lib.solver
import mpmath

mpmath.mp.prec = 3333
mpmath.mp.dps = 1000


# expression = "5*x^3-4*x^2+1*x-10"

# parsed_expression = lib.parser.parse(expression)
# lib.solver.solve(parsed_expression)

sys.stdout.write("This is the polynomial solver for the Algebra 2 Honors class.")
pars = argparse.ArgumentParser()
pars.add_argument("-v", "--verbose", help="increase output verbosity", required=False)
args = pars.parse_args()
expression = input("Please enter your expression/equasion to solve: ")
parsedexpr = lib.parser.parse(expression)
# eqtype=solver.find_type(parsedexpr)
solution = lib.solver.solve(parsedexpr)
sys.stdout.write("Solution is: " + ", ".join([mpmath.nstr(i) for i in solution]) + "\n")
