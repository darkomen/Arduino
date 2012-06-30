#include <WProgram.h>
#include <Rueda.h>
#include <Servo.h>

//-------------------------
//-- Función attach: Con esta función añadimos un nuevo motor.
//-- pin: pin al que está conectado el servo a la placa.
//-- Center: valor de centrado por software, hace que el motor se detenga.
//-- type: tipo de motor, 0->Izquierda; 1->Derecha
//-------------------------
void Rueda::attach(int pin,unsigned int center,bool type)
{
    _pin = pin;
    _center= center;
    _servo.attach(pin);
    _servo.write(center);
    _type = type;
}
//--------------------------
//__ Función move: Le indicamos una escala del -10 al 10 y el motor girará en funcion de la escala.
//__
//--------------------------
void Rueda::set_move(int dir)
{
	_dir = dir;

                if (_type == 0){
                    _servo.writeMicroseconds(map(_dir,-10,10,_center+500,_center-500));

                } else if (_type == 1){
                    
					_servo.writeMicroseconds(map(_dir,-10,10,_center-500,_center+500));
                }
}