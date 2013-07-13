/*
||
|| @file Loop.pde
|| @version 1.0
|| @author Capt.Tagon
||
|| @description
|| | Create an array of LED instances and play Knight Rider with them.
|| #
||
|| @license
|| | Copyright (c) 2009 Alexander Brevig. All rights reserved.
|| | This code is subject to AlphaLicence.txt
|| | alphabeta.alexanderbrevig.com/AlphaLicense.txt
|| #
||
*/

#include <LED.h>

const byte NUMBER_OF_LEDS = 5;
const byte TIMER = 100;

//create array of LED instances, wire LEDs from pin 8 to 12 (to ground through a resistor).
LED led[NUMBER_OF_LEDS] = { LED(8), LED(9), LED(10), LED(11), LED(12) };

byte currentLED = 0; //keep track of current LED to blink

void setup(){/*no setup required*/}

void loop(){
  for (currentLED = 0; currentLED < NUMBER_OF_LEDS; currentLED++) {
   led[currentLED].on();
   delay(TIMER);
   led[currentLED].off();
  }
  for (currentLED = NUMBER_OF_LEDS-1; currentLED >= 0; currentLED--) {
   led[currentLED].on();
   delay(TIMER);
   led[currentLED].off();
  }
}
