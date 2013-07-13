

//#### LIBRERIAS ####
#include <Wire.h>               // Libreria control I2C
#include <LiquidCrystal_I2C.h>  // Libreria control LCD
#include <Button.h>             // Libreria control Boton
#include <TimerOne.h>           // Libreria controldel TIMER1 del Atmega328
#include <Tone.h>               // Libreria para control de altavoz
//#### FIN LIBRERIAS ####

//#### OBJETOS ####
LiquidCrystal_I2C lcd(0x27,20,4);  // set the LCD address to 0x27 for a 16 chars and 2 line display
Tone sonido;                      // Objeto de altavoz
//#### FIN OBJETOS ####

//#### DEFINICIONES ####
#define borraLCD  lcd.clear();                  // Define de la funcion clear() del LCD
#define situaCero lcd.setCursor(0,0);           // Define de la funcion setCursor() del LCD
#define led 13                            // Led de estado
#define botonUno 2                        // Pin donde esta conectado el boton uno
#define botonDos 3                        // Pin donde esta conectado el boton dos
#define botonTres 4                       // Pin donde esta conectado el boton tres
#define insoladora 5                      // Pin donde esta conectado el circuito de la insoladora
#define altavoz 6                         // Pin donde esta conectado el altavoz
//#### FIN DEFINICIONES ####

//#### VARIABLES ####
byte seleccion = 0;                       // Almacena la seleccion realizada
byte estado = 0, ultimoestado = 0;        // Variables para el control de los pulsadores
int temp = 0;                             // Variable temporal para configurar retardo insolacion
int temporizador = 10;                  // Variable con valor de temporizacion
int temporizador_cont = 0;                // Variable que muestra el tiempo insolando continuo
byte pantalla = 0;                        // Pantalla Actual, 0-menu principal;1-temp;2-cont;3-config
bool msg= false;                          // Variable que muestra el mensaje inicial.
bool continuo = false;                    // Varible que indica si el modo continuo esta ACTIVADO
bool temporiz = false;                    // Varible que indica si el modo temporizado esta ACTIVADO
//#### FIN VARIABLES ####

//#### INICIO DE CONFIGURACION ####
void setup()
{
  pinMode(led,OUTPUT);                    // Led como salida
  pinMode(insoladora,OUTPUT);             // Insoladora como salida
  lcd.init();                             // initialize the lcd 
  lcd.init();
  lcd.backlight();                        
  Timer1.initialize(1000000);             // Inicializamos el TIMER1, y lo configuramos para conseguir un segundo
  Timer1.attachInterrupt(temporizacion);  // El desbordamiento del timer lo conectamos con compruebaAlarma()
  Timer1.stop();                          // Paramos el temporizador.
  sonido.begin(altavoz);                  // Inicializamos el altavoz
  Serial.begin(9600);
  Serial.println("------------------------------");
  Serial.println("-Temporizador insoladora V1.0-");
  Serial.println("--------Santiago Lopez-------- ");
  Serial.println("------------------------------");
}
//#### INICIO DE PROGRAMA ####
void loop()
{
  if (msg){                      // Mostramos el mensaje de inicio.
    borraLCD;
    situaCero;
    lcd.print("Iniciando:");
    for (int i=0;i<=19;i++){
      lcd.setCursor(i,2);
      lcd.print(".");
      delay(250);
    }
    lcd.print("DONE!");
    delay(500);
    msg = false;
    borraLCD;
  }
    menuPrincipal();                // Mostramos la pantalla inicial.
}

//####MENUS DEL LCD####
void menuPrincipal()
{
  // Inicializamos las variables
  // Estando en esta pantalla TODO tiene que estar en reposo.
  //temporizador = 5;
  pantalla = 0;
  temporizador_cont = temp;
  Timer1.stop();
  continuo = false;
  temporiz = false;
  digitalWrite(led,LOW);          // Durante las pruebas.
  digitalWrite(insoladora,LOW); // Desactivamos la salida de insoladora

  // Mostramos informacion por pantalla
  lcd.setCursor(2,0);
  lcd.print("1 - Temporizacion");
  lcd.setCursor(2,1);
  lcd.print("2 - Continuo");
  lcd.setCursor(0,2);
  lcd.print("--------------------");
  lcd.setCursor(0,3);
  lcd.print("   1  |   2   |CONF");
  
  // Controlamos la pulsacion de los botones
  estado = digitalRead(botonUno);                             
  if (estado != ultimoestado && estado==HIGH) seleccion = 1;
  ultimoestado = estado; 
  
  estado = digitalRead(botonDos);   
  if (estado != ultimoestado && estado==HIGH) seleccion = 2;
  ultimoestado = estado; 
  
  estado = digitalRead(botonTres);    
  if (estado != ultimoestado && estado==HIGH) seleccion = 3;
  ultimoestado = estado; 
  
  switch(seleccion)      // Dependiendo del boton pulsado, realizamos una accion u otra. 
  {
     case 1:  seleccion = 0;
              borraLCD;
              menuTemp();         // BOTON 1  --> Menu Temporizacion
              borraLCD;
              break;
     case 2:  seleccion = 0;
              borraLCD;
              menuCont();         // BOTON 1  --> Menu Continuo
              borraLCD;

              break;
      case 3: seleccion = 0;
              borraLCD;
              menuConfig();         // BOTON 1  --> Menu Continuo
              borraLCD;
              break;
  }
}

