/*
||
|| @file Blink.pde
|| @version 1.1
|| @author Alexander Brevig
|| @contact alexanderbrevig@gmail.com
||
|| @description
|| | Display the intuitive way of blinking an LED when using this Hardware Abstraction Library
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

//create a LED object at digital pin 13
LED led = LED(13);

void setup(){/*no setup required*/}

void loop(){
  led.blink(2000);//on a second, off a second
}
