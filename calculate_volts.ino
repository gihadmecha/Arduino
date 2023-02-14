int input = 0;


void setup()
{
  Serial.begin(9600);
  }

void loop()
{
  int val = analogRead(input);
  float volt = (val/1023)*5;
  Serial.println(volt);
  delay(2000);
  }  
