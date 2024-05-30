@echo off

:: Function to check if a command exists
:check_command
where %1 >nul 2>nul
if %errorlevel% neq 0 (
    echo %1 is not installed.
    set %2=0
) else (
    echo %1 is already installed.
    set %2=1
)
exit /b 0

:: Check if Python3 is installed
call :check_command python3 PYTHON3_INSTALLED
if %PYTHON3_INSTALLED%==0 (
    echo Python3 is not installed. Please install Python3 first.
    exit /b 1
)

:: Check if pip is installed
call :check_command pip PIP_INSTALLED
if %PIP_INSTALLED%==0 (
    echo Pip is not installed. Installing Pip...
    python3 -m ensurepip --upgrade
)

:: Create a new directory for the virtual environment if it doesn't exist
if not exist "homework-solver_env" (
    mkdir homework-solver_env
)

:: Create a virtual environment
python3 -m venv homework-solver_env

:: Activate the virtual environment
call homework-solver_env\Scripts\activate.bat

:: Upgrade pip
pip install --upgrade pip

:: Install required packages
pip install pix2text gmpy2 mpmath Pillow flask

echo Virtual environment created and required packages installed.
echo To activate the virtual environment, run "call homework-solver_env\Scripts\activate.bat".
echo To deactivate the virtual environment, run "deactivate".
pause
