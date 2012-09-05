#include <LiquidCrystal.h>    // Libreria para control del LCD
#include <Wire.h>             // Libreria de comunicacion I2C
#include <DS1307.h>           // Libreria del reloj DS1307
#include <EEPROM.h>           // Libreria para manejo de la memoria EEPROM del Atmega328
#include <TimerOne.h>         // Libreria para uso del TIMER1 del Atmega328

#define rele A3               // Definicion de pines de pulsadores y rele
#define botonUno 2 
#define botonDos 3   
#define botonTres 4
#define botonCuatro 5

#define borraLCD  lcd.clear();                  // Define de la funcion clear() del LCD
#define situaCero lcd.setCursor(0,0);           // Define de la funcion setCursor() del LCD

char fechaActual[20], horaActual[20];          // Variable para formateo de fecha y hora
int RTCValues[7];                              // Variable para el almacenaje de fecha y hora

byte ajuste = 0;
byte seleccion = 0; 
byte estado = 0, ultimoestado = 0;             // Variables para el control de los pulsadores

byte dibujoCampana[8] = {B00100, B01010, B01010, B01010, 
                         B01010, B10001, B11111, B00100};  // Campana
                   
byte flechaArriba[8] =  {B00000, B00100, B01110, B11111,
                         B00100, B00100, B00100, B00000};  // Flecha Arriba
                         
byte flechaAbajo[8] =   {B00000, B00100, B00100, B00100,
                         B11111, B01110, B00100, B00000};  // Flecha Abajo

LiquidCrystal lcd(12, 7, 11, 10, 9, 8);   // Declaracion de los pines del LCD

int direccion, dir, tiempo;   // Variables de trabajo de alarmas. 
int alarmas[33];      // Array de alarmas cargadas desde la EEPROM.
int alarmaActiva[2];  // Alarma activa (Horas, Minutos). 

void setup() 
{
  leeEEPROM();  // Leemos la EEPROM y la almacenamos en un array para trabajar con el. La posicion 0 no se utiliza. 
  
  if(digitalRead(botonTres) == HIGH && digitalRead(botonCuatro) == HIGH) resetEEPROM(); // Si mantenemos pulsados boton 3 y 4 al resetear 
                                                                                        // Se resetea la EEPROM a 0 todas las posiciones. 
  if(digitalRead(botonUno) == HIGH) 
  {                                                                                     // Si mantenemos pulsado el boton 1 al resetear
    configuraTiempo();                                                                  // Entramos en la funcion de configurar el tiempo del timbre. 
  }

  dir = 1;     // Variable que determina el numero de alarma activa = 1
  
  for (int a = 2; a <=5; a++) pinMode(a, INPUT);  // Declaramos los pines de salida
  pinMode(rele, OUTPUT);
  
  lcd.begin(16, 2);                  // Iniciamos LCD 16 caracteres x 2 filas
  lcd.createChar(0, dibujoCampana);  // Caracter personalizado "Campana"
  lcd.createChar(1, flechaArriba);   // Caracter personalizado "Flecha arriba"
  lcd.createChar(2, flechaAbajo);    // Caracter personalizado "Flecha abajo" 
    
  DS1307.begin();                    // Iniciamos el Reloj                
  
  Timer1.initialize(1000000);               // Inicializamos el TIMER1, y lo configuramos para conseguir un segundo
  Timer1.attachInterrupt(compruebaAlarma);  // El desbordamiento del timer lo conectamos con compruebaAlarma()
                                            // para que este cada segundo comparando la hora del reloj y la alarma activa. 
}

void loop() 
{
    menuPrincipal();      // Mostramos el menu principal y esperamos seleccion
}

// ----------------------------------------------------------------------------------------------------------------------
// - MENU PRINCIPAL -----------------------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------------------------------------

