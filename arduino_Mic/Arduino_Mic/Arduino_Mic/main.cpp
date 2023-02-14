/*
 * main.cpp
 *
 * Created: $date$
 *  Author: $user$
 */ 
 
#include <Arduino.h>

/* Constants */
const uint8_t LED = 13;
const unsigned long DELAY_LENGTH = 250;
const unsigned long SERIAL_SPEED = 9600;
const char* MESSAGE = "Hello World! - ";

/* HEADER_MSG is pro grammatically generated as part of the prebuild script */
extern const char* HEADER_MSG;

/* Functions */
extern  unsigned long incCounter( unsigned long count );

/************************************************************************
 All assembly functions must use the "C" calling convention in order to
 prevent C++ name mangling.
************************************************************************/
extern "C" unsigned long incCounter2( unsigned long count );
void setup();
void loop();

/* Variables */
static unsigned long counter = 0;

 void setup() {
	 pinMode(LED, OUTPUT);
	 Serial.begin(SERIAL_SPEED);
	 Serial.println(HEADER_MSG);
 }

 void loop() {
	 digitalWrite(LED, HIGH);
	 delay(DELAY_LENGTH);
	 digitalWrite(LED, LOW);
	 delay(DELAY_LENGTH);
	 Serial.print(MESSAGE);

	 // Uncomment next line to use Assembly routine to increment counter
	 counter = incCounter2(counter);

	 // Uncomment next line to use C routine to increment counter
	 //counter = incCounter(counter);

	 Serial.println( counter );
 }