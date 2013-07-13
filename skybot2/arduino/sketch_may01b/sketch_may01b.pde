#include <Servo.h>

Servo izquierda;
Servo derecha;
char buffer[18];
int red, green, blue;
int RedPin = 11;
int GreenPin = 10;
int BluePin = 9;
void setup()
                         {
                             izquierda.attach(9);
  derecha.attach(8);
                           Serial.begin(9600);
                           Serial.flush();
                           Serial.println("INICIALIZANDO SISTEMA");
                           pinMode(RedPin, OUTPUT);
                           pinMode(GreenPin, OUTPUT);
                           pinMode(BluePin, OUTPUT);
}
void loop()
{
if (Serial.available() > 0) {
  int index=0;
  delay(100); // let the buffer fill up
  int numChar = Serial.available();
  if (numChar>15) {
    numChar=15;
  }
  while (numChar--) {
    buffer[index++] = Serial.read();
  }
  splitString(buffer);
}
}
void splitString(char* data) {
  Serial.print("Data entered: ");
  Serial.println(data);
  char* parameter;
  parameter = strtok (data, " ,");
  while (parameter != NULL) {
    setLED(parameter);
    parameter = strtok (NULL, " ,");
  }
  // Clear the text and serial buffers
  for (int x=0; x<16; x++) {
    buffer[x]='\0';
}
  Serial.flush();
}
void setLED(char* data) {
  if ((data[0] == 'w') || (data[0] == 'W')) {
    izquierda.write(0);
    derecha.write(180);
    Serial.println("adelante");

  }
  if ((data[0] == 'a') || (data[0] == 'A')) {
    izquierda.write(81.23455);
    derecha.write(180);
     Serial.println("izquierda");
  }
    if ((data[0] == 'd') || (data[0] == 'D')) {
    izquierda.write(0);
    derecha.write(78.4632);
     Serial.println("derecha");
  }
    if ((data[0] == 's') || (data[0] == 'S')) {
    derecha.write(0);
    izquierda.write(180);
     Serial.println("atras");
  }
    if ((data[0] == 'q') || (data[0] == 'Q')) {
  izquierda.write(81.23455);
   derecha.write(78.4632);
    Serial.println("parado");
  }
   }
