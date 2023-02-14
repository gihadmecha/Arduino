@echo off
cls

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                         HISTORY
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::: 08/25/2012 - Release #2
::: Added support for sketches with blank in name
::: Verify critical paths prior to running
::: Added PROGRAMMER verbosity to control programmer output
::: Generalized script to use avrdude and atprogram to control programmer
::: Script can be used to deploy non arduino code
::: Added support for usbtiny, avrdragon and avrispmk2
::: Expanded debug mode to output all relevant variables
::: Capture configuration (Release|Debug) dymanically, no longer hardcoded to Release
::: Capture Device dymanically, no longer hardcoded to ATmega328P
::: Group scripts in scripts directory in preparation for future enhancements
::: 
:::
::: 08/13/2012 - Release #1
::: Support to program arduino with AVRDUDE
:::
::: 10/11/2012 - Beta 2
::: Fixed bug with spaces in configuration file for avrdude
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::: :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::: ld-program.bat- deploy applications to avr microcontrollers
::: Omar Franciscio - 08/25/2012
::: Script Generated On 2016-07-20 01-39-PM
::: Parameters
::: %1 Solution Directory
::: %2 Project Directory
::: %3 avrdude path
::: %4 avrdude config
::: %5 ATPROGRAM path
::: %6 library path
::: %7 header path
::: :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::: YOU CAN CHANGE THESE VALUES
::: Values allowed avrdragon|arduino|avrispmk2|usbtiny
set PROGRAMMER=arduino

::: Apply mostly to AVRDRAGON - Allowed values dragon_dw|dragon_hvsp|drago_isp|dragon_jtag|dragon_pdi|dragon_pp
set PROGRAMMER_MODE=HVPP

::: Very verbosed
:::set PROGRAMMER_VERBOSITY=-v -v -v
::: very quiet
 set PROGRAMMER_VERBOSITY=-q -q -q

set COMPORT=COM3
set COMPORTSPEED=115200
set DEBUG_FLAG="OFF"

::: DO NOT CHANGE THESE VALUES
SET SOLUTION_DIR=%~1
SET PROJECT_DIR=%~2
set AVRDUDE_PATH=%~3
set AVRDUDE_CONFIG_PATH=%~4
set ATPROGRAM=%~5
set LIB_DIR=%~6
set HEADER_DIR=%~7
set PROJECT_FILE="%PROJECT_DIR%scripts\project.txt"
set OUTPUT_FILE="%PROJECT_DIR%scripts\output.txt"
set DEVICE_FILE="%PROJECT_DIR%scripts\device.txt"
set CONFIG_FILE="%PROJECT_DIR%scripts\config.txt"

set /p PROJECT_NAME= <%PROJECT_FILE%
set /p BINARY_FILE= <%OUTPUT_FILE%
set BINARY_FILE=%BINARY_FILE:"=%
set /p AVRPROCESSOR= <%DEVICE_FILE%
set /p CONFIGURATION= <%CONFIG_FILE%

set ARDUINO_LIBS_HEADER_DIR=%HEADER_DIR%Arduino\
set UTILITY_DIR="%ARDUINO_LIBS_HEADER_DIR%utility"
SET BINARY_FILE_PATH="%PROJECT_DIR%%CONFIGURATION%\%BINARY_FILE%"

set ROOT_OUTPUT_FILE=%BINARY_FILE%
SET ROOT_OUTPUT_FILE=%ROOT_OUTPUT_FILE:.elf=%

SET EEPROM_FILE=%ROOT_OUTPUT_FILE%.eep
SET EEPROM_FILE_PATH="%PROJECT_DIR%%CONFIGURATION%\%EEPROM_FILE%"
if exist %EEPROM_FILE_PATH% (set /p EEPROM_CONTENT= <%EEPROM_FILE_PATH%)

set INCLUDE_EEPROM_FILE="FALSE"
if "%EEPROM_CONTENT%" == "" goto :NO_EEPROM_FILE
if "%EEPROM_CONTENT%" == ":00000001FF" goto :NO_EEPROM_FILE
set INCLUDE_EEPROM_FLAG="TRUE"
:NO_EEPROM_FILE

SET HEX_BINARY_FILE=%ROOT_OUTPUT_FILE%.hex
SET HEX_BINARY_FILE_PATH="%PROJECT_DIR%%CONFIGURATION%\%HEX_BINARY_FILE%"

