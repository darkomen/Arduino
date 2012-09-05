/*
  DS1307.cpp - DS1307 Real-Time Clock library
  Copyright (c) 2011 Álvaro Justen aka Turicas.  All right reserved.

  This library is free software; you can redistribute it and/or
  modify it under the terms of the GNU Lesser General Public
  License as published by the Free Software Foundation; either
  version 2.1 of the License, or (at your option) any later version.

  This library is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General Public
  License along with this library; if not, write to the Free Software
  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
*/

extern "C" {
    #include <inttypes.h>
    #include <stdlib.h>
    #include <string.h>
    #include <stdio.h>
}

#include "DS1307.h"
#include "Wire.h"


char *diaSemana(int dayOfWeek) {
    switch (dayOfWeek) {
        case 0:
            return "Domingo";
            break;
        case 1:
            return "Lunes";
            break;
        case 2:
            return "Martes";
            break;
        case 3:
            return "Mierc.";
            break;
        case 4:
            return "Jueves";
            break;
        case 5:
            return "Viernes";
            break;
        case 6:
            return "Sabado";
            break;
    }
}

uint8_t fromDecimalToBCD(uint8_t decimalValue) {
    return ((decimalValue / 10) * 16) + (decimalValue % 10);
}

uint8_t fromBCDToDecimal(uint8_t BCDValue) {
    return ((BCDValue / 16) * 10) + (BCDValue % 16);
}

void DS1307Class::begin() {
    Wire.begin();
}

void DS1307Class::setDate(uint8_t year, uint8_t month, uint8_t dayOfMonth,
                          uint8_t dayOfWeek, uint8_t hour, uint8_t minute,
                          uint8_t second) {
    Wire.beginTransmission(DS1307_ADDRESS);
    Wire.send(0); //stop oscillator

    //Start sending the new values
    Wire.send(fromDecimalToBCD(second));
    Wire.send(fromDecimalToBCD(minute));
    Wire.send(fromDecimalToBCD(hour));
    Wire.send(fromDecimalToBCD(dayOfWeek));
    Wire.send(fromDecimalToBCD(dayOfMonth));
    Wire.send(fromDecimalToBCD(month));
    Wire.send(fromDecimalToBCD(year));

    Wire.send(0); //start oscillator
    Wire.endTransmission();
}

void DS1307Class::getDate(int *values) {
    Wire.beginTransmission(DS1307_ADDRESS);
    Wire.send(0); //stop oscillator
    Wire.endTransmission();
    Wire.requestFrom(DS1307_ADDRESS, 7);

    for (int i = 6; i >= 0; i--) {
        values[i] = fromBCDToDecimal(Wire.receive());
    }
    //TODO: 24-hour time?
}

DS1307Class DS1307;
