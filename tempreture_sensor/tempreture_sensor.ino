int pin = 0;
float val = 0;
float volts = 0;
float  celsius = 0;
float  fahrenheit = 0;

void setup() {
  Serial.begin(9600);
}

void loop() {
 val = analogRead(pin);
 Serial.print(val);
 Serial.print("\t");

 //volts = (val / 1024.0) * 5000;
 volts = (val * 5000) / 1024.0; 
 Serial.print(volts);
 Serial.print("\t");

 celsius = volts / 10;
 Serial.print(celsius);
 Serial.print("\t");

 //Serial.print( (celsius * 9)/ 5 + 32 );
 fahrenheit = (((180 * celsius ) / 100) + 32);
 Serial.println(fahrenheit);

 delay(2000);
}
