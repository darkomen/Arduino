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
izquierda.attach(8,1600,1);
Serial.begin(9600);
  
}

void loop(){
	//Valor desde -10 a 10 para indicar la velocidad de movimiento de la rueda.
    izquierda.set_move(10); 
}

