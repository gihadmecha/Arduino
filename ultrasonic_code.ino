int ledpin = 11;
int trigpin = 12;
int echopin = 13;

int velocity = 34000;

int echovalue = 0;
int distance = 0;

int how_far = 0;

int ultrasonic_code();

void setup() {
pinMode(ledpin, OUTPUT);
pinMode(trigpin, OUTPUT);
pinMode(echopin, INPUT);

Serial.begin(9600);
}

void loop() {
  how_far = ultrasonic_code();

  if(how_far < 4)
  {
    Serial.println("dead end ... ");
    digitalWrite(ledpin, HIGH);
    delay(1000);
    digitalWrite(ledpin, LOW);
   }
   else if (how_far < 20 && how_far >= 4 )
   {
    Serial.print("the distance = ");
    Serial.println(how_far);
     delay(1000);
   } else{
      Serial.println("out of rang");
      delay(1000);
      }
}


int ultrasonic_code()
{
  digitalWrite(trigpin, LOW);
  delay(2);
  digitalWrite(trigpin, HIGH);
  delay(10);
  digitalWrite(trigpin, LOW);
  echovalue = pulseIn(echopin, HIGH);
  distance = echovalue / 58.8;

/*  echovalue =  echovalue / 10^6;                 // why these three equations do not work instead of 58.8    // i do not know !!!
  distance = velocity * echovalue;
  distance = distance /2; */
  
  return distance ;
  }
  
