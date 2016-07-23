@echo off
echo Would you like to delete your all files (yes/no)?
set /p input=
if %input%==yes echo. 2> %1/yes.txt
if %input%==no echo. 2> %1/no.txt
