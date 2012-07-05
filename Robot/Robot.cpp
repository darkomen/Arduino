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

void Robot::mover(int lineal, int angular)
{

	_lineal = lineal;
	_angular = angular;
    v_right = (_lineal - _angular)/ 2.0;
    v_left = (_lineal + _angular)/ 2.0;
    Serial.print("Velocidad derecha: ");
    Serial.println(v_right);
       Serial.print("Velocidad izquierda: ");
    Serial.println(v_left);
    /*if (_angular == 0)
    {
        _izquierda.set_move(_lineal); 
        _derecha.set_move(_lineal);
    }
    else if (_angular == -10)
    {
        _izquierda.set_move(0); 
        _derecha.set_move(_lineal);
    }else if (_angular == +10)
    {
        _izquierda.set_move(_lineal);
        _derecha.set_move(0);
    }*/
        _izquierda.set_move(v_left); 
        _derecha.set_move(v_right);  
}