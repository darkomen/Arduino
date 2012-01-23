/*
////////////////////////////////////////////////////////////////////////////////
  Orugas

 Codigo para el robot orugas

 El circuito:
 * Driver de motor DC
 * Nunchuck en las E/S analogicas
 * 2 Servos para el Pan&Tilt
 * Laser de 5v
 
 Librerias y codigos externos:
 * nunchuck_funcs.h  http://todbot.com/blog/2008/02/18/wiichuck-wii-nunchuck-adapter-available/
 * control TB6612FNG http://www.arduino.cc/cgi-bin/yabb2/YaBB.pl?num=1263858213

 Vídeo:                       www.youtube.com/watch?v=3fnAs-LZAjA

 creado el 1 de Mayo de 201
 Por Alejandro Taracido Cano (@TCRobotics) esscorpyATgmail.com
 Canal de youtube:             http://www.youtube.com/user/TCRobotics
 ///////////////////////////////////////////////////////////////////////////////
 */

#define out_STBY 9
#define out_B_PWM 11
#define out_A_PWM 6
#define out_A_IN2 7
#define out_A_IN1 8
#define out_B_IN1 10
#define out_B_IN2 12
#define motor_A 0
#define motor_B 1
#define motor_AB 2

#include <Wire.h>
#include "nunchuck_funcs.h"
#include <Servo.h> 

int loop_cnt=0;
int pos = 0;
byte accx,accy,accz,joyx,joyy;
boolean zbut,cbut;
int ledPin = 13;
int laserPin= 2;
Servo servoX;
Servo servoY;
float angleX = 0;
float angleY = 0;
float tiltX = 0;
float tiltY = 0;
float pos_servox = 90;
float pos_servoy = 90;
int loopCount = 0;
int avgCount = 0;


void setup()
{
  pinMode(out_STBY,OUTPUT);
  pinMode(out_A_PWM,OUTPUT);
  pinMode(out_A_IN1,OUTPUT);
  pinMode(out_A_IN2,OUTPUT);
  pinMode(out_B_PWM,OUTPUT);
  pinMode(out_B_IN1,OUTPUT);
  pinMode(out_B_IN2,OUTPUT);
  pinMode(laserPin,OUTPUT);   
  Serial.begin(19200);
  nunchuck_setpowerpins();
  nunchuck_init(); // send the initilization handshake
  servoX.attach(5);
  servoY.attach(3);
  servoX.write(90);
  servoY.write(90);
}

void loop()
{
  
  if( loop_cnt > 10 ) { // every 100 msecs get new data
        
        loop_cnt = 0;
       
        nunchuck_get_data();

        accx  = nunchuck_accelx(); // ranges from approx 70 - 182
        accy  = nunchuck_accely(); // ranges from approx 65 - 173
        accz  = nunchuck_accelz();
        joyx  = nunchuck_joyx() ;
        joyy  = nunchuck_joyy() ;
        zbut  = nunchuck_zbutton();
        cbut  = nunchuck_cbutton(); 
        
        //nunchuck_print_data();
          
        tiltY += map(accx, 50, 184, -50, 50);
        tiltX += map(accy, 50, 182, -100, 100);

        angleX += map(joyx, 0, 255, 180, 0);
        angleY += map(joyy, 0, 255, 0, 180) + 1;
        
        if (zbut==1) {digitalWrite(laserPin, HIGH);} //Laser ON/OFF
        else {digitalWrite(laserPin, LOW);} 
         

        if(avgCount  >=5 & cbut==0) // Normal mode without press button C
          {
          //Center position of nunchuck without move  
          if (tiltX>-10 & tiltX< 10 & tiltY>-20 & tiltY< 20){motor_standby(true);} 
          else{motor_standby(false);}
            
          motor_speed2(motor_A,tiltX-tiltY);
          motor_speed2(motor_B,tiltX+tiltY);
          delay(100);
          motor_standby(true);
            
          tiltX = 0;
          tiltY = 0;
          
          }
        
        if(avgCount  >=5 & cbut==1) //Mode Pan & Tilt button C pressed
          {
          servoX.write((angleX/5)+10);
          servoY.write(angleY/5);
          angleX = 0;
          angleY = 0;
          avgCount = 0;
          }
        avgCount++;
    }
   
    loop_cnt++;
    //delay(2);

}


//motor Driver functions/////////////////////////////////////////////////////////////////////////////// 

void motor_speed2(boolean motor, char speed) { //speed from -100 to 100
  byte PWMvalue=0;
  PWMvalue = map(abs(speed),0,100,50,255); //anything below 50 is very weak
  if (speed > 0)
    motor_speed(motor,0,PWMvalue);
  else if (speed < 0)
    motor_speed(motor,1,PWMvalue);
  else {
    motor_coast(motor);
  }
}
void motor_speed(boolean motor, boolean direction, byte speed) { //speed from 0 to 255
  if (motor == motor_A) {
    if (direction == 0) {
      digitalWrite(out_A_IN1,HIGH);
      digitalWrite(out_A_IN2,LOW);
    } else {
      digitalWrite(out_A_IN1,LOW);
      digitalWrite(out_A_IN2,HIGH);
    }
    analogWrite(out_A_PWM,speed);
  } else {
    if (direction == 0) {
      digitalWrite(out_B_IN1,HIGH);
      digitalWrite(out_B_IN2,LOW);
    } else {
      digitalWrite(out_B_IN1,LOW);
      digitalWrite(out_B_IN2,HIGH);
    }
    analogWrite(out_B_PWM,speed);
  }
}
void motor_standby(boolean state) { //low power mode
  if (state == true)
    digitalWrite(out_STBY,LOW);
  else
    digitalWrite(out_STBY,HIGH);
}
void motor_brake(boolean motor) {
  if (motor == motor_A) {
    digitalWrite(out_A_IN1,HIGH);
    digitalWrite(out_A_IN2,HIGH);
  } else {
    digitalWrite(out_B_IN1,HIGH);
    digitalWrite(out_B_IN2,HIGH);
  }
}
void motor_coast(boolean motor) {
  if (motor == motor_A) {
    digitalWrite(out_A_IN1,LOW);
    digitalWrite(out_A_IN2,LOW);
    digitalWrite(out_A_PWM,HIGH);
  } else {
    digitalWrite(out_B_IN1,LOW);
    digitalWrite(out_B_IN2,LOW);
    digitalWrite(out_B_PWM,HIGH);
  }
} 
