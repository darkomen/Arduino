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
        Serial.println(valor);
    irrecv.resume(); // Receive the next value
  }
}
