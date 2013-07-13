int distancia;
int sp = 10;
int loop_cnt=0;
int orden;
#define SERVO1 9
#define SERVO2 10
#define CEN 0
#include <Ultrasonic.h>
Ultrasonic ultrasonic(7,6); // (Trig PIN,Echo PIN)

void setup()
{
  Serial.begin(9600);
}

void loop()
{
  if( loop_cnt > 100 ) { // every 100 msecs get new data
    loop_cnt = 0;
    distancia = ultrasonic.Ranging(CM);
    Serial.println(distancia);
  }
	loop_cnt++;
    if (distancia == sp )
    {
		orden = 0;	//quieto
    }else if(distancia > sp ){
		orden = 1; //avanzar
    }else if(distancia < sp ){
		orden = 2; //retroceder
	}	
switch (orden){
	case 0:
		//Serial.println("quieto");
		break;

	case 1:
		//Serial.println("avance");
		throttle(-100,-100);
		
		break;
	case 2: 
		//Serial.println("retroceso");
		throttle(-100,0);
		break;
}


}

// Maneja el avance o retroceso, recibe la velocidad desde -100 a 100 %
void throttle(int Mot1, int Mot2)
{
  analogWrite(SERVO1,(Mot1> CEN || Mot1<-CEN) ? map(-Mot1,-100,100,135,225):0);
//Giro al contrario
  analogWrite(SERVO2,(-Mot2> CEN || -Mot2<-CEN) ? map(Mot2,-100,100,135,225):0);
}


