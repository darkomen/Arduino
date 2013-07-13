// RoboSapienServer.cpp
// RobosapienServer - Web enable a RoboSapien
// Kevin N. Haw
// http://www.KevinHaw.com/RoboSapienServer.php

// This project combines the default webserver example in the IDE distribution and Karl Castleton's(http://home.mesastate.edu/~kcastlet) RoboSapienIR (http://www.arduino.cc/playground/Main/RoboSapienIR).
// Source code merged from those two sources.

// Include files
#include <Ethernet.h>
#include <string.h>

//////////////////////////////////////////////////////////////////
// Begin Web Server specific variable deinitions
//////////////////////////////////////////////////////////////////

byte mac[] = { 0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED };

// KNH, 02/09/2010 - Change IP address to use local subnet at home
//byte ip[] = { 10, 0, 0, 177 };
byte ip[] = { 192, 168, 1, 177 };

// Server for web requests
Server server(80);

// Define field name in the submitted form
#define SUBMIT_BUTTON_FIELDNAME "RSCmd"

// String for HTTP request variables
char pcHttpReqRsCmd[20] = {'\0'};


volatile int viRobsapienUrlCmd = -1;  // A robosapien command sent over the URL of a webpage HTTP request


//////////////////////////////////////////////////////////////////
// Begin Robosapien specific variable deinitions
//////////////////////////////////////////////////////////////////


// Some but not all RS commands are defined
#define RSTurnRight       0x80
#define RSRightArmUp      0x81
#define RSRightArmOut     0x82
#define RSTiltBodyRight   0x83
#define RSRightArmDown    0x84
#define RSRightArmIn      0x85
#define RSWalkForward     0x86
#define RSWalkBackward    0x87
#define RSTurnLeft        0x88
#define RSLeftArmUp       0x89
#define RSLeftArmOut      0x8A
#define RSTiltBodyLeft    0x8B
#define RSLeftArmDown     0x8C
#define RSLeftArmIn       0x8D
#define RSStop            0x8E
#define RSWakeUp          0xB1
#define RSBurp            0xC2
#define RSRightHandStrike 0xC0
#define RSNoOp            0xEF

// Subset of additional codes pulled from http://www.contrib.andrew.cmu.edu/~ebuehl/robosapien-lirc/ir_codes.htm
#define RSRightHandSweep  0xC1
#define RSRightHandStrike2 0xC3
#define RSHigh5           0xC4
#define RSFart            0xC7
#define RSLeftHandStrike  0xC8
#define RSLeftHandSweep  0xC9

#define RSWhistle         0xCA
#define RSRoar            0xCE


int IRIn = 2;            // We will use an interrupt
int IROut= 3;            // Where the echoed command will be sent from


boolean RSEcho=true;      // Should Arduino Echo RS commands
boolean RSUsed=true;      // Has the last command been used
volatile int RSBit=9;     // Total bits of data
volatile int RSCommand;   // Single byte command from IR
int bitTime=516;          // Bit time (Theoretically 833 but 516)
                          // works for transmission and is faster
int last;                 // Previous command from IR





//////////////////////////////////////////////////////////////////
// Begin Robosapien specific code
//////////////////////////////////////////////////////////////////



// Receive a bit at a time.
//  NOTE: Unused in the RoboServer aplication
void RSReadCommand() {
  delayMicroseconds(833+208);  // about 1 1/4 bit times
  int bit=digitalRead(IRIn); 
  if (RSBit==9) { // Must be start of new command
    RSCommand=0;
    RSBit=0;
    RSUsed=true;
  }
  if (RSBit<8) { 
    RSCommand<<=1;
    RSCommand|=bit;
  }
  RSBit++;
  if (RSBit==9) RSUsed=false;
}

// send the whole 8 bits
void RSSendCommand(int command) {
  digitalWrite(IROut,LOW);
  delayMicroseconds(8*bitTime);
  for (int i=0;i<8;i++) {
    digitalWrite(IROut,HIGH);  
    delayMicroseconds(bitTime);
    if ((command & 128) !=0) delayMicroseconds(3*bitTime);
    digitalWrite(IROut,LOW);
    delayMicroseconds(bitTime);
    command <<= 1;
  }
  digitalWrite(IROut,HIGH);
  delay(250); // Give a 1/4 sec before next
}


// Set up RoboSpapien functionality
void RSSetup()                    
{
  pinMode(IRIn, INPUT);     
  pinMode(IROut, OUTPUT);
  pinMode(10,OUTPUT);
  digitalWrite(IROut,HIGH);

  attachInterrupt(0,RSReadCommand,RISING);

  last=RSNoOp;

  // Make robot burp to indicate setup is complete
  RSSendCommand(RSBurp);

}


// Loop for RoboSapien functionality
// Write only functionality - send the command from the web page to the robot, ignoring any input from the remote
void RSLoop() 
{ 
  // Has a new command come in from the server?
  if(viRobsapienUrlCmd != -1)
    {
    // New command - send it to robot
    Serial.print("Sending command to RoboSapien: ");
    Serial.println(viRobsapienUrlCmd, HEX);
    RSSendCommand(viRobsapienUrlCmd);

    // Now clear command
    viRobsapienUrlCmd = -1;
    }
}

