// Ultrasonic.h - Library for HR-SC04 Ultrasonic Ranging Module.
// Rev. 2 (06/2011)
// www.arduino.com.es

#include <Ultrasonic.h>
#include <Tone.h>
long tiempo=0;
Ultrasonic ultrasonic(9,8); // (Trig PIN,Echo PIN)
Tone tone1;

void setup() {
  Serial.begin(9600); 
  tone1.begin(12);
}

void loop()
{
  Serial.println(ultrasonic.Ranging(CM));
  if (ultrasonic.Ranging(CM) > 60){ // CM or INC{
    tone1.stop();
  }
  else if (ultrasonic.Ranging(CM) <= 30 && ultrasonic.Ranging(CM) > 10){
    tiempo=200;
    tone1.play(NOTE_A7, tiempo);
    delay(tiempo*2);
  }
  else if(ultrasonic.Ranging(CM) <= 10 && ultrasonic.Ranging(CM) > 5){
    tiempo=100;
    tone1.play(NOTE_A7, tiempo);
  delay(tiempo*2);
  }
  else if(ultrasonic.Ranging(CM) <= 5){
    tone1.play(NOTE_A7);
  }
   

}



