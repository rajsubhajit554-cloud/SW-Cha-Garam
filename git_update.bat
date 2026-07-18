@echo off
title Git Repository Updater
cls
echo ===================================================
echo               GIT REPOSITORY UPDATER
echo ===================================================
echo.

:: Check if git is installed
where git >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Git is not installed or not in your PATH.
    echo Please install Git from https://git-scm.com/
    goto end
)

echo Staging all changes...
git add .
if %errorlevel% neq 0 (
    echo [ERROR] Failed to stage changes.
    goto end
)
echo Changes staged successfully.
echo.

:: Set default commit message using current date and time
set default_msg=Update: %date% %time%
set /p commit_msg="Enter commit message (Press Enter for default: %default_msg%): "

if "%commit_msg%"=="" (
    set commit_msg=%default_msg%
)

echo.
echo Committing changes...
git commit -m "%commit_msg%"
if %errorlevel% neq 0 (
    echo.
    echo [NOTE] No changes to commit or commit failed.
)

echo.
echo Pushing changes to GitHub (origin main)...
git push origin main
if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Failed to push changes to GitHub.
    echo Please check your internet connection, credentials, or repository permissions.
    goto end
)

echo.
echo ===================================================
echo      SUCCESS: GitHub repository updated successfully!
echo ===================================================

:end
echo.
pause
