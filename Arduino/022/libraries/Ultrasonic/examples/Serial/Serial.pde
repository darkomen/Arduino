// Ultrasonic.h - Library for HR-SC04 Ultrasonic Ranging Module.
// Rev. 2 (06/2011)
// www.arduino.com.es

#include <Ultrasonic.h>
Ultrasonic ultrasonic(9,8); // (Trig PIN,Echo PIN)

void setup() {
  Serial.begin(9600); 
}

void loop()
{
  Serial.print(ultrasonic.Ranging(CM)); // CM or INC
  Serial.println(" cm" );
  delay(100);
}