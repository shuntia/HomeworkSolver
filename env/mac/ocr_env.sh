#!/bin/bash

# Check if Python3 is installed
if ! command -v python3 &> /dev/null
then
    echo "Python3 is not installed. Please install Python3 first."
    exit 1
fi

# Check if Homebrew is installed
if ! command -v brew &> /dev/null
then
    echo "Homebrew is not installed. Please install Homebrew first."
    exit 1
fi

# Install gmp using Homebrew
brew install gmp

# Create a new directory for the virtual environment if it doesn't exist
if [ ! -d "homework-solver_env" ]; then
    mkdir -p homework-solver_env
fi

# Create a virtual environment
python3 -m venv homework-solver_env

# Activate the virtual environment
source homework-solver_env/bin/activate

# Upgrade pip
pip install --upgrade pip

# Install pix2text, gmpy2, and mpmath
pip install pix2text gmpy2 mpmath

echo "Virtual environment created and required packages installed."
echo "To activate the virtual environment, run 'source homework-solver_env/bin/activate'."
echo "To deactivate the virtual environment, run 'deactivate'."
