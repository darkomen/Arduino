#include <IRremote.h>

int RECV_PIN = 11;
int valor;
IRrecv irrecv(RECV_PIN);
decode_results results;

void setup()
{
  Serial.begin(9600);
  irrecv.enableIRIn(); // Start the receiver
}

void loop() {
  if (irrecv.decode(&results)) {
    valor = results.value;
  switch (valor) {
  case 20587:    // your hand is on the sensor
    Serial.println("mas");
    break;
  case 12395:    // your hand is close to the sensor
    Serial.println("menos");
    break;
  case 24683:    // your hand is a few inches from the sensor
    Serial.println("adelante");
    break;
  case -28565:    // your hand is nowhere near the sensor
    Serial.println("atras");
    break;
  case -24469:  
    Serial.println("menu");
    break;
  default:
    Serial.println("opcion no reconocida");
    Serial.println(valor);
    break;  
} 
    
    
    irrecv.resume(); // Receive the next value
  }
  
  
}
