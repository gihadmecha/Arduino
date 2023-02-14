int tiltsensor = 2;
int ledone = 12 ;
int ledtwo = 11 ;

void setup() {
  // put your setup code here, to run once:
pinMode(tiltsensor, INPUT);
digitalWrite(tiltsensor, HIGH);
pinMode(ledone, OUTPUT);
pinMode(ledtwo, OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
if(digitalRead(tiltsensor)){
   digitalWrite(ledone, HIGH);
   digitalWrite(ledtwo, LOW);
  }else{
    digitalWrite(ledone, LOW);
    digitalWrite(ledtwo, HIGH);
    }
}
