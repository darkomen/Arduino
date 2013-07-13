#include "WProgram.h"
// look for IR codes and print them as they are received

#include <NECIRrcv.h>
#define IRPIN 4    // pin that IR detector is connected to

void setup();
void loop();
NECIRrcv ir(IRPIN) ;

void setup()
{
  Serial.begin(9600) ;
  Serial.println("NEC IR code reception") ;
  ir.begin() ;
}

void loop()
{
  unsigned long ircode ;
  
  while (ir.available()) {
    ircode = ir.read() ;
    Serial.print("got code: 0x") ;
    Serial.println(ircode,HEX) ;
  }
}

int main(void)
{
	init();

	setup();
    
	for (;;)
		loop();
        
	return 0;
}

