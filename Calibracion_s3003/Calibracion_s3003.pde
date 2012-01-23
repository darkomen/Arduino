void setup()
{
  pinMode(9, OUTPUT);
}

void loop()
{
  digitalWrite(9, HIGH);
  delayMicroseconds(150); // Approximately 10% duty cycle @ 1KHz
  digitalWrite(9, LOW);
  delayMicroseconds(1000 - 150);
}
