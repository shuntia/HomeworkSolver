import sys
import os
import argparse
import parser
import solver
#I love os

sys.stdout.write("This is the polynomial solver for the Algebra 2 Honors class.")
pars = argparse.ArgumentParser()
pars.add_argument("-v", "--verbose", help="increase output verbosity",required=False)
args=pars.parse_args()
expression=input("Please enter your expression/equasion to solve: ")
parsedexpr=parser.parse(expression)
eqtype=solver.find_type(parsedexpr)
solution=solver.solve(parsedexpr, eqtype)
sys.stdout.write("Solution is: "+str(solution))