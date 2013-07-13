/* HelloWorld_Tiny                     BroHogan                        2/4/11
 * An example of using LiquidCrystal_I2C for the ATTiny85 to display Hello World.
 * A minor mod was made to use the TinyWireM lib instead of the Wire lib when 
 *  compiling for the ARtiny85. The TinyWireM lib must be in your Libraries folder.
 * SETUP:
 * ATtiny Pin 1 = (RESET) N/U                      ATtiny Pin 2 = (D3) N/U
 * ATtiny Pin 3 = (D4) to LED1                     ATtiny Pin 4 = GND
 * ATtiny Pin 5 = SDA on GPIO                      ATtiny Pin 6 = (D1) N/U
 * ATtiny Pin 7 = SCK on GPIO                      ATtiny Pin 8 = VCC (2.7-5.5V)
 * NOTE! - It's very important to use pullups on the SDA & SCL lines!
 * Special thanks to Mario H. - author of LiquidCrystal_I2C.
 */

#include "TinyWireM.h"                  // uses TinyWireM lib low level functions
#include <LiquidCrystal_I2C.h>          // for LCD w/ GPIO MODIFIED for the ATtiny85
#define LED1_PIN         4              // ATtiny Pin 3
#define GPIO_ADDR        0x3F           // (PCA8574A A0-A2 @5V) typ. A0-A3 Gnd 0x20 / 0x38 for A

LiquidCrystal_I2C lcd(GPIO_ADDR,16,2);  // set address & 16 chars / 2 lines

void setup(){
  pinMode(LED1_PIN,OUTPUT);             // for general DEBUG use
  Blink(LED1_PIN,3);                    // show it's alive
  lcd.init();                           // initialize the lcd & TinyWireM
  lcd.backlight();                      // Print a message to the LCD.
  lcd.print("Hello, Tiny!");
}

void loop(){
}


void Blink(byte led, byte times){ // poor man's GUI
  for (byte i=0; i< times; i++){
    digitalWrite(led,HIGH);
    delay (400);
    digitalWrite(led,LOW);
    delay (175);
  }
}

