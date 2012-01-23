//http://www.adafruit.com/products/165
//Creamos las variables necesarias.
int temperatura[10];
int sensorPin = 0; 
int suma = 0;
int media = 0;
int i;
int j;
void setup()
{
  Serial.println("iniciando");
  Serial.begin(9600);
}
void loop(){
  //Inicializamos memorias de media
 media = 0;
 suma = 0; 
 Serial.println("Leyendo Sensor");
 //Metemos en un array 10 valores de temperatura
 for (i=0;i<10;i++)
 {
 Serial.print(".");
 temperatura[i] = medir_temperatura();
 delay(1000);
 }
 Serial.println("\nCalculando Media");
 //calculamos la media de las temperaturas que hemos obtenido
 for (j=0;j<10;j++)
 {
 suma = suma + temperatura[j]; 
 }
 media = suma / 10;
 Serial.print("La media de temperatura es: ");
 Serial.println(media);
 delay(2000);
}
int medir_temperatura()
{
    int temp = 0;
    temp = analogRead(sensorPin)*500/1024;
    return temp;  
}