void menuPrincipal()
{
   DS1307.getDate(RTCValues);  // Obtenemos hora y fecha constantemente para comparación con alarma activa. 
  
   lcd.setCursor(0, 0); lcd.print("1- Hora/Fecha");      //Mostramos el menu en el LCD. 
   lcd.setCursor(0, 1); lcd.print("2- Alarmas");
   lcd.setCursor(12, 1); lcd.print("3-"); lcd.write(0);

  estado = digitalRead(botonUno);                             
  if (estado != ultimoestado && estado==HIGH) seleccion = 1;
  ultimoestado = estado; 
  
  estado = digitalRead(botonDos);   
  if (estado != ultimoestado && estado==HIGH) seleccion = 2;
  ultimoestado = estado; 
  
  estado = digitalRead(botonTres);    
  if (estado != ultimoestado && estado==HIGH) seleccion = 3;
  ultimoestado = estado; 
  
  estado = digitalRead(botonCuatro);    
  if (estado != ultimoestado && estado==HIGH) seleccion = 4;
  ultimoestado = estado; 

  switch(seleccion)      // Dependiendo del boton pulsado, realizamos una accion u otra. 
  {
     case 1:  borraLCD;
              menuHora();         // BOTON 1  --> Menu hora
              borraLCD;
              break;
              
     case 2:  borraLCD;
              menuAlarma();       // BOTON 2  --> Menu alarma
              borraLCD;
              break;
              
     case 3:  borraLCD;
              activacionManual(); // BOTON 3  --> Activacion Manual
              borraLCD;
              break;
     case 4:  menuPrincipal();    // BOTON 4  --> Activacion de las alarmas una vez configurado todo. 
              break; 
  }  
}

// ----------------------------------------------------------------------------------------------------------------------
// - MENU DE HORA Y MENU DE ALARMA --------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------------------------------------

void menuHora()
{
  do{
     lcd.setCursor(0, 0); lcd.print("1.Mostrar reloj");    // Mostramos el menu hasta pulsar el boton 4 y volver al menu principal. 
     lcd.setCursor(0, 1); lcd.print("2.Ajustar reloj"); 
     delay(200);
     
     estado = digitalRead(botonUno);                       // Si pulsamos el boton 1
     if (estado != ultimoestado && estado==HIGH)           // mostramos la hora hasta que
     {                                                     // se pulse el boton 4. 
        borraLCD;
        delay(100);        
	do{                                                             
	  mostrarHora();          
	}while(digitalRead(botonCuatro) != HIGH);
	borraLCD;      
      }
     ultimoestado = estado; 
  
     estado = digitalRead(botonDos);                        // Si pulsamos el boton 2
     if (estado != ultimoestado && estado==HIGH)            // ajustamos la hora
     {                                                      
        borraLCD; 
        delay(100);        
        ajustarHora();           
	borraLCD;      
      }
     ultimoestado = estado; 
       
  }while(digitalRead(botonCuatro) != HIGH);  
}

void menuAlarma()
{
  do{
     lcd.setCursor(0, 0); lcd.print("1.Mostrar Alarma");    // Mostramos el menu hasta pulsar el boton 4 y volver al menu principal.
     lcd.setCursor(0, 1); lcd.print("2.Ajustar Alarma"); 
     delay(200);
     
     estado = digitalRead(botonUno);                       // Si pulsamos el boton 1
     if (estado != ultimoestado && estado==HIGH)           // mostramos la alarma hasta
     {                                                     // que se pulse el boton 4
        borraLCD;
        delay(100);        
	do{                                                             
	  mostrarAlarmas();         
	}while(digitalRead(botonCuatro) != HIGH);
	borraLCD;      
      }
     ultimoestado = estado; 
  
     estado = digitalRead(botonDos);                      // Si pulsamos el boton 2
     if (estado != ultimoestado && estado==HIGH)          // ajustamos las alarmas hasta
     {                                                    // que se pulse el boton 4
        borraLCD;
        delay(100);        
	do{                                                             
	  ajustarAlarmas();         
	}while(digitalRead(botonCuatro) != HIGH);
	borraLCD;      
      }
     ultimoestado = estado; 
     
  }while(digitalRead(botonCuatro) != HIGH);
}

// ----------------------------------------------------------------------------------------------------------------------
// - FUNCION DE ACTIVACION MANUAL DE LA ALARMA --------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------------------------------------

