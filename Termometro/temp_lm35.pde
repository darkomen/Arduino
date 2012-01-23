//http://www.adafruit.com/products/165

int sensorPin = 0; 
void setup()
{
  Serial.println("iniciando");
  Serial.begin(9600);
}
void loop(){

  Serial.println(medir_temperatura());
 delay(2000);
  
}
int medir_temperatura()
{
    int temp = 0;
    temp = analogRead(sensorPin)*500/1024;
    return temp;  
}
