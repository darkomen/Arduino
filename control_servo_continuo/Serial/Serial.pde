#include <Servo.h>

Servo servo1;

void setup()
{
  pinMode(13,OUTPUT);
  servo1.attach(9);
  Serial.begin(57600);
}

void loop()
{
  if ( Serial.available()){
       servo1.write(Serial.read());
  }

}
