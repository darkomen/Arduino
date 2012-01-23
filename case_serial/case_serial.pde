/*
 * Serial Read Blink
 * -----------------
 * Turns on and off a light emitting diode(LED) connected to digital  
 * pin 13. The LED will blink the number of times given by a 
 * single-digit ASCII number read from the serial port.
 *
 * Created 18 October 2006
 * copyleft 2006 Tod E. Kurt <tod@todbot.com>
 * http://todbot.com/
 * 
 * based on "serial_read_advanced" example
 */

void setup() {
  Serial.begin(9600);        // connect to the serial port
}

void loop () {
  for (i = 0; i < 100; i++){
    Serial.println(i);
  }

}
