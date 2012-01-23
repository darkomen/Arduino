#define SERVO1 9
#define SERVO2 10
#define CEN 0

void setup()
{
}

void loop()
{
throttle(100,-100);
}

// Maneja el avance o retroceso, recibe la velocidad desde -100 a 100 %
void throttle(int Mot1, int Mot2)
{
  analogWrite(SERVO1,(Mot1> CEN || Mot1<-CEN) ? map(-Mot1,-100,100,135,225):0);
//Giro al contrario
  analogWrite(SERVO2,(-Mot2> CEN || -Mot2<-CEN) ? map(Mot2,-100,100,135,225):0);
}
