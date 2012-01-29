#include <SoftwareServo.h>

SoftwareServo servo1;

void setup()
{
  pinMode(13,OUTPUT);
  servo1.attach(9);
  //servo1.setMinimumPulse(145);
  servo1.setMaximumPulse(2040);
  Serial.begin(9600);
}

void loop()
{
 servo1.write(90);
 SoftwareServo::refresh();
 
}
