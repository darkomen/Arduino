#include <SoftwareServo.h>

SoftwareServo servo1;
SoftwareServo servo2;

void setup()
{
  Serial.begin(9600);
  Serial.print("Ready");
}

void loop()
{
  if ( Serial.available()) {
    char ch = Serial.read();
    switch(ch) {
      case 'A':

        digitalWrite(13,LOW);
        break;
      case 'B':

        digitalWrite(13,HIGH);
        break;
 
  }
}
}
