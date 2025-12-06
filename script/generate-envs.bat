@echo off
setlocal enabledelayedexpansion

set ROOT=%~dp0..
set EXAMPLE=%ROOT%\.env.example

if not exist "%EXAMPLE%" (
  echo Missing .env.example at project root: %EXAMPLE%
  exit /b 1
)

call :copyenv "%ROOT%\.env.development"
call :copyenv "%ROOT%\.env.staging"
call :copyenv "%ROOT%\.env.production"
exit /b 0

:copyenv
set TARGET=%~1
if exist "%TARGET%" (
  echo Skipping %TARGET% (already exists)
) else (
  copy "%EXAMPLE%" "%TARGET%" >nul
  echo Created %TARGET% from .env.example
)
exit /b 0
