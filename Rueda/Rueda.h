#ifndef Rueda_h
#define Rueda_h
#include <WProgram.h>
#include <Servo.h>

class Rueda
{
    
public: 
    Rueda(){};
    void attach(int pin,unsigned int center,bool type);
    void set_direcction(int dir);
    
    
private:
	Servo _servo;
    unsigned int _center;
    int _dir;
    int _pin;
    bool _type;
    
};
#endif