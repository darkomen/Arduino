//Es necesario tener instalada la librería Rueda para un correcto funcionamiento.
#include <Robot.h>
#include <Rueda.h>
#include <Servo.h>
//Declaración objeto tipo Robot.
Robot skybot;
char buffer[18];

void setup()
{
	/*
	Configuración motores
	robot.motores(pin_izq,center_izq,pin_dch,center_dch)
		pin_izq: indicamos el pin al que está conectado el motor izquierda.
		center_izq: indicamo el valor para el cual el servo se para.
		pin_dch: indicamos el pin al que está conectado el motor derecha.
		center_dch: indicamo el valor para el cual el servo se para.
	*/
skybot.motores(8,1315,9,1350);
Serial.begin(9600);
  
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
    Serial.println("adelante");
    skybot.mover(10,0);
  }
  if ((data[0] == 'a') || (data[0] == 'A')) {
    skybot.mover(10,-5);
    Serial.println("izquierda");
  }
  if ((data[0] == 'd') || (data[0] == 'D')) {
    skybot.mover(10,5);
    Serial.println("derecha");
  }
  if ((data[0] == 's') || (data[0] == 'S')) {
    skybot.mover(-10,0);
    Serial.println("atras");
  }
  if ((data[0] == 'q') || (data[0] == 'Q')) {
    skybot.mover(0,0);
    Serial.println("parado");
  }
}
