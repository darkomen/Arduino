/*
This example firstly waits for Serial input and then sets date and time on DS1307
Real-Time Clock based on what user sent.
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

char dateTime[22];
int RTCValues[7], i = 0, year, month, dayOfMonth, dayOfWeek, hour, minute,
    second;

void setup() {
    Serial.begin(9600);
    Serial.println("Please enter date and time in the format \"YYYY-MM-DD HH:MM:SS D\",");
    Serial.println("Where D is the number of the day of week (0 = Sunday, 6 = Saturday).");
    Serial.println("Example: 2011-04-23 02:25:27 6");
    DS1307.begin();

    while (i < 21) {
        if (Serial.available()) {
            char c = Serial.read();
            dateTime[i] = c;
            i++;
        }
    }
    dateTime[i] = '\0';

    year = 10 * (dateTime[2] - 48) + (dateTime[3] - 48);
    month = 10 * (dateTime[5] - 48) + (dateTime[6] - 48);
    dayOfMonth = 10 * (dateTime[8] - 48) + (dateTime[9] - 48);
    dayOfWeek = (dateTime[20] - 48);
    hour = 10 * (dateTime[11] - 48) + (dateTime[12] - 48);
    minute = 10 * (dateTime[14] - 48) + (dateTime[15] - 48);
    second = 10 * (dateTime[17] - 48) + (dateTime[18] - 48);

    DS1307.setDate(year, month, dayOfMonth, dayOfWeek, hour, minute, second);
    Serial.println("Date and time set!");
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
