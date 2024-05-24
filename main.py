import sys
import os
import argparse
import parser
#I love os

sys.stdout.write("This is the math solver for the Algebra 2 Honors class.")
parser = argparse.ArgumentParser()
parser.add_argument("-v", "--verbose", help="increase output verbosity",required=False)

expression=input("Please enter your expression to solve: ")
expression=parser.parse(expression)