void activacionManual()
{
    lcd.setCursor(3, 0); lcd.print("Activacion");  // Mostramos el texto de activacion manual
    lcd.setCursor(5, 1); lcd.print("manual");      // Exitamos pulsando el boton 3 la base del transistor
                                                   // que encenderá el relé y hará sonar la alarma
    do{                                            // mientras el boton 3 esté pulsado. 
      digitalWrite(rele, HIGH);
    }while(digitalRead(botonTres) == HIGH);

    digitalWrite(rele, LOW);
    seleccion = 4;
}

// ----------------------------------------------------------------------------------------------------------------------
// - FUNCIONES DEL RELOJ: MOSTRAR HORA Y AJUSTAR HORA -------------------------------------------------------------------
// ----------------------------------------------------------------------------------------------------------------------

void mostrarHora()
{
 do{                               
     DS1307.getDate(RTCValues);                                                             // Obtenemos la hora
     sprintf(horaActual, "%02d:%02d:%02d", RTCValues[4], RTCValues[5], RTCValues[6]);       // La formateamos
     sprintf(fechaActual, "%02d-%02d-%02d", RTCValues[2], RTCValues[1], RTCValues[0]);
               
     lcd.setCursor(4, 0); lcd.print(horaActual);                                            // Y mostramos por pantalla 
     lcd.setCursor(0, 1); lcd.print(diaSemana(RTCValues[3]));  
     lcd.setCursor(8, 1); lcd.print(fechaActual);                                      
  } while(digitalRead(botonCuatro) != HIGH);                                                // Hasta que se pulse el boton 4          
}

