#include <SoftwareServo.h> //incluimos libreria Servo
#include <Button.h>        //incluimos libreria bot´n
#define WLED 13            //definimos el pin del led
SoftwareServo motor;       //declaramos objeto motor

//declaramos objeto boton(PIN,CONFIGURACION)
Button button = Button(12,BUTTON_PULLUP_INTERNAL);

//variable para los casos de control
int caso = 0;

//Evento para cuando soltamos el boton
void handleButtonClickEvents(Button &btn) 
{
caso++;
}



// Configuracion de arduino
void setup()
{
  Serial.begin(9800);
  pinMode(WLED,OUTPUT);
  motor.attach(8);
  motor.setMaximumPulse(2040);   //centraliza el servo por software
  button.clickHandler(handleButtonClickEvents);
}

void loop()
{
  button.isPressed();  //update internal state


switch(caso){
  case 0:
  motor.write(90);   //motor parado
  break;
   case 1:
  motor.write(0);   //motor izquierda
  break;
   case 2:
  motor.write(180); //Motor giro derecha
  break;
  default:
  caso = 0;          //Reseteamos estado
}
  
SoftwareServo::refresh();  //Actualizamos estado motor.
}
