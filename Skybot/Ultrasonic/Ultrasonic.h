// Ultrasonic - Library for HR-SC04 Ultrasonic Ranging Module.
// Rev. 2 (06/2011)
// www.arduino.com.es


#ifndef Ultrasonic_h
#define Ultrasonic_h

#include "WProgram.h"

#define CM 1
#define INC 0

class Ultrasonic
{
  public:
    Ultrasonic(int TP, int EP);
    long Timing();
    long Ranging(int sys);

    private:
    int Trig_pin;
    int Echo_pin;
    long  duration,distacne_cm,distance_inc;
    
};

#endif