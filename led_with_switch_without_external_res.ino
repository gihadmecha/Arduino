int ledpin = 13;
int switchpin = 2;

void setup() {
  // put your setup code here, to run once:
pinMode(ledpin, OUTPUT );
pinMode(switchpin, INPUT );
digitalWrite(switchpin, HIGH);
}

void loop() {
  // put your main code here, to run repeatedly:
int val = digitalRead(switchpin);

if (val == HIGH)
{
  digitalWrite(ledpin,LOW);
  }else{
    digitalWrite(ledpin,HIGH);
    }
}