//////////////////////////////////////////////////////////////////
// Begin Webserver Specific Code
//////////////////////////////////////////////////////////////////

// Print ourt MIME and HTML header at top of webpage
void HtmlHeader(Client client)
  {
  client.println("HTTP/1.1 200 OK");
  client.println("Content-Type: text/html");
  client.println();
  client.println("<HTML>\n<HEAD>");
  client.println("  <TITLE>Kevin's Arduino Webserver</TITLE>");//
//  client.println("  <META HTTP-EQUIV=\"refresh\" CONTENT=\"5\">");
  client.println("</HEAD><BODY bgcolor=\"#9bbad6\">");
  }

// Print the footer at the bottom of the webpage
void HtmlFooter(Client client)
  {
  client.println("</BODY></HTML>");
  }

// Print a submit button with the indicated label wrapped in a form for the indicated hex command
void SubmitButton(Client &client, char *pcLabel, int iCmd)
  {
  client.print("<form method=post action=\"/?");
  client.print(iCmd, HEX);
  client.print("\"><input type=submit value=\"");
  client.print(pcLabel);
  client.print("\" name=\"" SUBMIT_BUTTON_FIELDNAME "\">");
  client.println("</form>");  
  }

// Parse an HTTP request header one character at a time, seeking string variables
void ParseHttpHeader(Client &client)
  {
  char c;

  // Skip through until we hit a question mark (first one)
  while((c = client.read()) != '?' && client.available())
    {
    // Debug - print data
    Serial.print(c);
    }

  // Are we here for a question mark or did we run out of data?
  if(client.available() > 2)
    {
    char pcUrlNum[3], *pc;

    // We have enough data for a hex number - read it
    for(int i=0; i < 2; i++)
      {
      // Read and dump data to debug port
      Serial.print(c = pcUrlNum[i] = client.read());
      }
    // Null terminate string
    pcUrlNum[2] = '\0';

    // Get hex number
    viRobsapienUrlCmd = strtol(pcUrlNum, &pc, 0x10);   
    }

  // Skip through and discard all remaining data
  while(client.available())
    {
    // Debug - print data
    Serial.print(c = client.read());
    }
  }

// Set up webserver functionality
void WebServerSetup()
{
  Ethernet.begin(mac, ip);
  server.begin();
}

// Web server loop  
void WebServerLoop()
{  
  Client client = server.available();
  boolean bPendingHttpResponse = false; // True when we've received a whole HTTP request and need to output the webpage
  char c;  // For reading in HTTP request one character at a time

  if (client) {
    // Loop as long as there's a connection
    while (client.connected()) {
      // Do we have pending data (an HTTP request)?     
      if (client.available()) {

        // Indicate we need to respond to the HTTP request as soon as we're done processing it
        bPendingHttpResponse = true;

        ParseHttpHeader(client);        
        }
      else
        {
        // There's no data waiting to be read in on the client socket.  Do we have a pending HTTP request?
        if(bPendingHttpResponse)
          {
          // Yes, we have a pending request.  Clear the flag and then send the webpage to the client
          bPendingHttpResponse = false;

          // send a standard http response header and HTML header
          HtmlHeader(client);

          // Put out a text header
          client.println("<H1>Kevin's RoboSapien Webserver</H1>");          

          client.println("<table border cellspacing=0 cellpadding=5><tr>");
          client.println("<td>");

          // Create buttons
          SubmitButton(client, "WakeUp", RSWakeUp);          
          SubmitButton(client, "Roar", RSRoar);          
          SubmitButton(client, "Whistle", RSWhistle);          
          SubmitButton(client, "High5", RSHigh5);    
          client.println("<br>");          

          client.println("</td><td>");

          SubmitButton(client, "LeftArmUp", RSLeftArmUp);
          SubmitButton(client, "LeftArmIn", RSLeftArmIn);
          SubmitButton(client, "LeftArmOut", RSLeftArmOut);
          SubmitButton(client, "LeftArmDown", RSLeftArmDown);
          SubmitButton(client, "LeftArmSweep", RSLeftHandSweep);
          client.println("<br>");          

          client.println("</td><td>");

          SubmitButton(client, "RightArmUp", RSRightArmUp);
          SubmitButton(client, "RightArmIn", RSRightArmIn);
          SubmitButton(client, "RightArmOut", RSRightArmOut);
          SubmitButton(client, "RightArmDown", RSRightArmDown);
          SubmitButton(client, "RightArmSweep", RSRightHandSweep);
          client.println("<br>");          

          client.println("</td></tr></table>");

          client.print("<br><br><br>URL Hex no: ");
          client.print(viRobsapienUrlCmd, HEX);
          client.println("<br />");

          // send HTML footer
          HtmlFooter(client);

          // give the web browser time to receive the data
          delay(1);
          client.stop();
          }
        }
      }  // End while(connected)
  }
}

//////////////////////////////////////////////////////////////////
// Begin arduino entry points
//////////////////////////////////////////////////////////////////

void setup()
{
  // open the serial port at 9600 bps:
  Serial.begin(9600);

  // Print greeting
  Serial.println("Kevin's RobSapien Server");

  RSSetup();
  WebServerSetup();
}

void loop()
{ 
  RSLoop();
  WebServerLoop();
}