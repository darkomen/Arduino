#include <skymega.h>
#include <Servo.h>
#include <MeetAndroid.h>

// declare MeetAndroid so that you can call functions with it
MeetAndroid meetAndroid;
Servo izquierda;
Servo derecha;

int accion = 'q';
int inicio = 0;
void setup()
{
  pinMode(13,OUTPUT);
  izquierda.attach(9);
  derecha.attach(8);
  Serial.begin(57600); 
  
  // register callback functions, which will be called when an associated event occurs.
  meetAndroid.registerFunction(fadelante, 'a');
  meetAndroid.registerFunction(fdetras, 'd');
  meetAndroid.registerFunction(fizquierda, 'l');
  meetAndroid.registerFunction(fderecha, 'r');
  meetAndroid.registerFunction(fparo, 'p');
  Serial.flush();
}

void loop()
{
   izquierda.writeMicroseconds(1350);
   derecha.writeMicroseconds(1330);
  meetAndroid.receive();
 
    
  }
  

   //izquierda.writeMicroseconds(1350);
   //derecha.writeMicroseconds(1330);
 void fadelante(byte flag, byte numOfValues)
{
  digitalWrite(13,HIGH);
   izquierda.writeMicroseconds(1360-200);
   derecha.writeMicroseconds(1350+200);
}  
 void fdetras(byte flag, byte numOfValues)
{
    izquierda.writeMicroseconds(1360+200);
    derecha.writeMicroseconds(1350-200);
}
 void fizquierda(byte flag, byte numOfValues)
{
   izquierda.writeMicroseconds(1360);
   derecha.writeMicroseconds(1350+200);
}  
 void fderecha(byte flag, byte numOfValues)
{
    izquierda.writeMicroseconds(1360-200);
    derecha.writeMicroseconds(1350);
}  
 void fparo(byte flag, byte numOfValues)
{
  izquierda.writeMicroseconds(1350);
   derecha.writeMicroseconds(1330);
}  
