#!/bin/bash

# Check if Python3 is installed
if ! command -v python3 &> /dev/null
then
    echo "Python3 is not installed. Please install Python3 first."
    exit 1
fi

# Create a new directory for the virtual environment
mkdir -p myenv

# Create a virtual environment
python3 -m venv myenv

# Activate the virtual environment
source myenv/bin/activate

# Upgrade pip
pip install --upgrade pip

# Install pix2text, gmpy2, and mpmath
pip install pix2text gmpy2 mpmath

echo "Virtual environment created and pix2text installed."
echo "To activate the virtual environment, run 'source myenv/bin/activate'."
echo "To deactivate the virtual environment, run 'deactivate'."