if %DEBUG_FLAG% == "ON" (
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::: DEBUG MODE ON - NO DEPLOYMENT WILL TAKE EFFECT
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if exist %PROJECT_FILE% (echo Input Project File: %PROJECT_FILE% [CHECKED]) else (echo Input Project File: %PROJECT_FILE% [NOT FOUND])
if exist %OUTPUT_FILE% (echo Input Output File: %OUTPUT_FILE% [CHECKED] ) else (echo Input Output File: %OUTPUT_FILE% [NOT FOUND])
if exist %DEVICE_FILE% (echo Input Device File: %DEVICE_FILE% [CHECKED]) else (echo Input Device File: %DEVICE_FILE% [NOT FOUND])
if exist %CONFIG_FILE% (echo Input Config File: %CONFIG_FILE% [CHECKED]) else (echo Input Config File: %CONFIG_FILE% [NOT FOUND])
if exist "%SOLUTION_DIR%" (echo Solution Directory:%SOLUTION_DIR% [CHECKED]) else (echo Solution Directory:%SOLUTION_DIR% [NOT FOUND])
if exist "%PROJECT_DIR%" (echo Project Directory:%PROJECT_DIR% [CHECKED]) else (echo Project Directory:%PROJECT_DIR% [NOT FOUND])
if exist "%LIB_PATH%" (echo Library Path:%LIB_PATH% [CHECKED]) else (echo Library Path:%LIB_PATH% [NOT FOUND])
if exist "%HEADER_PATH%" (echo Header Path:%HEADER_PATH% [CHECKED]) else (echo Header Path:%HEADER_PATH% [NOT FOUND])
if exist "%AVRDUDE_PATH%" (echo AVRDUDE Path:%AVRDUDE_PATH% [CHECKED]) else (echo AVRDUDE Path:%AVRDUDE_PATH% [NOT FOUND])
if exist "%AVRDUDE_CONFIG%" (echo AVRDUDE Config:%AVRDUDE_CONFIG% [CHECKED]) else (echo AVRDUDE Config:%AVRDUDE_CONFIG% [NOT FOUND])
if exist %BINARY_FILE_PATH% (echo Binary File:%BINARY_FILE_PATH% [CHECKED]) else (echo Binary File:%BINARY_FILE_PATH% [NOT FOUND])
if exist %EEPROM_FILE_PATH% (echo EEPROM File:%EEPROM_FILE_PATH% [CHECKED]) else (echo EEPROM File:%EEPROM_FILE_PATH% [NOT FOUND])
if exist "%ARDUINO_LIBS_HEADER_DIR%" (echo Arduino Library Header Path:%ARDUINO_LIBS_HEADER_DIR% [CHECKED]) else (echo Arduino Library Header Path:%ARDUINO_LIBS_HEADER_DIR% [NOT FOUND])
if exist %UTILITY_DIR% (echo Utility Directory:%UTILITY_DIR% [CHECKED]) else (echo Utility Directory:%UTILITY_DIR% [NOT FOUND])

echo Configuration:%CONFIGURATION%
echo EEPROM File:%EEPROM_FILE_PATH%
echo Processor: %AVRPROCESSOR%
echo Programmer: %PROGRAMMER%
echo Programmer Mode: %PROGRAMMER_MODE%
echo COM Port: %COMPORT%
echo COM Port Speed: %COMPORTSPEED%
echo Project Name:%PROJECT_NAME%
echo Output File:%BINARY_FILE%
echo AVRDUE Verbosity: %PROGRAMMER_VERBOSITY%
echo ============================
goto :END
)

if NOT EXIST %PROJECT_FILE% (
  echo CANNOT Find project directory %PROJECT_FILE% - Aborting script
  goto :END
)

if NOT EXIST %OUTPUT_FILE% (
  echo CANNOT Find output file %OUTPUT_FILE% - Aborting script
  goto :END
)

if NOT EXIST %DEVICE_FILE% (
  echo CANNOT Find device file %DEVICE_FILE% - Aborting script
  goto :END
)


if NOT EXIST %CONFIG_FILE% (
  echo CANNOT Find config file %CONFIG_FILE% - Aborting script
  goto :END
)

if NOT EXIST "%SOLUTION_DIR%" (
  echo CANNOT Find solution directory %SOLUTION_DIR% - Aborting script
  goto :END
)

if NOT EXIST "%PROJECT_DIR%" (
  echo CANNOT Find project directory %PROJECT_DIR% - Aborting script
  goto :END
)

if NOT EXIST "%LIB_PATH%" (
  echo [WARNING] CANNOT Find project directory %LIB_PATH%
  rem goto :END
)

