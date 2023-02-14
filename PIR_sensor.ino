int ledpin = 13;
int PIR = 2;

void setup() {
  // put your setup code here, to run once:
 pinMode(ledpin, OUTPUT);
 pinMode(PIR, INPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
int val = digitalRead(PIR);
if(val == HIGH)
{
  digitalWrite(ledpin, HIGH);
  delay(500);
  digitalWrite(ledpin, LOW);
}
}
