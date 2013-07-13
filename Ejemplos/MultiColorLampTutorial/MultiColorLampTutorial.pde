/*
  Multicolor Lamp (works with Amarino and the MultiColorLamp Android app)
  
  - based on the Amarino Multicolor Lamp tutorial
  - receives custom events from Amarino changing color accordingly
  
  author: Bonifaz Kaufmann - December 2009
*/
 
#include <MeetAndroid.h>

// declare MeetAndroid so that you can call functions with it
MeetAndroid meetAndroid;

// we need 3 PWM pins to control the leds
int Led = 13;   

void setup()  
{
  // use the baud rate your bluetooth module is configured to 
  // not all baud rates are working well, i.e. ATMEGA168 works best with 57600
  Serial.begin(9600); 
  pinMode(Led,OUTPUT);
  // register callback functions, which will be called when an associated event occurs.
  digitalWrite(Led, HIGH);
  delay(1000);
  meetAndroid.registerFunction(red, 'o');
  digitalWrite(Led,LOW);
}

void loop()
{
  meetAndroid.receive(); // you need to keep this in your loop() to receive events
}

/*
 * Whenever the multicolor lamp app changes the red value
 * this function will be called
 */
void red(byte flag, byte numOfValues)
{
  boolean bombilla = false;
  bombilla =  meetAndroid.getInt();
  Serial.println(bombilla);
  if (bombilla == 1){
    digitalWrite(Led,HIGH);
  }
    else
    {
      digitalWrite(Led,LOW);
    }
}
