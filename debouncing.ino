int ledpin = 13;
int switchpin = 2;
boolean state = 0;
const int debouncetime = 10;

boolean debounce();

void setup() {
  // put your setup code here, to run once:
pinMode(ledpin, OUTPUT);
pinMode(switchpin, INPUT);                                          
}

void loop() {
  // put your main code here, to run repeatedly:
if(debounce(switchpin)){
  digitalWrite (ledpin, HIGH);
  }
}


//debouncing_function
boolean debounce(int switchpin){
  boolean previousstate = digitalRead(switchpin);
  
  for(int counter = 0; counter < debouncetime; counter++)
  {
    delay(1);
    state = digitalRead(switchpin);
    if(state != previousstate)
    {
      previousstate = state;
      counter = 0;
      }
    }
} 



