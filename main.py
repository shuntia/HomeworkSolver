import sys
import os
import argparse
#I love os

sys.stdout.write("This is the math solver for the Algebra 2 Honors class.")
parser = argparse.ArgumentParser()
parser.add_argument("-v", "--verbose", help="increase output verbosity",required=false)