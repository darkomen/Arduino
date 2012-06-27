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
//__ Función direcction: hacemos que el motor se mueva hacía delante o atrás en función
//__ de si es el motor de la derecha o la izquierda.
//__ 0-> Adelante
//__ 1-> Parado
//__ 2-> Detras
//__
//--------------------------
void Rueda::set_direcction(int dir)
{
	_dir = dir;

	    switch (_dir) {
        case 0:
                if (_type == 0){
                    _servo.writeMicroseconds(_center*-2);

                } else if (_type == 1){
                    _servo.writeMicroseconds(_center*+2);
                }
                        break;
        case 1: 
                if (_type == 0){
                    _servo.writeMicroseconds(_center);
                        
                } else if (_type == 1){
                    _servo.writeMicroseconds(_center);
                }
            break;
        case 2:   
                if (_type == 0){
                    _servo.writeMicroseconds(_center*2);
                    
                } else if (_type == 1){
                    _servo.writeMicroseconds(_center*-2);
                }
        break;
    }
     
}