if NOT EXIST "%HEADER_PATH%" (
  echo [WARNING] CANNOT Find header directory %HEADER_PATH%
  rem goto :END
)

if NOT EXIST "%AVRDUDE_PATH%" (
  echo CANNOT Find ARVRDUDE directory %AVRDUDE_PATH% - Aborting script
  goto :END
)

if NOT EXIST "%AVRDUDE_CONFIG%" (
  echo CANNOT Find ARVRDUDE config directory %AVRDUDE_CONFIG% - Aborting script
  goto :END
)

if NOT EXIST %BINARY_FILE_PATH% (
  echo CANNOT Find Binary File directory %BINARY_FILE_PATH% - Aborting script
  goto :END
)

if "%PROGRAMMER%"=="arduino" goto :ARDUINO
if "%PROGRAMMER%"=="avrispmk2" goto :AVRISPMK2
if "%PROGRAMMER%"=="usbtiny" goto :USBTINY
if "%PROGRAMMER%"=="avrdragon" goto :DRAGON
echo [ERROR] Invalid programmer detected [%PROGRAMMER%] - Aborting Script
goto :END

:ARDUINO
echo "%AVRDUDE_PATH%" -C"%AVRDUDE_CONFIG_PATH%" %PROGRAMMER_VERBOSITY%  -p%AVRPROCESSOR% -c%PROGRAMMER% -P\\.\%COMPORT% -b%COMPORTSPEED% -D -Uflash:w:%BINARY_FILE_PATH%:i
"%AVRDUDE_PATH%" -C"%AVRDUDE_CONFIG_PATH%" %PROGRAMMER_VERBOSITY% -p%AVRPROCESSOR% -c%PROGRAMMER% -P\\.\%COMPORT% -b%COMPORTSPEED% -D -Uflash:w:%HEX_BINARY_FILE_PATH%:i 
if %ERRORLEVEL%==1 goto :FAILED_DEPLOYMENT
goto :DEPLOYMENT_COMPLETE

:AVRISPMK2
if %INCLUDE_EEPROM_FILE%=="TRUE" GOTO :AVRISPMK2_WITH_EEPROM
echo Programming without EEPROM file
echo "%ATPROGRAM%"  %PROGRAMMER_VERBOSITY% -t %PROGRAMMER% -i ISP -d %AVRPROCESSOR% chiperase program -fl -f %HEX_BINARY_FILE_PATH%  --format hex --verify 
"%ATPROGRAM%"  %PROGRAMMER_VERBOSITY% -t %PROGRAMMER% -i ISP -d %AVRPROCESSOR% chiperase program -fl -f %HEX_BINARY_FILE_PATH%  --format hex --verify 
if %ERRORLEVEL%==1 goto :FAILED_DEPLOYMENT
goto :DEPLOYMENT_COMPLETE

:AVRISPMK2_WITH_EEPROM
echo Programming with EEPROM file
echo "%ATPROGRAM%" %PROGRAMMER_VERBOSITY%  -t %PROGRAMMER% -i ISP -d %AVRPROCESSOR% program -fl -f %HEX_BINARY_FILE_PATH%  --format hex --verify 
"%ATPROGRAM%"  %PROGRAMMER_VERBOSITY% -t %PROGRAMMER% -i ISP -d %AVRPROCESSOR% chiperase program -fl -f %HEX_BINARY_FILE_PATH% --format hex --verify 
if %ERRORLEVEL%==1 goto :FAILED_DEPLOYMENT

echo "%ATPROGRAM%" %PROGRAMMER_VERBOSITY%  -t %PROGRAMMER% -i ISP -d %AVRPROCESSOR% program -ee -f %EEPROM_FILE_PATH% --format hex --verify 
"%ATPROGRAM%"  %PROGRAMMER_VERBOSITY% -t %PROGRAMMER% -i ISP -d %AVRPROCESSOR% program -ee -f %EEPROM_FILE_PATH% --format hex --verify 
if %ERRORLEVEL%==1 goto :FAILED_DEPLOYMENT
goto :DEPLOYMENT_COMPLETE