void ajustarHora()
{  
    ajuste = 0;                                   // Variable ajuste determina si ajustamos la alarma o cancelamos los cambios                          
    DS1307.getDate(RTCValues);                    // Obtenemos la fecha y hora del reloj
    
    int aHora = RTCValues[4],                     // Almacenamos hora, minutos, segundos, dia semana, dia, mes y ano en variables
        aMinutos = RTCValues[5],                  // para poder trabajar con ellas y aumentar o disminuir los valores. 
        aSegundos = RTCValues[6], 
        aDiaSemana = RTCValues[3], 
        aDia = RTCValues[2],
        aMes = RTCValues[1], 
        aAno = RTCValues[0];

    numeroCero(4,0,aHora);                       // Funcion numeroCero: escribe en pantalla una variable y comprueba
    lcd.print(":");                              // si es menor que 10, en cuyo caso, antepone un 0.
                                                  
    numeroCero(7,0,aMinutos);
    lcd.print(":");
    
    numeroCero(10,0,aSegundos);
    
    lcd.setCursor(0,1);
    lcd.print(diaSemana(aDiaSemana));
    
    numeroCero(8,1,aDia);
    lcd.print("/");

    numeroCero(11,1,aMes);
    lcd.print("/");
    
    numeroCero(14,1,aAno);
    
      do{                                         
        numeroCero(4,0,aHora);                                  // Visualizamos la hora parpadeando
        delay(50);    
        lcd.setCursor(4,0); 
        lcd.print("  "); 
        delay(50);
    
        estado = digitalRead(botonUno);             
        if (estado != ultimoestado && estado==HIGH)            // Mediante boton 1, aumentamos las horas
        {                                                      // si horas es > 23, horas = 0. 
            aHora = aHora + 1;
            if (aHora > 23) aHora = 0;            
        }ultimoestado = estado;   
        
      }while(digitalRead(botonTres) != HIGH);                  // Pulsando boton 3, pasamos al ajuste de minutos
      
      delay(50);
      numeroCero(4,0,aHora);                                  // Mostramos la hora fija ya cambiada. 
      lcd.print(":"); 
      delay(250);
      
     do{                                                      // Visualizamos los minutos parpadeando
        numeroCero(7,0,aMinutos);
        delay(50);    
        lcd.setCursor(7,0); 
        lcd.print("  "); 
        delay(50);
    
        estado = digitalRead(botonUno);                       // Mediante boton 1, aumentamos los minutos
        if (estado != ultimoestado && estado==HIGH)           // si minutos > 59, minutos = 0. 
        {                                          
            aMinutos = aMinutos + 1;
            if (aMinutos > 59) aMinutos = 0;            
        }ultimoestado = estado;   
      }while(digitalRead(botonTres) != HIGH);                 // Pulsando boton 3, pasamos al ajuste de segundos
      
      delay(50);
      numeroCero(7,0,aMinutos);                               // Mostramos los minutos fijos ya cambiados.
      lcd.print(":"); 
      delay(250);
    
      do{                                                     // Visualizamos los segundos parpadeando
        numeroCero(10,0,aSegundos);
        delay(50);    
        lcd.setCursor(10,0); 
        lcd.print("  "); 
        delay(50);
    
        estado = digitalRead(botonUno);                      // Mediante boton 1, aumentamos los segundos
        if (estado != ultimoestado && estado==HIGH)          // si minutos > 59, minutos = 0.
        {                                          
            aSegundos = aSegundos + 1;
            if (aSegundos > 59) aSegundos = 0;            
        }ultimoestado = estado;   
      }while(digitalRead(botonTres) != HIGH);               // Pulsando boton 3, pasamos al ajuste de dia semanal
      
      delay(50);    
      numeroCero(10,0,aSegundos);                           // Mostramos los segundos fijos ya cambiados.
      delay(250);
    
    do{                                                     // Visualizamos el dia de la semana parpadeando
        lcd.setCursor(0,1); 
        lcd.print(diaSemana(aDiaSemana)); 
        delay(50);    
        lcd.setCursor(0,1); 
        lcd.print("        "); 
        delay(50);
    
        estado = digitalRead(botonUno);                    // Mediante boton 1, aumentamos el dia de la semana   
        if (estado != ultimoestado && estado==HIGH)        // si el dia es > 6, dia = 0
        {                                          
            aDiaSemana = aDiaSemana + 1;
            if (aDiaSemana > 6) aDiaSemana = 0;            
        }ultimoestado = estado;   
      }while(digitalRead(botonTres) != HIGH);              // Pulsando boton 3, pasamos al ajuste de dia 
      
      delay(50);
      lcd.setCursor(0,1);
      lcd.print(diaSemana(aDiaSemana));                    // Mostramos el dia semanal ya fijo.
    
    do{                                                    // Visualizamos el dia de la semana parpadeando
        numeroCero(8,1,aDia);
        delay(50);    
        lcd.setCursor(8,1); 
        lcd.print("  "); 
        delay(50);
    
        estado = digitalRead(botonUno);                   // Mediante boton 1, aumentamos el dia
        if (estado != ultimoestado && estado==HIGH)       // si dia > 31, dia = 1. 
        {                                          
            aDia = aDia + 1;
            if (aDia > 31) aDia = 1;            
        }ultimoestado = estado;   
      }while(digitalRead(botonTres) != HIGH);            // Pulsando boton 3, pasamos al ajuste del mes
      
      delay(50);
      numeroCero(8,1,aDia);                              // Mostramos el dia fijo ya cambiado
      lcd.print("/");
    
      do{                                                // Visualizamos el mes parpadeando
        numeroCero(11,1,aMes);
        delay(50);    
        lcd.setCursor(11,1); 
        lcd.print("  "); 
        delay(50);
    
        estado = digitalRead(botonUno);                  // Mediante boton 1, aumentamos el mes
        if (estado != ultimoestado && estado==HIGH)      // si mes > 12, mes = 1.
        {                                          
            aMes = aMes + 1;
            if (aMes > 12) aMes = 1;            
        }ultimoestado = estado;   
      }while(digitalRead(botonTres) != HIGH);           // Pulsando boton 3, pasamos al ajuste del ano
      
      delay(50);
      numeroCero(11,1,aMes);                            // Mostramos el mes fijo ya cambiado
      lcd.print("/");
    
     do{                                                // Visualizamos el ano parpadeando
        numeroCero(14,1,aAno);
        delay(50);    
        lcd.setCursor(14,1); 
        lcd.print("  "); 
        delay(50);
    
        estado = digitalRead(botonUno);                 // Mediante boton 1, aumentamos el ano
        if (estado != ultimoestado && estado==HIGH)     // si ano > 2020, ano = 2012. 
        {                                          
            aAno = aAno + 1;
            if (aAno > 20) aAno = 12;            
        }ultimoestado = estado;   
      }while(digitalRead(botonTres) != HIGH);           // Pulsando boton 3, pasamos a confirmar los cambios.
      
      delay(50);
      numeroCero(14,1,aAno);                            // Mostramos el ano ya cambiado
    
      borraLCD;                                         // Borramos LCD y situamos posicion 0,0
      situaCero;
    
    do{
      
    lcd.print("Ajustar? 1.S 2.N");                      // Preguntamos mostrando la nueva hora/fecha introducida
  
    numeroCero(0,1,aHora);    lcd.print(":");
    numeroCero(3,1,aMinutos); 
    numeroCero(8,1,aDia);     lcd.print("/");
    numeroCero(11,1,aMes);    lcd.print("/");
    numeroCero(14,1,aAno);

      estado = digitalRead(botonUno);                 // Mediante boton 1, aceptamos los cambios  
      if (estado != ultimoestado && estado==HIGH)     // y cambiamos la hora en el reloj
      {
          borraLCD; situaCero;
          DS1307.setDate(aAno, aMes, aDia, aDiaSemana, aHora, aMinutos, aSegundos);  //AJUSTAMOS LA HORA EN EL RELOJ
          lcd.print("Ajuste realizado"); lcd.setCursor(0,1);        
          lcd.print(" correctamente");
          delay(2500);
          ajuste = 1;                                // Variable ajuste = 1 --> Salir del ajuste. 
      }ultimoestado = estado;   
      
      estado = digitalRead(botonDos);                // Mediante boton 2, cancelamos los cambios
      if (estado != ultimoestado && estado==HIGH)    // no hacemos nada. 
      {
          borraLCD; 
          lcd.setCursor(5,0); lcd.print("Ajuste"); 
          lcd.setCursor(4,1); lcd.print("cancelado");
          delay(2500);
          ajuste = 1;                                // Variable ajuste = 1 --> Salir del ajuste.
      }ultimoestado = estado; 
      
    }while(ajuste != 1);
}

