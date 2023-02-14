int value ;

void setup() {
  // put your setup code here, to run once:
Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
Serial.print('H');
value = random(599);
Serial.print("\t");
Serial.print(lowByte(value));
Serial.print("\t");
Serial.println(highByte(value));
delay(1000);
}
