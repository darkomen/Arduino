

#include "WProgram.h"
void setup();
void loop();
int sensorPin = 0; 
int valor = 0;

void setup()
{
  Serial.begin(9600);
}

void loop() {

    valor = analogRead(sensorPin); 
    Serial.print("Temperatura en habitacion: ");
    Serial.print(valor*500/1024,DEC);
    Serial.println(" C");
delay(1000);
  
}

int main(void)
{
	init();

	setup();
    
	for (;;)
		loop();
        
	return 0;
}

