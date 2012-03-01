#include <SoftwareServo.h> //incluimos libreria Servo
#include <Button.h>        //incluimos libreria bot´n
#include <Ultrasonic.h>
#define WLED 13            //definimos el pin del led
#define triger 7
#define echo 6
SoftwareServo izquierdo;       //declaramos objeto motor izquierdo
SoftwareServo derecho;      //declaramos objeto motor derecho
Ultrasonic ultrasonic(triger,echo); // (Trig PIN,Echo PIN)

//declaramos objeto boton(PIN,CONFIGURACION)
Button button = Button(12,BUTTON_PULLUP_INTERNAL);

//variable para los casos de control
int caso = 0;

//almacenamos la distancia leida por el sensor:
int distancia = 0;
//distancia minima para esquivar
int sp = 10;
//control de proceso.
int loop_cnt=0;


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
  /*Declaraci´n Motor derecho:
  Adelante = 0
  Detras = 180
  */
  derecho.attach(8);
  derecho.setMaximumPulse(2100);   //centraliza el servo por software
  /*Declaracion motor izquierdo:
  Adelante = 180
  Detras = 0
  */
  izquierdo.attach(9);
  izquierdo.setMaximumPulse(2040);   //centraliza el servo por software
  
  button.clickHandler(handleButtonClickEvents);
}

void loop()
{
  button.isPressed();  //update internal state
if( loop_cnt > 100 ) { // every 100 msecs get new data
    loop_cnt = 0;
    distancia = ultrasonic.Ranging(CM);
    //Serial.println(distancia);
}
	loop_cnt++;


switch(caso){
  case 0:
      if (distancia >= sp )
    {
		derecho.write(0);
                izquierdo.write(180);

    }else {
		derecho.write(90);
                izquierdo.write(90);
		
    }
  break;
     if (distancia == sp )
    {
		derecho.write(90);
                izquierdo.write(90);

    }else if (distancia <= sp){
		derecho.write(180);
                izquierdo.write(0);
		
    }else if  (distancia >= sp){
		derecho.write(0);
                izquierdo.write(180);
		
    }
  break;
   case 2:
		derecho.write(90);
                izquierdo.write(90);
  break;
  default:
  caso = 0;          //Reseteamos estado

}
  
  Serial.println(caso);
SoftwareServo::refresh();  //Actualizamos estado motor.
}