// ----------------------------------------------------------------------------------------------------------------------
// - FUNCIONES DE LA ALARMA: MOSTRAR ALARMAS Y AJUSTAR ALARMAS ----------------------------------------------------------
// ----------------------------------------------------------------------------------------------------------------------

void mostrarAlarmas()
{
  leeEEPROM();           // Almacenamos alarmas en array procedentes de la EEPROM.
   
  direccion = 2;         // Direccion de la hora de la primera alarma en el array
    
  do{    
    if(direccion <= 29)  // Si direccion es menor que 29, mostramos la flecha de ABAJO
   { 
     lcd.setCursor(13,1); 
     lcd.print("2."); 
     lcd.write(2);
   }else 
   { 
      lcd.setCursor(13,1); 
      lcd.print("   "); 
   }
   
   if(direccion >= 3)    // Si direccion es mayor que 3 mostramos la flecha de ARRIBA
   {
     lcd.setCursor(13,0); 
     lcd.print("1."); 
     lcd.write(1);
   }else 
   { 
     lcd.setCursor(13,0); 
     lcd.print("   "); 
   }
    
   lcd.setCursor(0,0);   // Imprimimos por pantalla el N de alarma de la linea 1
   lcd.print("Al ");
   if((direccion/2) < 10)
   {  
         lcd.print("0");  
         lcd.print(direccion/2); 
   }else lcd.print(direccion/2); 

   lcd.setCursor(7,0);   // Situamos la posicion de la Alarma de la linea 1

   if(alarmas[direccion-1] < 10)   // Imprimimos por pantalla la HORA de la linea 1 controlando los numeros menores a 10. 
   { 
          lcd.setCursor(7,0); // Situamos la posicion de la Alarma de la linea 1
          lcd.print("0"); 
          lcd.print(alarmas[direccion-1]); 
   } else 
   {   
       lcd.setCursor(7,0); // Situamos la posicion de la Alarma de la linea 1
       lcd.print(alarmas[direccion-1]);
   }
   
   lcd.print(":");  // Imprimimos los dos puntos que separan HORA Y MINUTOS (linea 1)
      
   if(alarmas[direccion] < 10)   // Imprimimos por pantalla los MINUTOS de la linea 1 controlando los numeros menores a 10. 
   { 
         lcd.print("0"); 
         lcd.print(alarmas[direccion]); 
   }else lcd.print(alarmas[direccion]);
       
   lcd.setCursor(0,1);  // Imprimimos por pantalla el N de alarma de la linea 2
   lcd.print("Al "); 
   if(((direccion+2)/2) < 10)
   {  
         lcd.print("0");  
         lcd.print((direccion+2)/2); 
   }else lcd.print((direccion+2)/2); 
    
   if(alarmas[direccion+1] < 10)   // Imprimimos por pantalla la HORA de la linea 2 controlando los numeros menores a 10. 
   { 
         lcd.setCursor(7,1); // Situamos la posicion de la Alarma de la linea 2
         lcd.print("0"); 
         lcd.print(alarmas[direccion+1]); 
   }else 
   {
     lcd.setCursor(7,1); // Situamos la posicion de la Alarma de la linea 2
     lcd.print(alarmas[direccion+1]);
   }
   
   lcd.print(":");  // Imprimimos los dos puntos que separan HORA Y MINUTOS (linea 2)
   
   if(alarmas[direccion+2] < 10) // Imprimimos por pantalla los MINUTOS de la linea 2 controlando los numeros menores a 10. 
   { 
         lcd.print("0"); 
         lcd.print(alarmas[direccion+2]); 
   }else lcd.print(alarmas[direccion+2]);
      
          estado = digitalRead(botonUno);             // Si la direccion es mayor  que 3 y pulsamos el boton 2, disminuimos la direccion.
          if (estado != ultimoestado && estado==HIGH) 
          {
             if (direccion >=3) 
             { 
                 direccion = direccion - 2; 
                 delay(200); 
             }
          }ultimoestado = estado;

    
         estado = digitalRead(botonDos);             // Si la direccion es menor que 29 y pulsamos el boton 2, aumentamos la direccion.
         if (estado != ultimoestado && estado==HIGH) 
         {
             if (direccion <= 29)  
             { 
                 direccion = direccion + 2; 
                 delay(200); 
             }
          }ultimoestado = estado;
         
   }while(digitalRead(botonCuatro) != HIGH);
}

