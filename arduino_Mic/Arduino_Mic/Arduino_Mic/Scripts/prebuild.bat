@echo off

::::::::::::::::::::::::::::::::::::::::::::::::::::::
::: Launches all prebuild scripts
:::
::: %1 = "$(MSBuildProjectName)" - Quotes are required to support names with spaces
::: %2 = "$(OutputFileName)$(OutputFileExtension)"  - Quotes are required to support names with spaces
::: %3 = $(avrdevice) - The AVR microcontroller
::: %4 = $(Configuration) - Release | Debug
::: %5 = "$(MSBuildProjectFile)" 
::: %6 = "$(SolutionDir)"
::: %7 = "$(MSBuildProjectDirectory)\"
::: Feel free to add additional parameters to the prebuild step to support additional scripts.
:::::::::::::::::::::::::::::::::::::::::::::::::::::::

cd ..\scripts

::: Save variables to files
call pre-captureprops.bat %1 %2 %3 %4

::: Generate files
call pre-genfiles.bat %1 %2 %3 %4

::: Generate build script
call pre-genmasterbuild.bat %1 %2 %3 %4 %5 %6 %7