//Ficheros para calibrar el servo de rotación continua.
#include <Servo.h>

Servo motor1;

void setup()
{
  motor1.attach(9);
  
}
void loop()
{
 motor1.writeMicroseconds(1350);
}

