#include <Servo.h>
Servo motor1;
int montes;

int center = 1565;
void setup(){
  Serial.begin(9600);
  motor1.attach(8);
}
void loop(){

     motor1.writeMicroseconds(torque(-10));
  delay(2000);
     motor1.writeMicroseconds(torque(-9));
  delay(1000);
      motor1.writeMicroseconds(torque(-8));
  delay(1000);
      motor1.writeMicroseconds(torque(-7));
  delay(1000);
      motor1.writeMicroseconds(torque(-6));
  delay(1000);
      motor1.writeMicroseconds(torque(-5));
  delay(1000);
      motor1.writeMicroseconds(torque(-4));
  delay(1000);
        motor1.writeMicroseconds(torque(-3));
  delay(1000);
        motor1.writeMicroseconds(torque(-2));
  delay(1000);
        motor1.writeMicroseconds(torque(-1));
  delay(1000);
        motor1.writeMicroseconds(torque(0));        
  delay(1000);

}

int torque(int valor){
 return  map(valor,-10,10,center-400,center+400);
  
  
}
