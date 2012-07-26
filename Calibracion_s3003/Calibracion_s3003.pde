#include <Servo.h>

Servo motor1;
struct rueda{
	int pin;
	int st; //-- Analog (0) or ultrasonic (PING) (1)
	};
typedef struct rueda rueda;

//-- Define the sensors:
#define NUM_SENSOR 1

rueda izquierda = 
	{8, 1315}
;
void setup()
{
  motor1.attach(izquierda.pin);
  
}
void loop()
{
 motor1.writeMicroseconds(izquierda.st*1);
}