void ajustarAlarmas()
{
    leeEEPROM();      // Almacenamos alarmas en array procedentes de la EEPROM.
  
    direccion = 2;    // Situamos la direccion de la primera alarma en la EEPROM (No empieza desde 0).
  
    do{
        
      lcd.setCursor(0,1);  lcd.print("1."); lcd.write(1);    // Imprimimos por pantalla el menu
      lcd.setCursor(4,1);  lcd.print("2."); lcd.write(2);
      lcd.setCursor(8,1); lcd.print("3.Ajust.");    
      
      lcd.setCursor(0,0);
      lcd.print("Alarma ");
      
      if((direccion/2)<10)        // Imprimimos por pantalla el numero de alarma.
      {
            lcd.print("0");
            lcd.print((direccion/2));
      }else lcd.print((direccion/2));
      
      lcd.setCursor(11,0);
      
      if((alarmas[direccion-1])<10)  // Imprimimos por pantalla la HORA de la alarma seleccionada
      {
            lcd.print("0");
            lcd.print(alarmas[direccion-1]);
      }else lcd.print(alarmas[direccion-1]);
      
      lcd.print(":");
      
      if((alarmas[direccion] < 10)) // Imprimimos por pantalla los MINUTOS de la alarma seleccionada
      {
            lcd.print("0");
            lcd.print(alarmas[direccion]);
      }else lcd.print(alarmas[direccion]);
      
      delay(60);
      estado = digitalRead(botonUno);                 // Si pulsamos el boton 1, disminuimos las alarmas. 
      if (estado != ultimoestado && estado==HIGH) 
      {
         if (direccion >=3)  direccion = direccion - 2;             
      }ultimoestado = estado;  
    
      delay(60);
      estado = digitalRead(botonDos);                // Si pulsamos el boton 2, aumentamos las alarmas. 
      if (estado != ultimoestado && estado==HIGH) 
      {
         if (direccion <= 31) direccion = direccion + 2; 
      }ultimoestado = estado;      
      
      
      estado = digitalRead(botonTres);                // Si pulsamos el boton 2, ajustamos la alarma seleccionada.
      if (estado != ultimoestado && estado==HIGH) 
      {
         delay(60);
         do{
              lcd.setCursor(11,0);      
              if((alarmas[direccion-1])<10)          // Imprimimos por pantalla la HORA de la alarma seleccionada
              {
                lcd.print("0");
                lcd.print(alarmas[direccion-1]);
              }else lcd.print(alarmas[direccion-1]);
               
              delay(50);
              
              lcd.setCursor(11,0); lcd.print("  ");
   
              delay(50);
              
              estado = digitalRead(botonUno);                // Si pulsamos el boton 1, aumentamos la hora
              if (estado != ultimoestado && estado==HIGH) 
              {
                 alarmas[direccion-1] = alarmas[direccion-1] + 1;
                 if (alarmas[direccion-1] > 23) 
                 { 
                    alarmas[direccion-1] = 0; 
                 }
              }ultimoestado = estado;                        
           
         }while(digitalRead(botonTres) != HIGH);
         
         EEPROM.write(direccion-1, alarmas[direccion-1]);  // ALMACENAMOS LA HORA MODIFICADA EN LA EEPROM!! 
         delay(200);
         
         do{
              lcd.setCursor(11,0);      
              if((alarmas[direccion-1])<10)  // Imprimimos por pantalla la HORA de la alarma seleccionada
              {
                lcd.print("0");
                lcd.print(alarmas[direccion-1]);
              }else lcd.print(alarmas[direccion-1]);
              
              lcd.setCursor(14,0);      
              if((alarmas[direccion] < 10)) // Imprimimos por pantalla los MINUTOS de la alarma seleccionada
              {
                    lcd.print("0");
                    lcd.print(alarmas[direccion]);
              }else lcd.print(alarmas[direccion]);
               
              delay(50);
              
              lcd.setCursor(14,0); lcd.print("  ");
   
              delay(50);
              
              estado = digitalRead(botonUno);                // Si pulsamos el boton 1, aumentamos los minutos
              if (estado != ultimoestado && estado==HIGH) 
              {
                 alarmas[direccion] = alarmas[direccion] + 1;
                 if (alarmas[direccion] > 59) alarmas[direccion] = 0; 
              }ultimoestado = estado;                        
           
         }while(digitalRead(botonTres) != HIGH);
         
         EEPROM.write(direccion, alarmas[direccion]);  // ALMACENAMOS LOS MINUTOS MODIFICADOS EN LA EEPROM!! 
         delay(200);
         
      }ultimoestado = estado;     
    
    }while(digitalRead(botonCuatro) != HIGH);
    
    leeEEPROM(); // Volvemos a cargar el array de alarmas con los cambios realizados en la EEPROM. 
}

