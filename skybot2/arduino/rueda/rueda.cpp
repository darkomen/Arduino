//--------------------------------------------------------------
//-- Worm Library. Generation of locomotion gaits in worm modular
//-- robots. A worm is defined as a 1D topology modular robot in
//-- which all the modules are connected in the same orientation,
//-- so that the worm only can move forward or backward
//--
//--  The locomotion is achieved by means os generating "waves".
//-- All the robot's servos perform a sinusoidal oscillation
//-- with the same parameters:
//--  T: Period (in ms)
//--  A: Amplitude (in deg)
//--  O: Offset (in deg)
//--  and a constant phase difference (PD) between two consecutive
//--  modules
//--------------------------------------------------------------
//-- (c) Juan Gonzalez-Gomez (Obijuan), David Estévez, Dec 2011
//-- GPL license
//--------------------------------------------------------------

#include <Servo.h>
#include "rueda.h"

//-- Macro for converting from degrees to radians


Rueda::Rueda()
{
  //-- Initially the robot consist of 0 servos
  _nservo=0
  //-- Initial phase
  _stop=0;
  
  //-- Initial phase difference
  _direction=-120;
}

void Rueda::add_servo(int pint,bool rev)
{
   servo[_nservos].attach(pin);
   
}
void Rueda::set_stop(int stop)
{
	_stop = stop;
   
}


void Rueda::set_dir(int dir )
{
 switch (dir) {
  case 0:    // your hand is on the sensor
servo[_nservos].writeMicroseconds(_stop);
  case -1:    // your hand is close to the sensor
    servo[_nservos].writeMicroseconds(_stop*-2);
    break;
  case 1:    // your hand is a few inches from the sensor
  servo[_nservos].writeMicroseconds(_stop*2);
  break;
  }
}