/*
 * Serial Read Blink
 * -----------------
 * Turns on and off a light emitting diode(LED) connected to digital  
 * pin 13. The LED will blink the number of times given by a 
 * single-digit ASCII number read from the serial port.
 *
 * Created 18 October 2006
 * copyleft 2006 Tod E. Kurt <tod@todbot.com>
 * http://todbot.com/
 * 
 * based on "serial_read_advanced" example
 */

#include "WProgram.h"
void setup();
void loop ();
int ledPin = 13;   // select the pin for the LED
int val = 0;       // variable to store the data from the serial port

void setup() {
  pinMode(ledPin,OUTPUT);    // declare the LED's pin as output
  Serial.begin(9600);        // connect to the serial port
}

void loop () {
  if (Serial.available() >  0){
  val = Serial.read();
  //val = val -'0';
  
  /*Serial.println(val,DEC);  
  if (val == '1'){
   digitalWrite(ledPin,HIGH);
   Serial.println("encendido");
  }
 if (val == '0'){
   digitalWrite(ledPin,LOW);
   Serial.println("apagado");   
   
   
 }*/
 switch(val){
  case '1': 
      digitalWrite(ledPin,HIGH);
   Serial.println("encendido");
   break;
   case '2':
         digitalWrite(ledPin,HIGH);
         delay(1000);
         digitalWrite(ledPin,LOW);
         delay(1000);
         digitalWrite(ledPin,HIGH);
         delay(1000);
         digitalWrite(ledPin,LOW);
   Serial.println("parpadeo");
   break;
  default: 
      digitalWrite(ledPin,LOW);
   Serial.println("ence");
   break;   
   
 }
  }
}

int main(void)
{
	init();

	setup();
    
	for (;;)
		loop();
        
	return 0;
}

