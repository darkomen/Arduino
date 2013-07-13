/*
PGR Code
  
*/
 
#include <MeetAndroid.h>

const int EnablePinDir = 10;
const int EnablePinMotor = 6;
const int LogicPin1Dir = 11;
const int LogicPin2Dir = 12;
const int LogicPin1Motor = 8;
const int LogicPin2Motor = 9;
float data[3] = {0};
int intdata[3] = {0};
int i = 1;

// MeetAndroid meetAndroid();
// you can define your own error function to catch messages
// where not fuction has been attached for
MeetAndroid meetAndroid(error);

void error(uint8_t flag, uint8_t values){
  Serial.print("ERROR: ");
  Serial.print(flag);
}

 
  void setup() {
  Serial.begin(9600);
  Serial.println("\t\t\t.----------------------.");
  Serial.println("\t\t\t|    Starting Up..     |");
  Serial.println("\t\t\t'----------------------'");
  pinMode(EnablePinDir, OUTPUT);
  pinMode(EnablePinMotor, OUTPUT);
  pinMode(LogicPin1Dir, OUTPUT);
  pinMode(LogicPin2Dir, OUTPUT);
  pinMode(LogicPin1Motor, OUTPUT);
  pinMode(LogicPin2Motor, OUTPUT);
  delay(1000);
  /*
  Serial.println("\t\t\t.----------------------.");
  Serial.println("\t\t\t|    Pin Init Ok,      |");
  Serial.println("\t\t\t|Running Test Sequence.|");
  Serial.println("\t\t\t'----------------------'");
  Serial.println("\t\t\t.----------------------.");
  Serial.println("\t\t\t|  The car should go : |");
  Serial.println("\t\t\t|  forward, backwards, |");
  Serial.println("\t\t\t|Turn left, then right.|");
  Serial.println("\t\t\t'----------------------'");
  
  digitalWrite(LogicPin1Motor, LOW);
  digitalWrite(LogicPin2Motor, HIGH);
  digitalWrite(EnablePinMotor, HIGH);
  delay(500);
  digitalWrite(LogicPin1Motor, HIGH);
  digitalWrite(LogicPin2Motor, LOW);
  digitalWrite(EnablePinMotor, HIGH);
  delay(500);
  digitalWrite(LogicPin1Motor, LOW);
  digitalWrite(LogicPin2Motor, LOW);
  digitalWrite(EnablePinMotor, LOW);
  delay(500);
  digitalWrite(LogicPin1Dir, HIGH);
  digitalWrite(LogicPin2Dir, LOW);
  digitalWrite(EnablePinDir, HIGH);
  delay(500);
  digitalWrite(LogicPin1Dir, LOW);
  digitalWrite(LogicPin2Dir, HIGH);
  digitalWrite(EnablePinDir, HIGH);
  delay(500);
  digitalWrite(LogicPin1Dir, LOW);
  digitalWrite(LogicPin2Dir, LOW);
  digitalWrite(EnablePinDir, LOW);
  
  Serial.println("\t\t\t.----------------------.");
  Serial.println("\t\t\t| Test sequence ended. |");
  Serial.println("\t\t\t'----------------------'");
  */
  
  Serial.println("\t\t\t.----------------------.");
  Serial.println("\t\t\t|     PG-R Ready !     |");
  Serial.println("\t\t\t|      Have Fun !      |");
  Serial.println("\t\t\t'----------------------'");
  

  

  meetAndroid.registerFunction(floatValues, 'A');  


}

void loop()
{
  meetAndroid.receive(); // you need to keep this in your loop() to receive events 
}
void floatValues(byte flag, byte numOfValues)
{
  // create an array where all event values should be stored
  // the number of values attached to this event is given by
  // a parameter(numOfValues)
  
  // call the library function to fill the array with values
  meetAndroid.getFloatValues(data);
  
  // access the values
  for (int i=0; i<3;i++)
  {
    meetAndroid.send(data[i]);
  }
  
//        ..===========================================..
//        ||                                           ||
//        ||     Control Algorithm Beginning here      ||
//        ||                                           ||
//        ''===========================================''
  
  
//         This is for Forward/Reverse
      if (-10<=data[0]<=10)   {
//        Tilt-Proportional Speed 
        intdata[0] = int(data[0]);
        intdata[0] = intdata[0] * 24;
            if (data[0] <= -2) {
              intdata[0] = abs(intdata[0]);
              digitalWrite(LogicPin1Motor, HIGH);
              digitalWrite(LogicPin2Motor, LOW);
              analogWrite(EnablePinMotor, intdata[0]);
            }
            else if (data[0] >= 2) {
              digitalWrite(LogicPin1Motor, LOW);
              digitalWrite(LogicPin2Motor, HIGH);
              analogWrite(EnablePinMotor, intdata[0]);
            }   
            else if (-1<=data[0]<=1) {
              digitalWrite(LogicPin1Motor, LOW);
              digitalWrite(LogicPin2Motor, LOW);
              digitalWrite(EnablePinMotor, LOW);
            }  
      }

//        This is for Turn Left/Turn Right
    if (-10<=data[1]<=10)   {
                if (data[1] <= -2) {
                  digitalWrite(LogicPin1Dir, HIGH);
                  digitalWrite(LogicPin2Dir, LOW);
                  digitalWrite(EnablePinDir, HIGH);
                }
                else if (data[1] >= 2) {
                  digitalWrite(LogicPin1Dir, LOW);
                  digitalWrite(LogicPin2Dir, HIGH);
                  digitalWrite(EnablePinDir, HIGH);
                }
                else if (-1<=data[1]<=1) {
                  digitalWrite(LogicPin1Dir, LOW);
                  digitalWrite(LogicPin2Dir, LOW);
                  digitalWrite(EnablePinDir, LOW);
                }     
    }
    
}

