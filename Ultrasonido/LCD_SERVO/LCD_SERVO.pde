// Sweep
// by BARRAGAN <http://barraganstudio.com> 
// This example code is in the public domain.


#include <Servo.h> 
#include <Ultrasonic.h>
#include <Wire.h> 
#include <LiquidCrystal_I2C.h>

Ultrasonic ultrasonic(7,8); // (Trig PIN,Echo PIN)
Servo myservo;  // create servo object to control a servo 
LiquidCrystal_I2C lcd(0x27,20,4);  // set the LCD address to 0x27 for a 16 chars and 2 line display

 
int pos = 0;    // variable to store the servo position 

void setup() 
{ 
  myservo.attach(9);  // attaches the servo on pin 9 to the servo object +
  Serial.begin(9600); 
    lcd.init();                      // initialize the lcd 
  lcd.init();
  // Print a message to the LCD.
  lcd.backlight();
  lcd.setCursor(0,0);
  lcd.print("Servo:");
   lcd.setCursor(0,1);
  lcd.print("Distancia:");
  lcd.setCursor(18,1);
  lcd.print("cm");
  
} 
 
 
void loop() 
{ 
 iniciar_lcd();
  for(pos = 0; pos < 180; pos += 1)  // goes from 0 degrees to 180 degrees 
  {    
    myservo.write(pos);              // tell servo to go to position in variable 'pos' 
    delay(500);   
    lcd.setCursor(10,0);
    lcd.print("   ");
    lcd.setCursor(10,0);
    lcd.print(pos);
    lcd.setCursor(10,1);
    lcd.print("   ");
    lcd.setCursor(10,1);
    lcd.print(ultrasonic.Ranging(CM));    
 
  } 
  for(pos = 180; pos>=1; pos-=1)     // goes from 180 degrees to 0 degrees 
  {           
    myservo.write(pos);              // tell servo to go to position in variable 'pos' 
    delay(500);   
    lcd.setCursor(10,0);
    lcd.print("   ");
    lcd.setCursor(10,0);
    lcd.print(pos);
    lcd.setCursor(10,1);
    lcd.print("   ");
    lcd.setCursor(10,1);
    lcd.print(ultrasonic.Ranging(CM));    
                                          // waits 15ms for the servo to reach the position 
  } 

 
} 
void iniciar_lcd(){
  lcd.clear();
    lcd.setCursor(0,0);
  lcd.print("Servo:");
   lcd.setCursor(0,1);
  lcd.print("Distancia:");
  lcd.setCursor(18,1);
  lcd.print("cm");
}
