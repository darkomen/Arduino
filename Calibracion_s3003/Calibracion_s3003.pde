

#include <Servo.h>

Servo motor1;
Servo motor2;

void setup()
{
  motor1.attach(9);
  motor2.attach(8);
  
}
void loop()
{
  motor1.write(180);
  motor2.write(0);
 //motor1.writeMicroseconds(1500);
  //motor2.writeMicroseconds(1500);
}

