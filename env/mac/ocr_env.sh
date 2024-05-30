#!/bin/bash

# Function to install Homebrew
install_homebrew() {
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
}

# Function to install Python3
install_python3() {
    echo "Installing Python3..."
    brew install python
}

# Check if Homebrew is installed
if ! command -v brew &> /dev/null
then
    echo "Homebrew is not installed. Installing Homebrew..."
    install_homebrew
else
    echo "Homebrew is already installed."
fi

# Check if Python3 is installed
if ! command -v python3 &> /dev/null
then
    echo "Python3 is not installed. Installing Python3..."
    install_python3
else
    echo "Python3 is already installed."
fi

# Ensure python3-venv is installed
if ! python3 -m venv -h &> /dev/null
then
    echo "python3-venv is not installed. Installing python3-venv..."
    brew install python-tk
    brew install python3-venv
else
    echo "python3-venv is already installed."
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

# Install required packages
pip install pix2text gmpy2 mpmath Pillow flask

echo "Virtual environment created and required packages installed."
echo "To activate the virtual environment, run 'source homework-solver_env/bin/activate'."
echo "To deactivate the virtual environment, run 'deactivate'."
