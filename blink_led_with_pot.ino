const int ledpin = 13;
const int pot = 0;


void setup() {
  pinMode(ledpin, OUTPUT);
}

void loop() {
  
  int val = analogRead(pot);
  digitalWrite(ledpin, HIGH);
  delay(val);
  digitalWrite(ledpin, LOW);
  delay(val);
}