// ----------------------------------------------------------------------------------------------------------------------
// - FUNCION QUE COMPARA LA HORA Y LA ALARMA ACTIVA CADA SEGUNDO MEDIANTE EL TIMER0 -------------------------------------
// ----------------------------------------------------------------------------------------------------------------------

void compruebaAlarma()                 
{     
  alarmaActiva[0] = alarmas[dir];                                            // Almacenamos en la alarmaActiva la primera alarma del array de alarmas
  alarmaActiva[1] = alarmas[dir+1];                                          // que se carga en la funcion leeEEPROM(), al reiniciar el sistema. 

   if((alarmaActiva[0] != 0) && (alarmaActiva[1] != 0))                      // Si la alarma es distinta de HH:MM = 00:00
   {
      if(RTCValues[4] == alarmaActiva[0] && RTCValues[5] == alarmaActiva[1]) // Comparamos la hora y minutos del reloj,               
      {                                          	                     // con la hora y minutos de la alarmaActiva. 
        
          if(int(RTCValues[6]) < tiempo)                                     // Si los segundos del reloj son menor que 5
          { 			                                             // suena la alarma, activa el rele. 
             digitalWrite(rele, HIGH);
          }else                                                              // Si los segundos han aumentado y son mayor que 5
          {                                                                  // apaga el rele, aumenta la direccion del array de alarmas
             digitalWrite(rele, LOW);                                        // y comprueba que el array no llega a su fin.
             dir = dir + 2;       
             if(dir > 31) dir = 1;
          }     
      }
      
   }else if((alarmaActiva[0] == 0) && (alarmaActiva[1] == 0))               // Si la alarma activa = 00:00, salta a la siguiente alarma
   {                                                                        // aumentando en 2, la posicion del array. 
    dir = dir + 2; 
   }
}

