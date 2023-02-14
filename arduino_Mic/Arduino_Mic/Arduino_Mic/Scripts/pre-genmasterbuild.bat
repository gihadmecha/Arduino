@echo on
SETLOCAL EnableDelayedExpansion
::::::::::::::::::::::::::::::::::::::::::::::::::::::
::: Save variables to temporary fiels to be picked up by deployment script
:::
::: %1 = "$(MSBuildProjectName)" - Quotes are required to support names with spaces
::: %2 = "$(OutputFileName)$(OutputFileExtension)"  - Quotes are required to support names with spaces
::: %3 = $(avrdevice) - The AVR microcontroller
::: %4 = $(Configuration) - Release | Debug
::: %5 = "$(MSBuildProjectFile)" complete project name with extension
:::::::::::::::::::::::::::::::::::::::::::::::::::::::

::: pre-genmasterbuild.bat generates the master build script based on msbuild.
::: All paths must be relative to the script directory
set DESTINATION=masterbuild.bat
set TESTSUITEPATTERN=suite*.cpp
set LOCKFILE=masterbuild.lock

if exist %LOCKFILE% exit

::: Capture Date
for /f "tokens=2-4 delims=/ " %%a in ('date /T') do set year=%%c
for /f "tokens=2-4 delims=/ " %%a in ('date /T') do set month=%%a
for /f "tokens=2-4 delims=/ " %%a in ('date /T') do set day=%%b
set TODAY=%year%-%month%-%day%

::: Capture time
for /f "tokens=1 delims=: " %%h in ('time /T') do set hour=%%h
for /f "tokens=2 delims=: " %%m in ('time /T') do set minutes=%%m
for /f "tokens=3 delims=: " %%a in ('time /T') do set ampm=%%a
set NOW=%hour%-%minutes%-%ampm%

::: Build time stamp
set TIME_STAMP=%TODAY% %NOW%

::: Generate global.cpp
@echo echo off > %DESTINATION%
echo cls >> %DESTINATION%
echo REM /************************************************************ >> %DESTINATION%
echo REM DO NOT MODIFY >> %DESTINATION%
echo REM Automatically Generated On %TIME_STAMP% by pre-genfiles.bat >> %DESTINATION%
echo REM *************************************************************/ >> %DESTINATION%
echo copy /Y %DESTINATION% %LOCKFILE% >>  %DESTINATION%

echo REM Configure Atmel Studio >>  %DESTINATION%
echo if exist "C:\Program Files (x86)\Atmel\Atmel Studio 6.0\atmelstudio.exe" set ATMEL_STUDIO="C:\Program Files (x86)\Atmel\Atmel Studio 6.0\atmelstudio.exe" >>  %DESTINATION%
echo if exist "C:\Program Files\Atmel\Atmel Studio 6.0\atmelstudio.exe" set ATMEL_STUDIO="C:\Program Files\Atmel\Atmel Studio 6.0\atmelstudio.exe" >>  %DESTINATION%
echo REM Configure Deployment Script >>  %DESTINATION%
echo set DEPLOY_SCRIPT=%%USERPROFILE%%\Documents\Atmel Studio\deploy.bat >>  %DESTINATION%

:WRITEBATCH
set TargetSolutionDir=%6
set TargetSolutionDir=%TargetSolutionDir:"=%
set TargetProjectDir=%7
set TargetProjectDir=%TargetProjectDir:"=%

echo msbuild ..\build.xml /verbosity:m /consoleloggerparameters:PerformanceSummary /p:DeployScript="%%DEPLOY_SCRIPT%%" /p:AtmelStudio=%%ATMEL_STUDIO%% /p:ProjectName=%5 /p:TargetSolutionDir=%TargetSolutionDir% /p:TargetProjectDir=%TargetProjectDir%>>%DESTINATION%
echo del /f %LOCKFILE% >> %DESTINATION%