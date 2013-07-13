//--------------------------------------------------------------
//-- Worm_test.pde
//-- Example of use of the Worm library for generating the locomotion
//-- of modular worm robots in 1D
//-- This example performs the locomotion of a 2-module worm
//--------------------------------------------------------------
//-- (c) Juan Gonzalez-Gomez (Obijuan), Dec 2011
//-- GPL license
//--------------------------------------------------------------
/* -- Do not uncomment it. The Arduino environment 0022 need it
/* -- in order to find the paths
#include <Servo.h>
#include <Oscillator.h>
-----------------------------------------------------------------*/

#include "Worm.h"
#include "skymega.h"

//-- Create the worm
Worm worm;

void setup()
{
  //-- Add the 2 servos to the worm. In this example only 2 servos
  //-- are used, by more can be added (are commented out)
  worm.add_servo(SERVO2);
  worm.add_servo(SERVO4);
  
  //worm.add_servo(SERVO6);
  //worm.add_servo(SERVO8);
  
  //-- The default values are ok for generating
  //-- locomotion. They can be changed using the
  //-- methods: SetA, SetO, SetT, SetPd and SetPh0
  worm.SetT(3000);  //-- Ej. Setting the freq. to 3 sec
  worm.SetA(50);    //-- Ej. setting the amplitude to 60 deg.
}

void loop()
{
  //-- Update the worm state
  worm.refresh();

}