// ----------------------------------------------------------------------------------------------------------------------
// - FUNCIONES DE CONFIGURACION -----------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------------------------------------

void numeroCero(int posCaracter, int fila, int variable)  // Funcion que escribe en pantalla una variable y comprueba
{                                                         // si es menor que 10, en cuyo caso, antepone un 0. 
    lcd.setCursor(posCaracter, fila); 
    if(variable < 10) 
    { 
       lcd.setCursor(posCaracter, fila); 
       lcd.print("0"); 
       lcd.print(variable); 
     }
    else lcd.print(variable);
}

// ----------------------------------------------------------------------------------------------------------------------
// - FUNCIONES DE LA MEMORIA EEPROM -------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------------------------------------

void leeEEPROM()                                // Leemos la EEPROM y la almacenamos en un array para trabajar con el.
{
  for(direccion=0; direccion<=32; direccion++)  
  alarmas[direccion] = EEPROM.read(direccion);  
 
  tiempo = EEPROM.read(100); 
  if(tiempo == 0) 
  { 
    tiempo = 6;
    EEPROM.write(100, tiempo);
  }
}

void resetEEPROM()                              // Recorre cada posicion de la EEPROM y almacena un 0. 
{
    for (int i = 0; i < 512; i++)
    EEPROM.write(i, 0); 
}

void configuraTiempo()
{
  borraLCD;
  situaCero;
  
  lcd.print("Tiempo: ");      // Mostramos menu y tiempo
  lcd.setCursor(9,0);
  lcd.print(tiempo);
  lcd.setCursor(12,0);
  lcd.print("seg.");
  lcd.setCursor(0,1);
  lcd.print("2.+ ");
  lcd.setCursor(5,1);
  lcd.print("4.Salir");
  
  do
  {
      lcd.setCursor(9,0);      
      lcd.print(tiempo);
                 
      estado = digitalRead(botonDos);                // Si pulsamos el boton 2, aumentamos el tiempo del timbre
      if (estado != ultimoestado && estado==HIGH)    // Si el tiempo es > 20 segundos, tiempo = 1 segundo.
      {
          tiempo = tiempo + 1; 
          delay(80);
          lcd.setCursor(9,0);
          lcd.print("  ");
        
          if(tiempo > 20)
          {
             tiempo = 1; 
          }
       } ultimoestado = estado;       
          
  }while(digitalRead(botonCuatro) != HIGH);
  
  EEPROM.write(100, tiempo);                         // Guardamos el tiempo en memoria. 
}

/*void escribeEEPROM()                          // Almacena en la EEPROM el horario de los timbres del instituto
{                                               // Ejecutar esta funcion, y luego comentarla!! para que no esté 
    EEPROM.write(1, 8);   EEPROM.write(2,0);    // constantemente cargando estos datos en la EEPROM!
    EEPROM.write(3, 9);   EEPROM.write(4,15);
    EEPROM.write(5, 10);   EEPROM.write(6,15);
    EEPROM.write(7, 11);   EEPROM.write(8,15);
    EEPROM.write(9, 11);   EEPROM.write(10,45);
    EEPROM.write(11, 12);   EEPROM.write(12,45);
    EEPROM.write(13, 13);   EEPROM.write(14,45);
    EEPROM.write(15, 14);   EEPROM.write(16,45);
    EEPROM.write(17, 15);   EEPROM.write(18,0);
    EEPROM.write(19, 16);   EEPROM.write(20,0);
    EEPROM.write(21, 16);   EEPROM.write(22,55);
    EEPROM.write(23, 17);   EEPROM.write(24,50);
    EEPROM.write(25, 18);   EEPROM.write(26,5);
    EEPROM.write(27, 19);   EEPROM.write(28,0);
    EEPROM.write(29, 19);   EEPROM.write(30,55);
    EEPROM.write(31, 20);   EEPROM.write(32,50);
}*/

// ----------------------------------------------------------------------------------------------------------------------
// - FIN DEL CODIGO -----------------------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------------------------------------
