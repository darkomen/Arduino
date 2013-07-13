import serial
ser = serial.Serial('/dev/tty.usbserial-A600IP3Q', 9600)
cadena = ''
print('Introduzca una letra, escriba exit para salir')
while (cadena != "exit"):
	cadena = raw_input()
	ser.write(cadena)