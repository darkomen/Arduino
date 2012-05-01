#include <Servo.h>

Servo izquierda;
Servo derecha;
int accion = 'q';
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
   izquierda.writeMicroseconds(1350-200);
   derecha.writeMicroseconds(1330+200);
    break;
  case 'a':    // your hand is close to the sensor
   izquierda.writeMicroseconds(1350);
   derecha.writeMicroseconds(1330+200);
    break;
  case 'd':    // your hand is a few inches from the sensor
    izquierda.writeMicroseconds(1350-200);
    derecha.writeMicroseconds(1330);
    break;
  case 's':    // your hand is nowhere near the sensor
    izquierda.writeMicroseconds(1350+200);
    derecha.writeMicroseconds(1330-200);
    break;
   case 'q':
   izquierda.writeMicroseconds(1350);
   derecha.writeMicroseconds(1330);
   break;
   //default:
   //izquierda.write(81.23455);
   //derecha.write(78.4632);
  } 
    
  }
  

   //izquierda.writeMicroseconds(1350);
   //derecha.writeMicroseconds(1330);
   
}
