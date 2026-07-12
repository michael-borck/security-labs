@echo off
REM Windows entry point — needs Git Bash or WSL2.
where bash >nul 2>nul || (echo Please run this from Git Bash or WSL2. & pause & exit /b 1)
bash scripts/lab-console
