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

set PROJECT_FILE=project.txt
set OUTPUT_FILE=output.txt
set DEVICE_FILE=device.txt
set CONFIG_FILE=config.txt

cd ..\scripts
echo %1> %PROJECT_FILE%
echo %2> %OUTPUT_FILE%
echo %3> %DEVICE_FILE%
echo %4> %CONFIG_FILE%
