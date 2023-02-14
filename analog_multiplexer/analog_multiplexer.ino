int selector[] = {2, 3, 4};
int val = 0;
int value = 0;
int pin = 0;
int led1 = 13;
int led2 = 12;
int led3 = 11;
int led4 = 10;
int led5 = 9;
int led6 = 8;
int led7 = 7;
int led8 = 6;
int inputpin = 0;
int analog_val = 0;

void setup() {
  // put your setup code here, to run once:
pinMode(led1, OUTPUT );
pinMode(led2, OUTPUT );
pinMode(led3, OUTPUT );
pinMode(led4, OUTPUT );
pinMode(led5, OUTPUT);
pinMode(led6, OUTPUT );
pinMode(led7, OUTPUT );
pinMode(led8, OUTPUT);
digitalWrite(led1, HIGH);
Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
for(int channel = 0; channel < 8; channel++)
{
  val = getvalue(channel);
  analog_val = analogRead(inputpin);
  if(channel = 0 && analog_val > 40)
  {
    digitalWrite(led1, LOW);
    }
  else if(channel = 1 && analog_val < 40)
  {
    digitalWrite(led2, HIGH);
    }
  else if(channel = 2, analog_val < 62)
  {
    digitalWrite(led3, HIGH);
    }
  else if(channel = 3,analog_val == HIGH)
  {
    digitalWrite(led4, HIGH);
    delay(1000);
    digitalWrite(led4, LOW);
    }else{
      digitalWrite(led5, HIGH);
      digitalWrite(led6, HIGH);
      digitalWrite(led7, HIGH);
      digitalWrite(led8, HIGH);
      delay(1);
      digitalWrite(led5, LOW);
      digitalWrite(led6, LOW);
      digitalWrite(led7, LOW);
      digitalWrite(led8, LOW);
      } 
  Serial.print("channel");
  Serial.print(channel);
  Serial.print(" = ");
  Serial.println(value);
  delay(1000);
  }
}

int getvalue(int channel)
{
  for(int digit =0; digit < 3; digit++)
  {
    pin = selector[digit];
    value = bitRead(channel, digit);
    digitalWrite(pin, value);
    }
  }
