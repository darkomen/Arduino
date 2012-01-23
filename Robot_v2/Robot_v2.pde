//Control de robot segun la distancia
//incluimos librerias necesarias
#include <Ultrasonic.h>
//Variables internas del programa
#define TRIGER 6
#define ECHO 7
#define PARED 10
int distancia;
//Inicializamos librerias
Ultrasonic ultrasonic(TRIGER,ECHO); // (Trig PIN,Echo PIN)
void setup() {
  //Configuramos entradas/salidas
  Serial.begin(9600);
  DDRB = B11111111;
}

void loop()
{
  //digitalWrite(ENABLE,HIGH);
  distancia = ultrasonic.Ranging(CM);
  Serial.println(distancia); // CM or INC
  
  if (distancia > PARED){
  PORTB = B00000010;
  Serial.println("adelante");
  }
  else{
  PORTB = B00000011;
  Serial.println("A tras");
  }  
}


