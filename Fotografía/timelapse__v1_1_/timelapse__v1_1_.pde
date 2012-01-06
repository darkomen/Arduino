/* Time Lapse Casero
Programa para intentar hacer un timelapse casero con Arduino y canon 
v1.1
Notas: Cada salida deberia ir conectado a un rele que haga de interruptor

#salidas
Q0.0 = ENFOQUE
Q0.1 = OBTURADOR
#entradas

*/

//DECLARACION DE VARIABLES

//Asignamos las salidas:
const int enfoque =  2;      // Pin de enfoque
const int obturador =  3;    // Pin de obturador
const int sensor = 8;        // Pin del sensor
int buttonState = 0;  
int fotos = 5;              // Parametro de las fotos que queremos hacer
long intervalo = 1000;       // Parametro de intervalo entre foto

//Configuracion de arduino
void setup() {
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
void loop()
{
  /*
  Hacemos un bucle for desde 0 hasta el numero de fotos que le hayamos indicado 
  */
/*for (int i = 0; i <= fotos; i++)
{
  
  hacer_foto(100,100,500,100);
  delay(intervalo);  //tiempo de espera entre una foto y otra.
}
/*
*/
  buttonState = digitalRead(sensor);
  if (buttonState == HIGH) {     
    // turn LED on:    
    //hacer_foto(500,100,500,100);
    for (int i = 0; i <= fotos; i++)
{
  
  hacer_foto(500,100,500,100);
  delay(intervalo);  //tiempo de espera entre una foto y otra.
}
  } 

}
