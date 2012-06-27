//Es necesario incluir librería servo.h
#include <Servo.h>
#include <Rueda.h>
//Declaración objeto tipo rueda
Rueda izquierda;

void setup()
{
/*
Configuración rueda izquierda:
nombre.attach(pin,center,tipo)
	pin: Pin al que está conectado el servo.
	center: Valor númerico para el cual, el servo se detiene.
	tipo: Motor a la izquierda (0) o a la derecha (1) del robot.
*/
izquierda.attach(8,1385,0);
Serial.begin(9600);
  
}

void loop(){
/*
Accionamiento del motor:
	0: adelante.
	1: parado.
	2: detras.
*/	
    izquierda.set_direcction(0); 
}

