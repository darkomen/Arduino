//Es necesario tener instalada la librería Rueda para un correcto funcionamiento.
#include <Robot.h>
#include <Rueda.h>
#include <Servo.h>
//Declaración objeto tipo Robot.
Robot skybot;


void setup()
{
	/*
	Configuración motores
	robot.motores(pin_izq,center_izq,pin_dch,center_dch)
		pin_izq: indicamos el pin al que está conectado el motor izquierda.
		center_izq: indicamo el valor para el cual el servo se para.
		pin_dch: indicamos el pin al que está conectado el motor derecha.
		center_dch: indicamo el valor para el cual el servo se para.
	*/
skybot.motores(8,1560,9,1345);

Serial.begin(9600);
  
}

void loop(){
	/*
	Accionamiento del motor:
en funcion de la escala del -10 al 10 se con distinta velocidad lineal.
	*/
	// mover(velocidad_lineal,velocidad_angular)
        skybot.mover(10,0);
}