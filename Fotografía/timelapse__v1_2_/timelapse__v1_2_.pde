/* Time Lapse Casero
Programa para intentar hacer un timelapse casero con Arduino y canon 
v1.1
Notas: Cada salida deberia ir conectado a un rele que haga de interruptor

#salida
Q0.0 = ENFOQUE
Q0.1 = OBTURADOR
#entradas

*/

//DECLARACION DE VARIABLES
#include <Stepper.h>

//Asignamos las salidas:
#define motorSteps 50   
#define enfoque 2      // Pin de enfoque naranja
#define obturador 3    // Pin de obturador marron
#define sensor 4        // Pin del sensor rojo
#define motorPin1 8
#define motorPin2 9
#define ledPin 13
int buttonState = 0;  
int fotos = 5;              // Parametro de las fotos que queremos hacer
long intervalo = 1000;       // Parametro de intervalo entre foto

// initialize of the Stepper library:
Stepper myStepper(motorSteps, motorPin1,motorPin2); 

//Configuracion de arduino
void setup() {
  //motor
    // set the motor speed at 60 RPMS:
  myStepper.setSpeed(100);
  // set up the LED pin:
  pinMode(ledPin, OUTPUT);
  // blink the LED:
  blink(3);
  // Configuramos los pines de salida:
  pinMode(enfoque, OUTPUT);      
  pinMode(obturador, OUTPUT);      
  pinMode(sensor, INPUT);
// En caso de querer trabajar con comunicaciones via USB
  Serial.begin(9600);
  
}
/////////////////////////////////////////////
     /*
     // Funcion enfocar:
     // Debe ser llamada antes que hacer_foto()
     // 
     */
void enfocar_ini(int tiempo_enfoque){
  
     digitalWrite(enfoque, HIGH);  //Activamos la activacion del enfoque
     delay(tiempo_enfoque);        //Reatardo para la siguiente funcion
  }
void enfocar_fin(int tiempo_enfoque){
  
     digitalWrite(enfoque, LOW);  //Desactivamos la activacion del enfoque
     delay(tiempo_enfoque);       //Reatardo para la siguiente funcion
  }

void obturador_ini(int tiempo_obturador){

     digitalWrite(obturador, HIGH);    //Activamos la activacion del obturador
     delay(tiempo_obturador);          //Reatardo para la siguiente funcion
}
void obturador_fin(int tiempo_obturador){

     digitalWrite(obturador, LOW);    //Activamos la activacion del obturador
     delay(tiempo_obturador);         //Reatardo para la siguiente funcion
}
//Una funcion que llama al resto de funciones de forma ordenada.
void hacer_foto(int delay_enfocar_ini, int delay_enfocar_fin, int delay_obturador_ini, int delay_obturador_fin){
    enfocar_ini(delay_enfocar_ini);          //Empezamos a enfocar
    obturador_ini(delay_obturador_ini);       //Hacemos la foto mientas mantenemos el enfoqu
    enfocar_fin(delay_enfocar_fin);          //Terminamos de enfocar
    obturador_fin(delay_obturador_fin);       //Terminamos la foto
  
  }
     /*
     // Programa principal:
     */
// Blink the reset LED:
void blink(int howManyTimes) {
  int i;
  for (i=0; i< howManyTimes; i++) {
    digitalWrite(ledPin, HIGH);
    delay(200);
    digitalWrite(ledPin, LOW);
    delay(200);
  }
}
void loop()
{
  /*
  Hacemos un bucle for desde 0 hasta el numero de fotos que le hayamos indicado 
  */
  buttonState = digitalRead(sensor);
  if (buttonState == HIGH) {     
    // turn LED on:    
    Serial.println("sensor");
    //hacer_foto(500,100,500,100);
    for (int i = 0; i < fotos; i++)
    {
      myStepper.step(20);
      Serial.println("girando");
      delay(500);
      Serial.println("foto");
      hacer_foto(500,100,500,100);
      delay(intervalo);  //tiempo de espera entre una foto y otra.
    }
 } 

}
