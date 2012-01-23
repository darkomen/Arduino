int my_var = PIND;
void setup(){
 Serial.begin(9600) ;
  DDRD = B00000000; //pines de entrada 0 -7
  DDRB = B11111111;
}
void loop(){
    my_var = PIND & 60;
    Serial.println(my_var);
switch(my_var){
  case 4:
   Serial.println("Adelante"); 
   PORTB = B00000010;
   break;  
  case 8:
   Serial.println("Atras"); 
   PORTB = B00000011;
   break;
  case 16:
   Serial.println("izquierda"); 
   PORTB = B00001000;
   break;
  case 32:
   Serial.println("derecha"); 
   PORTB = B00001100;
   break;
  case 20:
   Serial.println("Giro izquierda"); 
   
   PORTB = B00001110;
   break;
  case 36:
   Serial.println("Giro derecha"); 
   PORTB = B00001010;
   break;
  case 24:
   Serial.println("Retroceso izquierda"); 
   PORTB = B00001010;
   break;
  case 40:
   Serial.println("Retroceso derecha"); 
   PORTB = B00001110;
   break;
  default:
   Serial.println("Parado");
   PORTB = B10000000;
   break; 
 }

 delay(1000);
}
