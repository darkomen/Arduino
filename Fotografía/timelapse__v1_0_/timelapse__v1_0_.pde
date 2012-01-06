/* Time Lapse Casero
Programa para intentar hacer un timelapse casero con Arduino y canon 
v1.0
Notas: Cada salida deberia ir conectado a un rele que haga de interruptor

#salidas
Q0.0 = ENFOQUE
Q0.1 = OBTURADOR
#entradas

*/

//DECLARACION DE VARIABLES

//Asignamos las salidas:
const int enfoque =  0;      // Pin de enfoque
const int obturador =  13;    // Pin de obturador

int fotos = 10;              // Parametro de las fotos que queremos hacer
long intervalo = 1000;       // Parametro de intervalo entre foto

//Configuracion de arduino
void setup() {
  // Configuramos los pines de salida:
  pinMode(enfoque, OUTPUT);      
  pinMode(obturador, OUTPUT);      
  // En caso de querer trabajar con comunicaciones via USB
  Serial.begin(9600);
}
/////////////////////////////////////////////
     /*
     // Funcion enfocar:
     // Debe ser llamada antes que hacer_foto()
     // 
     */
void enfocar(int tiempo_enfoque){
  
     digitalWrite(enfoque, HIGH);  //Activamos la activacion de la salida
     delay(tiempo_enfoque);                   //Mantenemos la salida activada 500ms
     digitalWrite(enfoque, LOW);   //Desactivaoms la salida
  
}
     /*
     // Funcion hacer foto:
     */
void hacer_foto(int tiempo_obturador){

     digitalWrite(obturador, HIGH);    //Activamos la activacion de la salida
     delay(tiempo_obturador);                       //Mantenemos la salida activada 500ms
     digitalWrite(obturador, LOW);     //Desactivaoms la salida
}

     /*
     // Programa principal:
     */
void loop()
{
  /*
  Hacemos un bucle for desde 0 hasta el numero de fotos que le hayamos indicado 
  */
for (int i = 0; i <= fotos; i++)
{
  
  enfocar(500);          //Enfocamos
  hacer_foto(500);      //Hacemos la foto
  delay(intervalo);  //tiempo de espera entre una foto y otra.
}
}
