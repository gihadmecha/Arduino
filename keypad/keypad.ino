const int colnum = 4;
const int rownum = 4;
const int debounce = 10;

const char keymap[rownum][colnum] = {{'1','2','3','A'},
                                     {'4','5','6','B'},
                                     {'7','8','9','C'},
                                     {'*','0','#','D'}};

const int colpin[colnum] = {5, 4, 3, 2};
const int rowpin[rownum] = {9, 8, 7, 6};

void setup()
{
  Serial.begin(9600);

  for(int row = 0; row < rownum; row++)
  {
    pinMode(rowpin[row], INPUT);
    digitalWrite(rowpin[row], HIGH);
    }

  for(int col = 0; col < colnum; col++)
  {
    pinMode(colpin[col], OUTPUT);
    digitalWrite(colpin[col], HIGH);
    }  
  }
                                     

void loop()
{
  char key = getkey();

  if(key != 0)
  {
    Serial.print("Get Key ");
    Serial.println(key);
    }
  }                        
    

char getkey()
{
  char key = 0;

  for(int col = 0; col < colnum; col++)
  {
    digitalWrite(colpin[col], LOW);
    for(int row = 0; row < rownum; row++)
    {
      if(digitalRead(rowpin[row]) == LOW)
      {
        delay(debounce);
        while(digitalRead(rowpin[row]) == LOW);
        key = keymap[row][col];                             //"int key" != "key" try and record differance    // my mistake :D
        }
      }
      digitalWrite(colpin[col], HIGH);
    }
  return key ;
  }             
