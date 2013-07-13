import serial
ser = serial.Serial('/dev/tty.usbserial-A8008qpV', 9600)
dato = ser.readline()
if dato == 'on\r\n' :
	print("encendido")
if dato == 'off\r\n' :
	print("apagado")
