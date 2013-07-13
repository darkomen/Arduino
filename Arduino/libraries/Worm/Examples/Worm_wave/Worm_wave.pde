//--------------------------------------------------------------
//-- Worm_wave.pde
//-- Example of use of the Worm library for generating the locomotion
//-- of modular worm robots in 1D
//-- This example performs the locomotion of a 4-module worm
//-- using "waves"
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

//-- WAVE TABLE
//-- Define the "waves": oscillator's parameters
//-- Each waves correspond to a different locomotion gait
//-- More waves can be added easily
Wave wave[] = {
//  T     A   O    PD      PHASE0  
  {2000, 45,  0,  -120,      0},  //-- Wave 0: Normal locomotion
  {2000, 10,  0,   0,        0},  //-- Wave 1: No locomotion
  {3000, 45, -0,   180,      0},  //-- Wave 2: No locomotion
};

//-- Calculate the Number of waves defined by the user
//-- i.e, the number of rows of the wave table
const int NWAVES = sizeof(wave)/sizeof(Wave);

//-- wave index
//-- It determines the current wave assigned to the worm
//-- It can be changed by the user
int wi=0;

void setup()
{
  //-- Add the servos to the worm. 
  worm.add_servo(SERVO2);
  worm.add_servo(SERVO4);
  worm.add_servo(SERVO6);
  worm.add_servo(SERVO8);
  
  //-- Set the "wave" for the worm
  //-- The robot is ready to move!
  worm.set_wave(wave[wi]);
}

void loop()
{
  //-- Update the worm state
  worm.refresh();

}


