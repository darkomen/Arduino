
  /*
  Esta funcion nos va a organizar los datos
  recibidos del gps, para imprimirlos
  en el LCD y en el monitor de puerto serie.
  */

void representa(char **GGAPrint, char *trama)                              // Capturamos los datos pasados a la funcion
{              
  Estado = atoi(GGAPrint[5]);                                              // Transformamos el char que contiene el estado de la conexion a un entero
  sat = atoi(GGAPrint[6]);                                                 // Transformamos el char que contiene el numero de satelites a un entero
  
  
  if(trama=="$GPGGA" && Estado==1)                                         // Si la trama que tenemos es $GPGGA y el estado esta a 1 (conectado)
    { 
      digitalWrite(12, HIGH);                                              // Indicamos que hay conexion satelite encendiendo el led
      
      //Imprimimos en el LCD 
      if(menu==1)
        {                                                                  // Muestra toda la informacion de la pantalla correspondiente
          LongLat(GGAPrint[3],GGAPrint[4],GGAPrint[1],GGAPrint[2]);        // Impmrime latitud y longitud en display
        }
      
      if(menu==2)
        {   
          altitud(GGAPrint[8],GGAPrint[9]);                                // Imprime altitud en el LCD  
          reloj(GGAPrint[0]);                                              // Imprime la hora en formato UTC
        }
      
      
      //Ademas de imprimir en el LCD, sacamos los datos por el puerto serie de Arduino  
      
      Serial.println("");                                                  
      Serial.println("----------------------------------------------");
      Serial.print("Hora UTC -> ");
      Serial.println(GGAPrint[0]);
      Serial.print("Latitud -> ");
      Serial.print(GGAPrint[1]);
      Serial.println(GGAPrint[2]);
      Serial.print("Longitud -> ");
      Serial.print(GGAPrint[3]);
      Serial.println(GGAPrint[4]);
      Serial.print("Indicacion de calidad GPS: 0=nula; 1=GPS fija -> ");
      Serial.println(GGAPrint[5]);
      Serial.print("Numero de satelites visibles por el receptor -> ");
      Serial.println(sat);
      Serial.print("Dilucion horizontal de posicion -> ");
      Serial.println(GGAPrint[7]);
      Serial.print("Altitud de la antena por encima / por debajo del nivel del mar (geoidal) -> ");
      Serial.print(GGAPrint[8]);
      Serial.println(GGAPrint[9]);
      Serial.print("Separacion geoidal -> ");
      Serial.print(GGAPrint[10]);
      Serial.println(GGAPrint[11]);
      Serial.println("----------------------------------------------");
      Serial.println("");
   
    }
  
  else                                                                   // Si no ha conexion satelite
    {                                                                      
     digitalWrite(12, LOW);                                              // Apagamos el led de conectado
     esperaGPS(sat);                                                     // llamamos a la funcion de LCD que representa el numero de satelites conectados..
     Serial.println("");                                                 // e imprimimos por el serial un banner con el numero de satelites conectados
     Serial.println("-----------------------------");                    
     Serial.print("|---Satelites visibles -->");
     Serial.print(sat);
     Serial.println(" |");
     Serial.println("|----Esperando ubicacion----|");
     Serial.println("-----------------------------");
     Serial.println("");   
  }
}


