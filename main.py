import sys
import os
import argparse
import lib.parser
import lib.calc
import lib.solver
import lib.formatter
import mpmath
import os
from ocr.recognization import recognize

mpmath.mp.prec = 3333
mpmath.mp.dps = 1000


# expression = "5*x^3-4*x^2+1*x-10"

# parsed_expression = lib.parser.parse(expression)
# lib.solver.solve(parsed_expression)

sys.stdout.write("This is the polynomial solver for the Algebra 2 Honors class.")
pars = argparse.ArgumentParser()
pars.add_argument("-v", "--verbose", help="increase output verbosity", required=False, action="store_true", default=False)
args = pars.parse_args()
expression = input("Please enter your expression/equasion to solve, or enter a path to an image: ")
if(os.path.isfile(expression)):
    expression = recognize(expression)
#todo: add image recognition, output format will be in form x^2+2x+1
parsedexpr = lib.parser.parse(expression)
# eqtype=solver.find_type(parsedexpr)
if(args.verbose):
    sys.stdout.write(str(parsedexpr)+"\n")
solution = lib.solver.solve(parsedexpr)
sys.stdout.write(
    "Solutions are: \n\t"
    + ", \n\t".join([lib.formatter.formatter(i) for i in solution])
    + "\n"
)