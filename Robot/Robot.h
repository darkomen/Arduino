//-------------------------------------
//-- Robot.h
//-- Santiago López Pina (darkomen), Junio 2012


#ifndef Robot_h
#define Robot_h
#include <WProgram.h>
#include <Servo.h>
#include <Rueda.h>
//-- Constantes usadas para facilitar la sintaxis del programa
class Robot
{
    
public:
    //Robot nombre;
    Robot(){};
    // nombre.motores(pin_iz, center_iz, pin_dch, center_dch);
    //  - parametros de los motores
    void motores(int pin_iz, int center_iz,int pin_dch,int center_dch);
    // nomber.mover(x);
    //  - mandamos mover al motor.
    void mover(int dir);
    
//Variables internas de la librería.
private:
	Rueda _izquierda;
    Rueda _derecha;
    int _center_iz;
    int _pin_iz;
    int _center_dch;
    int _pin_dch;
    int _dir;
};
#endif