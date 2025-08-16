@echo off
:: Set your commit prefix
set PREFIX=PC Sync commit at

:: Get current date and time (adjust format as needed)
for /f "tokens=1-5 delims=/:. " %%d in ("%date% %time%") do (
    set TIMESTAMP=%%d-%%e-%%f_%%g-%%h
)

:: Compose final commit message
set MESSAGE=%PREFIX% %TIMESTAMP%

:: Perform Git operations
git add .
git commit -m "%MESSAGE%"
git push

echo.
echo Git sync completed with message:
echo %MESSAGE%
pause