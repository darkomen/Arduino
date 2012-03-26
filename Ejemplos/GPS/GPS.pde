 
 /*
 Tutorial # 0009 Arduino Academy
 GPS + Display I2C

 En este proyecto aprendemos a conectar un modulo GPS y
 a tratar la informacion recibida para mostrar
 en un display I2C la latitud, longitud, hora y altitud.

 Este proyecto es de dominio público.
 */
  
  //Incluimos librerias
  #include <SoftwareSerial.h>        //Para crear un puerto Serie que trabaje con el GPS
  #include <LiquidCrystal_I2C.h>     //Para usar un display I2C
  #include <Wire.h>                  //La necesita la libreria LiquidCrystal_I2C.h
  
  //Declaramos las constantes
  #define txPin 6      //Pin Tx para conexion con el GPS
  #define rxPin 7      //Pin Rx para conexion con el GPS
  
 
  // Creamos un puerto serie para el GPS
  SoftwareSerial gps = SoftwareSerial(rxPin, txPin);   //Llamada a la libreria SoftwareSerial para configurar los pines RX TX
  
  //Creamos un objeto para el Display llamado lcd
  LiquidCrystal_I2C lcd(0x27,16,2);                    //Establece la dirección de memoria 0x27 (es la que mandan) para un display de 16 caracteres y 2 líneas

  
  //Variables del programa
  byte byteGPS = 0;              // Donde guardaremos cada byte que leamos del gps para mandarlos al array
  int i = 0;                     // Variable que utilizaremos como acumulador
  int Estado = 0;                // Guarda el estado de la conexion
  int menu = 1;                  // Para saber en que menu estamos
  int inPin = 5;                 // PIN del pulsador
  int value = 0;                 // Estado del pulsador de menu
  char TramaGPG[100];            // Array donde iremos almacenando los bytes leidos del GPS
  char *pch;                     // Creamos un puntero de tipo char
  char *GGA[15];                 // y un array de punteros de tipo char
  int sat = 0;                   // Variable para almacenar el numero de satelites
  
  
  //Setup del programa
  void setup()
    {
      Serial.begin(9600);        // Configuracion del puerto serie de arduino
      lcd.init();                // Inicializamos el LCD 
      lcd.backlight();           // Encendemos la iluminacion trasera del LCD
      pinMode(12, OUTPUT);       // Configuramos el pin 12 para el LED de la placa
      digitalWrite(12, LOW);     // Apagamos el led hasta tener señal del satelite
      pinMode(inPin, INPUT);     // Inicializa el pin 5 como entrada digital
      inicio();                  // Llama a intro de LCD
      Serial.flush();            // Borramos el buffer del serial para evitar errores
      pinMode(rxPin, INPUT);     // Configuramos los pines del GPS para poder leer..
      pinMode(txPin, OUTPUT);    // y para poder escribir en el...
      gps.begin(4800);           // finalmente establecemos la velocidad de comunicacion con el GPS
    }
  
  //Loop del programa
  void loop()
    {
        value = digitalRead(inPin);    // leemos el estado del pulsador que tenemos en el circuito
        
        if(value==1)                   //COMPROBACION PARA PULSADOR DE MENU
            {                          // Si esta a 1 significa que esta pulsado, por lo que 
              menu++;                  // sumamos 1 a la variable menu
              lcd.clear();             // Limpiamos el LCD para que al escribir no queden restos de la informacion anterior
              if (menu==3)
                {                      // Si el menu toma valor 3 significa que esta a final de los menus (solo hay dos) 
                  menu=1;              // por lo que lo reiniciamos a 1
                }
            }
      
      //Preparamos todo para la lectura del puerto serie creado para el GPS  
      memset(TramaGPG, 0, sizeof(TramaGPG));         // Inicializa a cero la cadena para eliminar restos no deseados de lecturas anteriores
      byteGPS = 0;                                   // Limpiamos el posible contenido 
      byteGPS = gps.read();                          // Leemos el byte que tenemos en la entrada del puerto serie creado para el GPS
  
      //Buscamos la cadena deseada para empezar a guardarla en el array
      while(byteGPS != '$')
        {                                            // Mientras el byte que tengamos leido no sea igual a $
          byteGPS = gps.read();                      // leeremos el siguiente caracter
        } 
      
      //Ya tenemos localizada la cadena, asi que la guardamos en un array
      i=1;                                           // inicializamos a uno el contador
      TramaGPG[0] = '$';                             // y colocamos el $ en la primera posicion de nuestra cadena de caracteres
      
      //Esto nos detecta hasta que dato queremos almacenar en el array, es decir, hasta * que nos indica el final de la cadena y nos llena el array.
      while(byteGPS != '*' )
        {                                            // Mientras el caracter leido no sea igual a * 
          byteGPS = gps.read();                      // leeremos el siguiente caracter
          TramaGPG[i]=byteGPS;                       // y lo almacenaremos en la cadena de caracteres en la posicion que corresponda
          i++;                                       // e incrementamos en uno el contador
        }
        
      TramaGPG[i]='\0';                              // para evitar porblemas añadiremos nosotros manualmente el caracter de fin de linea 
      cadena();                                      // Llamamos a la funcion que manipula nuestra cadena
    }
    
    
    
    
