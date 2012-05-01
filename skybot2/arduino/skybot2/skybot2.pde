#include <Servo.h>

Servo izquierda;
Servo derecha;
int accion;
void setup()
{
  pinMode(13,OUTPUT);
  izquierda.attach(9);
  derecha.attach(8);
  Serial.begin(9600);
  Serial.flush();
}

void loop()
{
  while ( Serial.available()>0){
    //delay(10);
    accion=Serial.read();
   
  switch (accion) {
  case 'w':    // your hand is on the sensor
    izquierda.write(0);
    derecha.write(180);
    break;
  case 'a':    // your hand is close to the sensor
    izquierda.write(81.23455);
    derecha.write(180);
    break;
  case 'd':    // your hand is a few inches from the sensor
    izquierda.write(0);
    derecha.write(78.4632);
    break;
  case 's':    // your hand is nowhere near the sensor
    derecha.write(0);
    izquierda.write(180);
    break;
   case 'q':
   izquierda.write(81.23455);
   derecha.write(78.4632);
   break;
   //default:
   //izquierda.write(81.23455);
   //derecha.write(78.4632);
  } 
    
  }
   //izquierda.write(81.23455);
   //derecha.write(78.4632);
   
}
