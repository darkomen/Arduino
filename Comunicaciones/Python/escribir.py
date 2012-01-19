import serial
ser = serial.Serial('/dev/tty.usbserial-A600IP3Q', 9600)
cadena = raw_input()
ser.write(cadena)