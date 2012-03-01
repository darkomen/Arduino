#include <Servo.h>

Servo servo1;

void setup()
{
  pinMode(13,OUTPUT);
  servo1.attach(9);  
  Serial.begin(9600);
}

void loop()
{
 servo1.write(90);
 //SoftwareServo::refresh();
 
}
