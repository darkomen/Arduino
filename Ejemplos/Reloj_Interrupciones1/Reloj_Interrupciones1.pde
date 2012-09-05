#include <TimerOne.h>  

int segundos = 0;
int minutos = 0;
int horas = 0;

void setup()
{
  Serial.begin(9600);
  Timer1.initialize(1000000);         // inicializamos el timer1, y lo configuramos para conseguir un segundo
  Timer1.attachInterrupt(interrupcion_por_tiempo);  // El desbordamiento del timer lo conectamos con interrupcion_por_tiempo ()
}

void interrupcion_por_tiempo()
{
  segundos++;
  if(segundos > 59) { minutos++; segundos = 0; }
  if(minutos > 59) { horas++; minutos = 0; }
}

void loop()
{
   Serial.print(horas); Serial.print(":"); Serial.print(minutos); Serial.print(":"); Serial.println(segundos);
}
