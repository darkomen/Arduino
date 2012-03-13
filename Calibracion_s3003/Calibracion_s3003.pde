#include <Servo.h>

Servo servo1;
int derecha = 180;
int izquierda = 0;
int parado = 90;
void setup()
{
  pinMode(13,OUTPUT);
  servo1.attach(9);  
  Serial.begin(9600);
}

void loop()
{
 servo1.write(derecha);
delay(5000);
servo1.write(izquierda);
delay(5000);
servo1.write(parado);
delay(5000);

 
}
