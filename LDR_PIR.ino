int ledpin = 12;
int PIR = 2;
int LDR = 0;

void setup() {
 pinMode(ledpin, OUTPUT);
 pinMode(PIR, INPUT);
 Serial.begin(9600);
}

void loop() {
int val = digitalRead(PIR);
int val_2 = analogRead(LDR);

Serial.println(val_2);

if(val == HIGH && val_2 < 40 )
{
  Serial.println(val_2);
  digitalWrite(ledpin, HIGH);
  delay(1000);
  digitalWrite(ledpin, LOW);
}
}
