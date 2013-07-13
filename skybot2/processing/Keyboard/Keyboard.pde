/**
 * Keyboard. 
 * 
 * Click on the image to give it focus and press the letter keys 
 * to create forms in time and space. Each key has a unique identifying 
 * number called its ASCII value. These numbers can be used to position 
 * shapes in space. 
 */

import controlP5.*;
import processing.serial.*;

Serial arduino; //Creamos un objeto tipo serial y lo llamamos arduino
ControlP5 controlP5;

int rectWidth;
   
void setup() {
    String portName = Serial.list()[0];
  arduino = new Serial(this, portName, 9600);
  size(200, 200);
  noStroke();
  background(0);
  rectWidth = width/4;
}

void draw() { 
  // keep draw() here to continue looping while waiting for keys
}

void keyPressed() {
   arduino.write(key);
   println(key);
}
