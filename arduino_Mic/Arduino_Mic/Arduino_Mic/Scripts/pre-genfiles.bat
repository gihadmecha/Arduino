@echo off

::::::::::::::::::::::::::::::::::::::::::::::::::::::
::: Save variables to temporary fiels to be picked up by deployment script
:::
::: %1 = "$(MSBuildProjectName)" - Quotes are required to support names with spaces
::: %2 = "$(OutputFileName)$(OutputFileExtension)"  - Quotes are required to support names with spaces
::: %3 = $(avrdevice) - The AVR microcontroller
::: %4 = $(Configuration) - Release | Debug
:::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::

::: PREBUILD.BAT makes the script directory the current directory.
::: All paths must be relative to the script directory
set DESTINATION=..\global.cpp

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
echo /************************************************************ > %DESTINATION%
echo DO NOT MODIFY >> %DESTINATION%
echo Automatically Generated On %TIME_STAMP% by pre-genfiles.bat >> %DESTINATION%
echo *************************************************************/ >> %DESTINATION%
echo const char* HEADER_MSG = "%~1-%4 %TIME_STAMP%"; >> %DESTINATION%


