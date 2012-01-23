/*
 Stepper Motor Controller
 language: Wiring/Arduino

 This program drives a unipolar or bipolar stepper motor.
 The motor is attached to digital pins 8 and 9 of the Arduino.

 The motor moves 100 steps in one direction, then 100 in the other.

 Created 11 Mar. 2007
 Modified 7 Apr. 2007
 by Tom Igoe

 */

// define the pins that the motor is attached to. You can use
// any digital I/O pins.

#include <Stepper.h>

#define motorSteps 50     // (360/3,75)change this depending on the number of steps
                           // per revolution of your motor
#define motorPin1 10
#define motorPin2 11
#define ledPin 13

// initialize of the Stepper library:
Stepper myStepper(motorSteps, motorPin1,motorPin2); 

void setup() {
  // set the motor speed at 60 RPMS:
  myStepper.setSpeed(50);

  // Initialize the Serial port:
  Serial.begin(9600);

  // set up the LED pin:
  pinMode(ledPin, OUTPUT);
  // blink the LED:
  blink(3);
}

void loop() {
  // Step forward 100 steps:
  Serial.println("Forward");
  myStepper.step(50);
  delay(500);

  // Step backward 100 steps:
  Serial.println("Backward");
  myStepper.step(-50);
  delay(500); 

}

// Blink the reset LED:
void blink(int howManyTimes) {
  int i;
  for (i=0; i< howManyTimes; i++) {
    digitalWrite(ledPin, HIGH);
    delay(200);
    digitalWrite(ledPin, LOW);
    delay(200);
  }
}  

