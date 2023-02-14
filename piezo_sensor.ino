int ledpin = 12;
int inputpin = 0;
int referance = 100;
int val = 0;

void setup() {
  // put your setup code here, to run once:
pinMode(ledpin, OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
val = analogRead(inputpin);
if(val > referance)
{
  digitalWrite(ledpin, LOW);
  delay(1000);
  }else{
    digitalWrite(ledpin, HIGH);
    }
}
