#include <SoftwareServo.h>

SoftwareServo servo1;

int potpin = 0;  // analog pin used to connect the potentiometer
int val;    // variable to read the value from the analog pin 
void setup()
{
  pinMode(13,OUTPUT);
  servo1.attach(9);
  servo1.setMaximumPulse(2040);
    Serial.begin(9600);
}

void loop()
{
  val = analogRead(potpin);            // reads the value of the potentiometer (value between 0 and 1023) 
  val = map(val, 0, 1023, 0, 179);     // scale it to use it with the servo (value between 0 and 180) 
  servo1.write(val);
  SoftwareServo::refresh();
  Serial.println(val);
}

