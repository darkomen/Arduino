  /*
  Esta funcion nos va a permitir identificar la trama que necesitamos
  para sacar los datos de longitud, latitud etc.. usados
  en el programa.
  
  Podeis crear vuestros propios filtros para para sacar los datos
  de otras tramas de una manera sencilla, tomando como base esta funcion.
  */
  
 void cadena()
   {
    i=0;                                  // Inicializamos el contador 
    memset(GGA, 0, sizeof(GGA));          // Limpiamos el array GGA introduciendo en el todo ceros
    
    pch = strtok (TramaGPG,",");          // Tokenizamos (troceamos) la cadena que tenemos en el array TramaGPG por las comas  
                                          // y el primer intervalo lo guardamos en pch (puntero char)
    
    //Analizamos ese intervalo guardado en pch para ver si es la cadena que necesitamos
    if (strcmp(pch,"$GPGGA")==0)          // Si es la correcta, seguimos adelante
      {         
        while (pch != NULL)               // Mientras el dato sea valido, lo aceptamos para llenar el array GGA
          {
            pch = strtok (NULL, ",");     // Pasamos al siguiente intervalo cortado de la cadena  
            GGA[i]=pch;                   // Guardamos el valor de pch en el array GGA
            i++;                          // Incrementamos el contador/acumulador
          } 
        
        representa(GGA,"$GPGGA");         // llamamos a la funcion que nos va a mostrar los datos, bien por serial o por LCD
                                          // a esta funcion se le pasan dos paramtros 1º el array de chars, 2º la cadena a comparar.
      }    
  }
