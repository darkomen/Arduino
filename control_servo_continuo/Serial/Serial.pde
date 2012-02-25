#include <SoftwareServo.h>

SoftwareServo servo1;

void setup()
{
  pinMode(13,OUTPUT);
  servo1.attach(9);
  //servo1.setMinimumPulse(145);
  servo1.setMaximumPulse(2040);
  Serial.begin(57600);
}

void loop()
{
  if ( Serial.available()){
       //servo1.write(map(Serial.read(),-100,100,0,180));  
       servo1.write(Serial.read());
  }
 SoftwareServo::refresh();
 
}
