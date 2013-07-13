//http://www.adafruit.com/products/165
float tempC;
int reading;
int tempPin = 0;

void setup()
{
analogReference(INTERNAL);
Serial.begin(9600);
}

float temperatura()
{
reading = analogRead(tempPin);
return reading / 9.31;
}

void loop()
{
sendMessage(temperatura());
delay(1000);
}


void sendMessage(float temp){
  Serial.flush();
  // send the given tag and value to the serial port
  Serial.println("HEADER");
  //Serial.print(":");
  Serial.println(temp);
}

