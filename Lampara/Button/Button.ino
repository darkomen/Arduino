/**
 * Button
 * by BREVIG http://alexanderbrevig.com
 * 
 * Use a button connected to digital pin 12.
 * Digital pin 12 is used as input and connected to a button
 * When the button is pressed, the Wiring board LED turn ON,
 * the LED turns OFF when the button is released.
 * 
 * This example simulates the switch example
 */
 
#include <Button.h>

/*
  Wire like this:
  GND -----/ button ------ pin 12
*/
Button button = Button(12,BUTTON_PULLDOWN);

#define led  9
int state = 0;

void setup()
{
  pinMode(13,OUTPUT);
}

void loop()
{
  if(button.isPressed())
  {
    state ++;
  }
  if (state >= 4){
   state = 0; 
  }
  
  switch (state){
  case 0:
        analogWrite(led,0);
        break;
   case 1:
        analogWrite(led,100);
        break;
   case 2:
        analogWrite(led,150);
        break;
          case 3:
        analogWrite(led,200);
        break;
          case 4:
        analogWrite(led,250);
        break;
          case 5:
        analogWrite(led,250);
        delay(500);
        analogWrite(led,0);
        delay(500);
        analogWrite(led,250);
        delay(500);
        analogWrite(led,250);
        break;
        default:
        analogWrite(led,0);
        break;
  }
}
