#include <Servo.h>
#include <Rueda.h>
Rueda izquierda;
Rueda derecha;

void setup()
{
izquierda.attach(8,1385,0);
derecha.attach(9,1300,1);
Serial.begin(9600);
  
}

void loop(){
        mover('a');
        delay(1000);
        mover('b');
        delay(1000);
        mover('c');
        delay(1000);
        

}



void mover(char direccion){
if (direccion == 'a'){
       Serial.println("1");
        izquierda.set_direcction(0); 
        derecha.set_direcction(0); 
}else if (direccion == 'b'){
      Serial.println("2");
        izquierda.set_direcction(1); 
        derecha.set_direcction(1);
}else if (direccion == 'c'){
       Serial.println("3");
        izquierda.set_direcction(2); 
        derecha.set_direcction(2); 
}else {
        izquierda.set_direcction(1); 
        derecha.set_direcction(1);
    }
  
}
