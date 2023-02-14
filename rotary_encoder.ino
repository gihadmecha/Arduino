const int pin_1 = 2;
const int pin_2 = 3;
int present_value;
int last_value;
int shaft_position;
int angle;
int steps_per_revolution = 16;

void setup(){
pinMode(pin_1, INPUT);
pinMode(pin_2, INPUT);

digitalWrite(pin_1, HIGH);
digitalWrite(pin_2, HIGH);

Serial.begin(9600);
  }

void loop(){
  present_value = digitalRead(pin_1);
  if(last_value == LOW && present_value == HIGH);
    {
      if(pin_2 == HIGH){
        shaft_position --;
        delay (2000);
        }else{
          shaft_position ++;
          delay (2000);
          }
       angle = ((shaft_position % steps_per_revolution)*360) / steps_per_revolution;
       Serial.print("the angle = ");
       Serial.println(angle);   
      }
  last_value = present_value;
  }  
