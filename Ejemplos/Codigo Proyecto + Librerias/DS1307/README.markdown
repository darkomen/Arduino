DS1307 Arduino Library
======================

If do you need to know date and time in your Arduino project, so you need a Real-Time Clock (or RTC)!

One of the most famous RTC ICs is DS1307, from Dallas Semiconductor. DS1307 uses [I²C (or Two-Wire Interface - TWI)](http://en.wikipedia.org/wiki/I%C2%B2C) to communicate with Arduino. This library is just a layer above [Wire library](http://www.arduino.cc/en/Reference/Wire) to make RTC easy to use.


Installation
============

[Download the tarball](https://github.com/turicas/DS1307/tarball/master), uncompress it and put the directory `DS1307` inside your personal library folder (`~/sketchbook/libraries/` -- on GNU/Linux) or in the Arduino-system library folder (`/usr/share/arduino/libraries` on GNU/Linux -- requires root access).


Examples
========

For now that are only 3 examples: `SetDateHardcoded`, `SedDateSerial` and `ReadDate` -- the names autoexplain. :-) Install the library and go to `File` -> `Examples` -> `DS1307` -> (choose one example).


Hardware
========

There is a [RTC module with DS1307 sold by SparkFun](http://www.sparkfun.com/products/99) - this library was tested only with this module.

<div style="height: 350px; line-height: 350px; text-align: center">
    <img src="https://github.com/turicas/DS1307/raw/master/photos/DS1307-front-back.jpg" style="vertical-alignt: middle; max-height: 100%" />
    <br />
    <img src="https://github.com/turicas/DS1307/raw/master/photos/DS1307-Arduino.jpg" style="vertical-alignt: middle; max-height: 100%" />
</div>
<br />
<div style="text-align: center">
    DS1307 RTC module (front and back) from SparkFun and Arduino connected to DS1307 RTC module using jumper wires and a breadboard.
</div>



Thanks To
=========

The code of this library is based on [Wiring.org.co RTC example](http://wiring.org.co/learning/libraries/realtimeclock.html) and [Daniel Gonçalves post at LusoRobótica Forum](http://lusorobotica.com/index.php/topic,681.0.html) - thanks, guys!
