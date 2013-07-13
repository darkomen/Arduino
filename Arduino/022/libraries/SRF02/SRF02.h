/*
 * This file is part of the grappendorf.net Arduino Libraries.
 *
 * The contents of this file are subject to the Apache License Version
 * 2.0 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is grappendorf.net Arduino Libraries / SRF02.
 *
 * The Initial Developer of the Original Code is
 * Dirk Grappendorf (www.grappendorf.net)
 * Portions created by the Initial Developer are Copyright (C) 2008-2011
 * the Initial Developer. All Rights Reserved.
 */

#ifndef SRF02_H
#define SRF02_H

#include <inttypes.h>

/** Measurement modes */
const uint8_t SRF02_INCHES = 0x50;
const uint8_t SRF02_CENTIMETERS = 0x51;
const uint8_t SRF02_MICROSECONDS = 0x52;

/**
 * The class SRF02 is a combined interface to a collection of SRF02 sensors.
 * You specify the total number of sensors and the I2C device id of the first
 * sensor as template parameters. All following device ids must be consecutive.
 *
 * The update() method periodically starts measurements on all sensors and
 * retrieves the distance values into an array. The last measured distance
 * values can always be queried by calling the value() method.
 *
 * Sample usage:
 *
 * SRF02 sensor1(0x70, SRF02_CENTIMETERS);
 * SRF02 sensor2(0x71, SRF02_CENTIMETERS);
 *
 * void loop()
 * {
 *   SRF02.update();
 *   Serial.println(sensor1.read());
 *   Serial.println(sensor2.read());
 * }
 */
class SRF02
{
	public:

	/**
	 * Initialize SRF02. All sensors are added to a static list. A call to the static
	 * update() method reads the values of all created sensors.
	 *
	 * @param deviceId The I2C device id
	 * @param mode Wether sensor values are read as inches, centimeters or miliseconds
	 */
	SRF02(uint8_t deviceId, uint8_t mode = SRF02_CENTIMETERS);

	/**
	 * Get the sensor distance value.
	 *
	 * @return The distance value
	 */
	unsigned int read()
	{
		return value;
	}

	/**
	 * Call this method from your loop() function. It periodically requests
	 * all sensors to perform a measurement and reads all sensor values when
	 * the measurent completes. If there's nothing to do, it returns
	 * immediately.
	 */
	static void update();

	/**
	 * Set the meadurement interval. Every interval miliseconds, the sensors are
	 * queried for their current values.
	 *
	 * @param interval The read measurement interval
	 */
	static void setInterval(unsigned int interval)
	{
		SRF02::interval = interval;
	}

	/**
	 * New devices are always configured to use the device id 0x70 (0xe0).
	 * Call this method to change the device id. Only connect a single SRF02
	 * sensor to the I2C bus before calling this method.
	 *
	 * @deviceId The current device id
	 * @newDeviceId The new device it to set
	 */
	static void configureDeviceId(uint8_t deviceId, uint8_t newDeviceId);

	protected:

	/**
	 * Add a sensor to the list of all sensors.
	 */
	void add();

	/** I2C device id */
	uint8_t deviceId;

	/** Measurement mode */
	uint8_t mode;

	/** The distance values */
	unsigned int value;

	/** Measurement interval (milli seconds). Must be greater 65. If this is 0, measurements are disabled */
	static unsigned int interval;

	/** When to read the distance sensor values (milli seconds) */
	static unsigned long nextRead;

	/** Next time to request distance sensor values (milli seconds) */
	static unsigned long nextRequest;

	/** Pointer to the first sensor */
	static SRF02 *first;

	/** Pointer to the next sensor */
	SRF02 *next;

	/** If true, a range measurement was initiated. */
	static bool rangingTriggered;
};

#endif /* SRF02_H */
