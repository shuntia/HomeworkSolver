import sys
import os
import argparse
import lib.parser as parser
import lib.calc as calc
import lib.solver as solver
import lib.formatter as form
import mpmath
import recognization as recognition
from PIL import Image

mpmath.mp.prec = 3333
mpmath.mp.dps = 1000


# expression = "5*x^3-4*x^2+1*x-10"

# parsed_expression = lib.parser.parse(expression)
# lib.solver.solve(parsed_expression)

sys.stdout.write("This is the polynomial solver for the Algebra 2 Honors class.")
pars = argparse.ArgumentParser()
pars.add_argument(
    "-v",
    "--verbose",
    help="increase output verbosity",
    required=False,
    action="store_true",
    default=False,
)
pars.add_argument(
    "-a",
    "--app",
    help="activate server for application",
    required=False,
    action="store_true",
    default=False
)
args = pars.parse_args()
if(args.app):
    exit(os.system("python3 app.py"))
target = input("Please enter your expression/equasion to solve: ")
# eqtype=solver.find_type(parsedexpr)
if(os.path.isfile(target)):
    expression = recognition.recognize(target)
    sys.stdout.write("recognized: "+str(expression)+"\n")
else:
    expression=target
if "=" in expression:
    expression=expression[expression.find("=")+1:]
parsedexpr = parser.parse(expression)
if(args.verbose):
    sys.stdout.write(str(parsedexpr)+"\n")
solution = solver.solve(parsedexpr)
sys.stdout.write(
    "Solutions are: \n\t"
    + ", \n\t".join(list(set(form.formatter(i) for i in solution)))
    + "\n"
)
