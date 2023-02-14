Libraries
---------
List of arduino libraries available and how to reference them.
All libraries references need to be added to project properties/Toolchain/[AVR/GNU Linker]/Libraries.
Only the library name without the extension is required.

Wire
#include <Wire.h>
Add LibWire library

Stepper
#include <Stepper.h>
Add libStepper library

SPI
#inlclude <SPI.h>
add libSPI library

SoftSerial
#inlude <SoftwareSerial.h>
add LibSoftwareSerial library

Servo
#include <Servo.h>
add LibServo library

SD
#inlude <sd.h>
add LibSD library

LiquidCrylstal
#include <LiquidCrystal.h>
add LibLiquidCrystal library

Firmata
#include <Firmata.h>
add LibFirmata library

Ethernet
tbd

EEPROM
#include <EEPROM.h>
add LibEEPROM library


Scripts
----------
prebuild.bat - Main file responsible of handling all prebuild events
pre-captureprops.bat - Capture critical properties during prebuild to external files to be used later on by the deploy process
pre-genfiles.bat - Generates the content of the global.cpp file to show how to embed the build time stamp in code

postbuild.bat - Main file responsible of handling all post build events
post-sample.bat - Sample file does nothing

localdeploy.bat - Main file responsible of handling all deployment events
ldprogram.bat - Deploys the program to a destination AVR using a supported programmer