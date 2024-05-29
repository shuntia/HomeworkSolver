@echo off
REM Check if Python is installed
python --version >nul 2>&1
if errorlevel 1 (
    echo Python is not installed. Please install Python first.
    exit /b 1
)

REM Create a new directory for the virtual environment
mkdir myenv

REM Create a virtual environment
python -m venv myenv

REM Activate the virtual environment
call myenv\Scripts\activate

REM Upgrade pip
python -m pip install --upgrade pip

REM Install gmpy2, and mpmath
pip install pix2text gmpy2 mpmath

echo Virtual environment created and pix2text installed.
echo To activate the virtual environment, run 'myenv\Scripts\activate'.
echo To deactivate the virtual environment, run 'deactivate'.

REM Deactivate the virtual environment
deactivate
