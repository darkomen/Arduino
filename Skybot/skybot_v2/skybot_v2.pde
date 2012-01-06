#include <SoftwareServo.h>     // includes the servo libs
SoftwareServo LeftServo;       // name the servo
SoftwareServo RightServo;      // name the servo
#include <Ultrasonic.h>
Ultrasonic ultrasonic(7,6); // (Trig PIN,Echo PIN)


int ultraSoundSignal = 7; // Ultrasound signal pin
int val = 0;
int val2 = 0;
int ultrasoundValue = 0;
int timecount = 0; // Echo counter
int ledPin = 13; // LED connected to digital pin 13
int lightSense = 2;
int headLight = 8;

void setup(){
   pinMode(10,OUTPUT);
   pinMode(9,OUTPUT); 
   LeftServo.attach(10);	 // Attaches the Left Servo to PWM pin 6 on the Arduino
   RightServo.attach(9); // Attaches the Right Servo to PWM pin 5 on the Arduino
   pinMode(headLight, OUTPUT);
   pinMode(lightSense, INPUT);
   Serial.begin(9600);                  // Sets the baud rate to 9600
   pinMode(ledPin, OUTPUT);            // Sets the digital pin as output
}

void moveServoLeftTo(int angle, int duration){
  // command the servo to move to the given angle for the given number of milliseconds  
   LeftServo.write(angle);		
   for( ; duration > 0; duration -= 20){  // loop for the given number of milliseconds by subtracting 20ms each iteration
	 LeftServo.refresh();             // call the service routine to move the servo 
	 delay(20);		          // wait 20 milliseconds  between each refresh 
   }
}
void moveServoRightTo(int angle, int duration){
  // command the servo to move to the given angle for the given number of milliseconds  
   RightServo.write(angle);		
   for( ; duration > 0; duration -= 20){  // loop for the given number of milliseconds by subtracting 20ms each iteration
	 RightServo.refresh();            // call the service routine to move the servo 
	 delay(20);		          // wait 20 milliseconds  between each refresh 
}  

}
void loop() {


ultrasoundValue =  ultrasonic.Ranging(CM);          // Append echo pulse time to ultrasoundValue

//delay(1);

// Servo functions: The basics 

  if(ultrasoundValue > 500){
	moveServoLeftTo(45,50);   // move the left servo to 45 degrees for 500 milliseconds
	moveServoRightTo(180,50);  // moveRightTo function is left as an excercise ;) 
  }
  
  if(ultrasoundValue < 500){
      moveServoLeftTo(180,40); 
      moveServoRightTo(180,40);

  } 
    
     if(ultrasoundValue < 50){
      moveServoLeftTo(180,100); 
      moveServoRightTo(45,100);
      //moveServoLeftTo(45,50);
      //moveServoRightTo(180,50);

  } 
// Headlight - Turns on when photoresistor is triggered  
// Doesn't seem to work on the same circuit... not sure why yet.
/*  val2 = digitalRead(lightSense);  // read input value
  if (val == HIGH) {            // check if the input is HIGH
    digitalWrite(headLight, LOW);  // turn LED OFF
  } else {
    digitalWrite(headLight, HIGH); // turn LED ON
  */
    
}




