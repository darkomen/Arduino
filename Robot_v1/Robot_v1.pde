//Control de robot segun la distancia
//incluimos librerias necesarias
#include <Ultrasonic.h>
#include <Stepper.h>
//Asignamos las entradas al simbolico
#define D1 2
#define D2 3
#define ENABLE 4
#define TRIGER  6 // PWD
#define ECHO  7
//Variables internas del programa
#define PARED 10
#define motorSteps 48   
#define velocidad 120
int distancia;
int direccion = 0; // 0 adelante ; 1 Atras
//Inicializamos librerias
Stepper myStepper(motorSteps, D1,D2); 
Ultrasonic ultrasonic(TRIGER,ECHO); // (Trig PIN,Echo PIN)
void setup() {
  //Configuramos entradas/salidas
  //pinMode(TRIGER,OUTPUT);
  //pinMode(ECHO,INPUT);
  pinMode(D1, OUTPUT);
  pinMode(D2, OUTPUT);
  pinMode(ENABLE, OUTPUT);
  //asignamos Velocidad del motor
  myStepper.setSpeed(velocidad);
  Serial.begin(9600);
  DDRB = B11111111;
}

void loop()
{
  //digitalWrite(ENABLE,HIGH);
  distancia = ultrasonic.Ranging(CM);
  delay(500);
  Serial.println(distancia); // CM or INC
  
  if (distancia < PARED){
  direccion = 1;
  }
  else{
  direccion = 0;
  }  
  
  switch(direccion){
   case 0:
   Serial.println("adelante");
   PORTB = B00000010;
    break;
   case 1 :
   Serial.println("A tras");
   PORTB = B00000011;
    break; 
    
    
  }
}


