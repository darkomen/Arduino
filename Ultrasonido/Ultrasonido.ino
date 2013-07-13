#include <Ultrasonic.h>
int distancia;
#define TRIGER  6
#define ECHO  7

Ultrasonic ultrasonic(TRIGER,ECHO); // (Trig PIN,Echo PIN)

void setup() {
  pinMode(TRIGER,OUTPUT);
  pinMode(ECHO,INPUT);
  Serial.begin(9600);
}

void loop()
{
  distancia = ultrasonic.Ranging(CM);
  Serial.print(distancia); // CM or INC
  Serial.println(" cm" );
  delay(100);
}
