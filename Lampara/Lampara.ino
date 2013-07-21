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

bool bandera = true; 
//Bandera = true: entra en la rutina del ultimo estado para parpadear
//Bandera = false; no entra en la rutina del ultimo estado para parpadear.

void handleButtonPressEvents(Button &btn)
{
   state ++;
}
void handleButtonHoldEvents(Button &btn) 
{
  state  = 0;
}

void setup()
{
  pinMode(13,OUTPUT);
  Serial.begin(9600);
  button.pressHandler(handleButtonPressEvents);
  button.holdHandler(handleButtonHoldEvents,2000);
}

void loop()
{
  button.isPressed();
  if (state > 5){
   state = 0; 
  }
  
  switch (state){
  case 0:
        Serial.println("Estado 0");
        analogWrite(led,0);
        bandera = true;
        break;
   case 1:
        Serial.println("Estado 1");
        analogWrite(led,100);
        
        break;
   case 2:
        Serial.println("Estado 2");
        analogWrite(led,150);
        break;
  case 3:
        Serial.println("Estado 3");
        analogWrite(led,200);
        break;
  case 4:
        Serial.println("Estado 4");
        analogWrite(led,250);
        break;
  case 5:
       Serial.println("Estado 5");
       if (bandera){
          for (int i=0;i<8;i++){
            analogWrite(led,250);
            delay(150);
            analogWrite(led,0);
            delay(150);
            bandera = false;
          }
        }
        analogWrite(led,250);
        break;
  default:
        analogWrite(led,0);
        break;
  }
}
