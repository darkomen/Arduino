/*
This example firstly sets the date and time on DS1307 Real-Time Clock.
Please modify the clock values that are hardcoded.
Secondly it reads the date and time from DS1307 Real-Time Clock
and send this information to your PC using USB/Serial (like the ReadDate example).
Make the connections below, upload the code and open Serial Monitor.

Made by Álvaro Justen aka Turicas

Pin connections on DS1307 module:

[DS1307] <--> [Arduino]
5V       <--> 5V
GND      <--> GND 
SQW      <--> (not connected)
SCL      <--> Analog Input 5
SDA      <--> Analog Input 4

This software is free software.
*/

#include <Wire.h>
#include <DS1307.h>

char dateTime[20];
int RTCValues[7];

void setup() {
    Serial.begin(9600);
    Serial.print("Setting the value of RTC... ");

    DS1307.begin();
    DS1307.setDate(11, 04, 22, 5, 12, 31, 30);
    //Year: two-digit, from 00 to 99
    //Month: two-digit, from 01 to 12
    //Day of month, from 01 to 31
    //Day of week, from 0 (sunday) to 6 (saturday)
    //Hour: 24-hour format, from 0 to 23
    //Minute: from 0 to 59
    //Second: from 0 to 59
    Serial.println("OK!");
    Serial.println("Reading data from RTC...");
}

void loop() {
    DS1307.getDate(RTCValues);
    sprintf(dateTime, "20%02d-%02d-%02d %02d:%02d:%02d", RTCValues[0],
            RTCValues[1], RTCValues[2], RTCValues[4], RTCValues[5],
            RTCValues[6]);
    Serial.print(dateTime);
    Serial.print(" - day of week: ");
    Serial.println(fromNumberToWeekDay(RTCValues[3]));

    delay(1000);
}
