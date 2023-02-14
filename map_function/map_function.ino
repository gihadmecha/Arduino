const int ledpin = 13;
const int inputpin = 0;
int present = 0;
int val = 0;

void setup() {
  pinMode(ledpin, OUTPUT);
}

void loop() {
  
  val = analogRead(inputpin);
  present = map(val, 0, 1023, 0, 100);
  digitalWrite(ledpin, HIGH);
  delay(present);
  digitalWrite(ledpin, LOW);
  delay(100 - present);
}