:USBTINY
if %INCLUDE_EEPROM_FILE%=="TRUE" GOTO :USBTINY_WITH_EEPROM
echo Programming without EEPROM file
echo "%AVRDUDE_PATH%" -C"%AVRDUDE_CONFIG_PATH%" %PROGRAMMER_VERBOSITY% -p%AVRPROCESSOR% -c%PROGRAMMER% -P usb -Uflash:w:%HEX_BINARY_FILE_PATH%:i
"%AVRDUDE_PATH%" -C"%AVRDUDE_CONFIG_PATH%" %PROGRAMMER_VERBOSITY% -p%AVRPROCESSOR% -c%PROGRAMMER% -P usb -Uflash:w:%HEX_BINARY_FILE_PATH%:i 
rem  -Ueeprom:w:%EEPROM_FILE_PATH%:i
if %ERRORLEVEL%==1 goto :FAILED_DEPLOYMENT
goto :DEPLOYMENT_COMPLETE

:USBTINY_WITH_EEPROM
echo Programming with EEPROM file
echo "%AVRDUDE_PATH%" -C"%AVRDUDE_CONFIG_PATH%" %PROGRAMMER_VERBOSITY% -p%AVRPROCESSOR% -c%PROGRAMMER% -P usb -Uflash:w:%HEX_BINARY_FILE_PATH%:i 
"%AVRDUDE_PATH%" -C"%AVRDUDE_CONFIG_PATH%" %PROGRAMMER_VERBOSITY% -p%AVRPROCESSOR% -c%PROGRAMMER% -P usb -Uflash:w:%HEX_BINARY_FILE_PATH%:i 
if %ERRORLEVEL%==1 goto :FAILED_DEPLOYMENT
echo "%AVRDUDE_PATH%" -C"%AVRDUDE_CONFIG_PATH%" %PROGRAMMER_VERBOSITY% -p%AVRPROCESSOR% -c%PROGRAMMER% -P usb -Ueeprom:w:%EEPROM_FILE_PATH%:i
"%AVRDUDE_PATH%" -C"%AVRDUDE_CONFIG_PATH%" %PROGRAMMER_VERBOSITY% -p%AVRPROCESSOR% -c%PROGRAMMER% -P usb -Ueeprom:w:%EEPROM_FILE_PATH%:i
if %ERRORLEVEL%==1 goto :FAILED_DEPLOYMENT
goto :DEPLOYMENT_COMPLETE

:DRAGON
if %INCLUDE_EEPROM_FILE%=="TRUE" GOTO :DRAGON_WITH_EEPROM
echo Programming without EEPROM file
echo "%ATPROGRAM%" %PROGRAMMER_VERBOSITY% -t %PROGRAMMER% -i %PROGRAMMER_MODE% -d %AVRPROCESSOR% program -fl -f %HEX_BINARY_FILE_PATH% --verify 
"%ATPROGRAM%"  %PROGRAMMER_VERBOSITY% -t %PROGRAMMER% -i %PROGRAMMER_MODE% -d %AVRPROCESSOR% chiperase program -fl -f %HEX_BINARY_FILE_PATH% --verify 
if %ERRORLEVEL%==1 goto :FAILED_DEPLOYMENT
goto :DEPLOYMENT_COMPLETE

:DRAGON_WITH_EEPROM
echo Programming with EEPROM file
echo "%ATPROGRAM%"  %PROGRAMMER_VERBOSITY% -t %PROGRAMMER% -i %PROGRAMMER_MODE% -d %AVRPROCESSOR% chiperase program -fl -f %HEX_BINARY_FILE_PATH% -ee -f %EEPROM_FILE_PATH% --format hex --verify  
"%ATPROGRAM%"  %PROGRAMMER_VERBOSITY% -xr -t %PROGRAMMER% -i %PROGRAMMER_MODE% -d %AVRPROCESSOR% chiperase program -fl -f %HEX_BINARY_FILE_PATH% --format hex --verify 
if %ERRORLEVEL%==1 goto :FAILED_DEPLOYMENT

echo "%ATPROGRAM%"  %PROGRAMMER_VERBOSITY% -xr -t %PROGRAMMER% -i %PROGRAMMER_MODE% -d %AVRPROCESSOR% program -ee -f %EEPROM_FILE_PATH% --format hex --verify 
"%ATPROGRAM%"  %PROGRAMMER_VERBOSITY% -xr -t %PROGRAMMER% -i %PROGRAMMER_MODE% -d %AVRPROCESSOR% program -ee -f %EEPROM_FILE_PATH% --format hex --verify 
if %ERRORLEVEL%==1 goto :FAILED_DEPLOYMENT
goto :DEPLOYMENT_COMPLETE

:FAILED_DEPLOYMENT
echo Deployment Failed
goto :END

:DEPLOYMENT_COMPLETE
echo Deployment Complete

:END