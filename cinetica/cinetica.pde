//Es necesario tener instalada la librería Rueda para un correcto funcionamiento.
#include <Robot.h>
#include <Rueda.h>
#include <Servo.h>
#include <Ultrasonic.h>
Ultrasonic ultrasonic(7,6); // (Trig PIN,Echo PIN)
int setpoint= 10;
int value;
int loop_cnt=0;
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
skybot.motores(8,1315,9,1350);

Serial.begin(9600);
}

void loop(){
  /*if( loop_cnt > 100 ) { // every 100 msecs get new data
    loop_cnt = 0;
    
    
	/*
	Accionamiento del motor:
en funcion de la escala del -10 al 10 se con distinta velocidad lineal.
	
  value = ultrasonic.Ranging(CM); // CM or INC
  delay(100);
  Serial.println(value);
if ((value < setpoint ) || (value >= setpoint*30)){
  
    skybot.mover(0,0);
}
    else if (value >= setpoint ){
    skybot.mover(10,0);
    
    }
  }
  
  loop_cnt++;
  */
  skybot.mover(10,0);
 
}
