const int ledpin = 13;
const int LDR = 0;
int val = 0;

void setup() {
  pinMode(ledpin, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  
  int val = analogRead(LDR);
  Serial.println(val);
  delay(1000);
  if(val < 40) 
  {
  digitalWrite(ledpin, HIGH);
  }else{
  digitalWrite(ledpin, LOW);
  
  }
}
