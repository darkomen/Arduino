#include <Wire.h>
#include <EasyTransferI2C.h>

//create object
EasyTransferI2C ET; 

struct SEND_DATA_STRUCTURE{
  //put your variable definitions here for the data you want to send
  //THIS MUST BE EXACTLY THE SAME ON THE OTHER ARDUINO
  int position_servo;  //Position of servo [0,180]
};

//give a name to the group of data
SEND_DATA_STRUCTURE mydata;

//define slave i2c address
#define I2C_SLAVE_ADDRESS 9

void setup(){
  Wire.begin();
  //start the library, pass in the data details and the name of the serial port. Can be Serial, Serial1, Serial2, etc.
  ET.begin(details(mydata), &Wire);
}

void loop(){
  mydata.position_servo = analogRead(0);
  mydata.position_servo = map(mydata.position_servo, 0,1023,0,179);
  //this is how you access the variables. [name of the group].[variable name]
  //send the data
  ET.sendData(I2C_SLAVE_ADDRESS);
  
}
