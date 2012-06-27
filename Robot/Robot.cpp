#include <WProgram.h>
#include <Rueda.h>
#include <Robot.h>
#include <Rueda.h>
#include <Servo.h>

void Robot::motores(int pin_iz, int center_iz,int pin_dch,int center_dch)
{
    _pin_iz = pin_iz;
    _center_iz = center_iz;
    _pin_dch = pin_dch;
    _center_dch = center_dch;

    _izquierda.attach(_pin_iz,_center_iz,0);
    _derecha.attach(_pin_dch,_center_dch,1);
}

void Robot::mover(int dir)
{
	_dir = dir;
    switch (_dir) {
        case 0:
            _izquierda.set_direcction(0); 
            _derecha.set_direcction(0); 
            break;
        case 1: 
            _izquierda.set_direcction(1); 
            _derecha.set_direcction(1);
            break;
        case 2:   
            _izquierda.set_direcction(2); 
            _derecha.set_direcction(2); 
            break;
    }
    
}