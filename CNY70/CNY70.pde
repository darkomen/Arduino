/*
  Button
 
 Turns on and off a light emitting diode(LED) connected to digital  
 pin 13, when pressing a pushbutton attached to pin 2. 
 
 
 The circuit:
 * LED attached from pin 13 to ground 
 * pushbutton attached to pin 2 from +5V
 * 10K resistor attached to pin 2 from ground
 
 * Note: on most Arduinos there is already an LED on the board
 attached to pin 13.
 
 
 created 2005
 by DojoDave <http://www.0j0.org>
 modified 28 Oct 2010
 by Tom Igoe
 
 This example code is in the public domain.
 
 http://www.arduino.cc/en/Tutorial/Button
 */

// constants won't change. They're used here to 
// set pin numbers:
const int buttonPin = 2;     // the number of the pushbutton pin
const int ledPin =  13;      // the number of the LED pin

// variables will change:
int buttonState = 0;         // variable for reading the pushbutton status
int sensor1,sensor2,sensor3,sensor4;
void setup() {
  Serial.begin(9600);
  // initialize the LED pin as an output:
  pinMode(ledPin, OUTPUT);      
  // initialize the pushbutton pin as an input:
  pinMode(2, INPUT);     
pinMode(3, INPUT);   
pinMode(4, INPUT);   
pinMode(5, INPUT);   
}

void loop(){
  // read the state of the pushbutton value:
  sensor1 = digitalRead(2);
  sensor2 = digitalRead(3);
  sensor3 = digitalRead(4);
  sensor4 = digitalRead(5);  
  Serial.flush();
  Serial.print("Sensor 1 ");
  Serial.println(sensor1);
  Serial.print("Sensor 2 ");
  Serial.println(sensor2);
  Serial.print("Sensor 3 ");
  Serial.println(sensor3);
  Serial.print("Sensor 4 ");
  Serial.println(sensor4);

delay(1000);  
}
