int ledpin = 13;
int switchpin = 2;

void setup() {
  // put your setup code here, to run once:
pinMode(ledpin, OUTPUT );
pinMode(switchpin, INPUT );
}

void loop() {
  // put your main code here, to run repeatedly:
int val = digitalRead(switchpin);

if (val == HIGH)
{
  digitalWrite(ledpin, HIGH);
  }else{
    digitalWrite(ledpin, LOW);
    }
}
