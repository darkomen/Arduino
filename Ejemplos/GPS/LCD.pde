
  /*
  Aqui almacenamos todos los menus y
  la manera de contruirlos
  para imprimirlos en el LCD
  */

//Banner inicial del LCD  
void inicio()                         
  {                                              
    lcd.clear();                      // borramos la pantalla para quitar basura anterior
    lcd.setCursor(0, 0);              // posicionamos el cursor
    lcd.print("Proyecto #0009");      // imprimimos la cadena
    lcd.setCursor(0, 1);              // posicionamos el cursor
    lcd.print("Arduino Academy");     // imprimimos la cadena
    delay(3000);                      // hacemos una pausa aunque el gps seguira conectando
    lcd.clear();                      // borramos la pantalla
    lcd.setCursor(0, 0);              // posicionamos el cursor
    lcd.print("Modulo GPS");          // imprimirmos la cadena
    lcd.setCursor(0, 1);              // posicionamos el cursor
    lcd.print("& Display I2C... ");   // imprimimos la cadena
    delay(3000);                      // hacemos una pausa aunque el gps seguira conectando
    lcd.clear();                      // borramos la pantalla
    lcd.setCursor(0, 0);              // posicionamos el cursor
    lcd.print("Iniciando....");       // imprimirmos la cadena
    lcd.blink();                      // dejamos el cursor parapadenando
    delay(4000);                      // hacemos una pausa aunque el gps seguira conectando
    lcd.clear();                      // borramos la pantalla para quitar basura anterior
  }

//Pantalla de espera del GPS mientras se conecta
void esperaGPS(int NumSat)            
{           
  lcd.setCursor(0, 0);                // posicionamos el cursor
  lcd.print("Esperando sat.  ");      // imprimirmos la cadena             
  lcd.setCursor(0, 1);                // posicionamos el cursor
  lcd.print("Sat.Visibles->");        // imprimirmos la cadena
  lcd.setCursor(14, 1);               // posicionamos el cursor
  lcd.print(NumSat);                  // imprimimos la variable  
}


//Menu 1 - Imprime la latitud y la longitud
void LongLat(char *Longitud, char *Brujula1, char *Latitud, char *Brujula2)    //Recogemos los parametros de la funcion
{  
  lcd.setCursor(0, 0);              // posicionamos el cursor
  lcd.print("Lat->");               // imprimimos la cadena
  lcd.print(Latitud[0]);            // imprimimos el primer caracter de la cadena
  lcd.print(Latitud[1]);            // imprimimos el segundo caracter de la cadena
  lcd.print(".");                   // imprimirmos la cadena
  lcd.print(Latitud[2]);            // imprimimos el tercer caracter de la cadena
  lcd.print(Latitud[3]);            // imprimimos el cuarto caracter de la cadena
  lcd.print("'");                   // imprimirmos la cadena
  lcd.print(Latitud[5]);            // imprimimos el quinto caracter de la cadena
  lcd.print(Latitud[6]);            // imprimimos el sexto caracter de la cadena
  lcd.print(" ");                   // imprimirmos la cadena
  lcd.print(Brujula2);              // imprimimos la variable
  lcd.setCursor(0, 1);              // posicionamos el cursor
  lcd.print("Lon->");               // imprimirmos la cadena
  lcd.print(Longitud[1]);           // imprimimos el primer caracter de la cadena
  lcd.print(Longitud[2]);           // imprimimos el segundo caracter de la cadena
  lcd.print(".");                   // imprimirmos la cadena
  lcd.print(Longitud[3]);           // imprimimos el tercer caracter de la cadena
  lcd.print(Longitud[4]);           // imprimimos el cuarto caracter de la cadena
  lcd.print("'");                   // imprimirmos la cadena
  lcd.print(Longitud[6]);           // imprimimos el quinto caracter de la cadena
  lcd.print(Longitud[7]);           // imprimimos el sexto caracter de la cadena
  lcd.print(" ");                   // imprimirmos la cadena
  lcd.print(Brujula1);              // imprimimos la variable
  lcd.setCursor(15, 1);             // posicionamos el cursor
}

//Menu 2.1 que nos imprime la hora en el LCD
void reloj(char *hora)              //recogemos los parametros de la funcion
{                    
  lcd.setCursor(0, 1);              // posicionamos el cursor
  lcd.print("Hora-> ");             // imprimirmos la cadena
  lcd.print(hora[0]);               // imprimimos el primer caracter de la cadena
  lcd.print(hora[1]);               // imprimimos el segundo caracter de la cadena  
  lcd.print(":");                   // imprimirmos la cadena
  lcd.print(hora[2]);               // imprimimos el tercer caracter de la cadena
  lcd.print(hora[3]);               // imprimimos el cuarto caracter de la cadena
  lcd.print(":");                   // imprimirmos la cadena
  lcd.print(hora[4]);               // imprimimos el quinto caracter de la cadena
  lcd.print(hora[5]);               // imprimimos el sexto caracter de la cadena
  lcd.setCursor(16, 1);             // posicionamos el cursor
}


//Menu 2.2 que nos imprime la altitud en el LCD 
void altitud(char *altitud, char *unidades)  //recogemos los parametros de la funcion
{     
  lcd.setCursor(0, 0);              // posicionamos el cursor
  lcd.print("Altitud->");           // imprimirmos la cadena
  lcd.print(altitud);               // imprimimos la variable
  lcd.print(unidades);              // imprimimos la variable
}