void menuTemp()
{
  do{
    if (temporizador > 0){
      if (!temporiz){
      pantalla = 1;
      Timer1.stop(); 
      // Inicializamos variables de la pantalla
      seleccion= 0;
      digitalWrite(led,LOW);  // Durante las pruebas.
      digitalWrite(insoladora,LOW); // Desactivamos la salida de insoladora

      // Mostrar informacion por pantalla
      //Serial.println("MENU CONTINUO");
      lcd.setCursor(0,0);
      lcd.print("Estado:");
      lcd.setCursor(9,0);
      lcd.print("PARADO");
      lcd.setCursor(0,1);
      lcd.print("Tiempo:");
      lcd.setCursor(7,1);
      if (temporizador >= 0 && temporizador < 10) lcd.print("           ");  
      if (temporizador >= 10 && temporizador < 100) lcd.print("          ");
      if (temporizador >= 100 && temporizador < 1000) lcd.print("         ");   
      if (temporizador >= 1000) lcd.print("        "); 
      lcd.print(temporizador);
      lcd.setCursor(19,1);
      lcd.print("s");
      lcd.setCursor(0,2);
      lcd.print("--------------------");
      lcd.setCursor(0,3);
      lcd.print("INICIAR|      |ATRAS");
      // Controlamos la pulsacion de los botones
      estado = digitalRead(botonUno);   
      if (estado != ultimoestado && estado==HIGH) seleccion = 1;
        ultimoestado = estado;
        switch(seleccion)      // Dependiendo del boton pulsado, realizamos una accion u otra. 
        {
          case 1:  seleccion = 0;
                   temporiz = true;
                   borraLCD;
                   break;
        }
      }
      else{
        // Mostrar informacion por pantalla
        //Serial.println("Pantalla INSOLANDO");
        lcd.setCursor(0,0);
        lcd.print("Estado:");
        lcd.setCursor(9,0);
        lcd.print("INSOLANDO");
        lcd.setCursor(0,1);
        lcd.print("Tiempo:");
        lcd.setCursor(7,1);
        if (temporizador >= 0 && temporizador < 10) lcd.print("           ");  
        if (temporizador >= 10 && temporizador < 100) lcd.print("          ");
        if (temporizador >= 100 && temporizador < 1000) lcd.print("         ");   
        if (temporizador >= 1000) lcd.print("        "); 
        lcd.print(temporizador);
        lcd.setCursor(19,1);
        lcd.print("s");
        lcd.setCursor(0,2);
        lcd.print("--------------------");
        lcd.setCursor(0,3);
        lcd.print("      | PARAR |ATRAS");
        digitalWrite(led,HIGH);  // Durante las pruebas.
        digitalWrite(insoladora,HIGH); // Activamos la salida de insoladora
        Timer1.resume(); 
        // Controlamos la pulsacion de los botones
        estado = digitalRead(botonDos);
        if (estado != ultimoestado && estado==HIGH) seleccion = 2;
        ultimoestado = estado;
        switch(seleccion)      // Dependiendo del boton pulsado, realizamos una accion u otra. 
          {
          case 2:  seleccion = 0;
                   borraLCD;
                   temporiz = false;
                   
                   break;
          }
      }
    }
      else {
       Timer1.stop();
       lcd.setCursor(7,0);
       lcd.print(" FINALIZADO");
       lcd.setCursor(0,1);
       lcd.print("                    ");
       lcd.setCursor(0,3);
       lcd.print("      |       |ATRAS");
       digitalWrite(led,LOW);  // Durante las pruebas.
       digitalWrite(insoladora,LOW); // Desactivamos la salida de insoladora
       sonido.play(1000,500);
       delay(1000);

       }    
  }while((digitalRead(botonTres) != HIGH));
}
void menuCont()
{
  do{
    if (!continuo){
    Timer1.stop(); 
    // Inicializamos variables de la pantalla
    seleccion= 0;
    pantalla = 2;
    digitalWrite(led,LOW);  // Durante las pruebas.
    digitalWrite(insoladora,LOW); // Desactivamos la salida de insoladora

    // Mostrar informacion por pantalla
    //Serial.println("MENU CONTINUO");
    lcd.setCursor(0,0);
    lcd.print("Estado:");
    lcd.setCursor(9,0);
    lcd.print("PARADO");
    lcd.setCursor(0,1);
    lcd.print("Tiempo:");
    lcd.setCursor(7,1);
    if (temporizador_cont >= 0 && temporizador_cont < 10) lcd.print("           ");  
    if (temporizador_cont >= 10 && temporizador_cont < 100) lcd.print("          ");
    if (temporizador_cont >= 100 && temporizador_cont < 1000) lcd.print("         ");   
    if (temporizador_cont >= 1000) lcd.print("        "); 
    lcd.print(temporizador_cont);
    lcd.setCursor(19,1);
    lcd.print("s");
    lcd.setCursor(0,2);
    lcd.print("--------------------");
    lcd.setCursor(0,3);
    lcd.print("INICIAR|      |ATRAS");
    // Controlamos la pulsacion de los botones
    estado = digitalRead(botonUno);   
    if (estado != ultimoestado && estado==HIGH) seleccion = 1;
    ultimoestado = estado;
    switch(seleccion)      // Dependiendo del boton pulsado, realizamos una accion u otra. 
    {
      case 1:  seleccion = 0;
               continuo = true;
               borraLCD;
               break;
      }
    }
    else{
      // Mostrar informacion por pantalla
      //Serial.println("Pantalla INSOLANDO");
      lcd.setCursor(0,0);
      lcd.print("Estado:");
      lcd.setCursor(9,0);
      lcd.print("INSOLANDO");
      lcd.setCursor(0,1);
      lcd.print("Tiempo:");
      lcd.setCursor(7,1);
      if (temporizador_cont >= 0 && temporizador_cont < 10) lcd.print("           ");  
      if (temporizador_cont >= 10 && temporizador_cont < 100) lcd.print("          ");
      if (temporizador_cont >= 100 && temporizador_cont < 1000) lcd.print("         ");   
      if (temporizador_cont >= 1000) lcd.print("        "); 
      lcd.print(temporizador_cont);
      lcd.setCursor(19,1);
      lcd.print("s");
      lcd.setCursor(0,2);
      lcd.print("--------------------");
      lcd.setCursor(0,3);
      lcd.print("      | PARAR |ATRAS");
      digitalWrite(led,HIGH);  // Durante las pruebas.
      digitalWrite(insoladora,HIGH); //Activamos la salida de insoladora
      Timer1.resume(); 
      
      // Controlamos la pulsacion de los botones
      estado = digitalRead(botonDos);
      if (estado != ultimoestado && estado==HIGH) seleccion = 2;
      ultimoestado = estado;
      switch(seleccion)      // Dependiendo del boton pulsado, realizamos una accion u otra. 
        {
        case 2:  seleccion = 0;
                 continuo = false;
                 borraLCD;
                 break;
        }
    }
  }while((digitalRead(botonTres) != HIGH));
}
void menuConfig()
{
  // Inicializamos variables de la pantalla
  seleccion= 0;
  pantalla = 3;
  temp = temporizador;  //Cargamos el valor actual de temporizacion
  do{

    // Mostrar informacion por pantalla
    //Serial.println("MENU CONTINUO");
    lcd.setCursor(0,0);
    lcd.print("Temp. insolado:");
    lcd.setCursor(0,1);
    lcd.print("Tiempo:");
    lcd.setCursor(7,1);
    if (temp >= 0 && temp < 10) lcd.print("           ");  
    if (temp >= 10 && temp < 100) lcd.print("          ");
    if (temp >= 100 && temp < 1000) lcd.print("         ");   
    if (temp >= 1000) lcd.print("        "); 
    lcd.print(temp);
    lcd.setCursor(19,1);
    lcd.print("s");
    lcd.setCursor(0,2);
    lcd.print("--------------------");
    lcd.setCursor(0,3);
    lcd.print("  MAS  |MENOS|ATRAS");
    // Controlamos la pulsacion de los botones
    estado = digitalRead(botonUno);   
    if (estado != ultimoestado && estado==HIGH) seleccion = 1;
    ultimoestado = estado;
    estado = digitalRead(botonDos);   
    if (estado != ultimoestado && estado==HIGH) seleccion = 2;
    ultimoestado = estado;
    estado = digitalRead(botonTres);   
    if (estado != ultimoestado && estado==HIGH) seleccion = 3;
    ultimoestado = estado;
    switch(seleccion)      // Dependiendo del boton pulsado, realizamos una accion u otra. 
    {
      case 1:  seleccion = 0;
               temp++;
               Serial.println("MAS");
               break;
      case 2:  seleccion = 0;
               Serial.println("MENOS");
               if (temp > 0) temp--;
               break;
      case 3:  seleccion = 0;
               temporizador = temp;
               break;
      }
    
  }while((digitalRead(botonTres) != HIGH));
}


//####FIN MENUS DEL LCD####
void temporizacion(){
  if (pantalla == 1){
    temporizador--;
    if (temporizador <= 0){
      Timer1.stop();
      //borraLCD;
    }
  }
  if (pantalla == 2){
    temporizador_cont++;
  }
}




