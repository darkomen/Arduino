
const int Trig = 3;
const int Echo = 2;

void setup()
{
  pinMode(Trig, OUTPUT);
  pinMode(Echo, INPUT);
  Serial.begin(9600);
}

unsigned int time_us=0;
unsigned int distance_sm=0;

void loop()
{
  digitalWrite(Trig, HIGH);
  delayMicroseconds(10);
  digitalWrite(Trig, LOW);
  time_us=pulseIn(Echo, HIGH);
  distance_sm=time_us/58;
  Serial.print(distance_sm);
  Serial.print("  ");
  delay(500);
}  
    
