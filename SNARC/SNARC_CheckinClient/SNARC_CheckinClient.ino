/*
 SNARC Checkin Client by Mark Bilandzic, 11 April 2012
 
 This sketch is written for the SNARC, designed by Lawrence "Lemming" Dixon http://www.hsbne.org/projects/SNARC.
 It reads an RFID card through an RFID reader that is attached to the SNARC, and calls a URL with the RFID as a parameter.
 
 Code based on:
 
 - Arduino Ethernet Client sketch by bildr.org: http://bildr.org/2011/06/arduino-ethernet-client/
 - "SeedRFIDLIb" library by Johann Richard https://github.com/johannrichard/SeeedRFIDLib
 
 */


//ARDUINO 1.0+ ONLY
//ARDUINO 1.0+ ONLY
#include <Ethernet.h>
#include <SPI.h>
#include <SeeedRFIDLib.h>
#include <SoftwareSerial.h>


////////////////////////////////////////////////////////////////////////
//CONFIGURE RFID READER
////////////////////////////////////////////////////////////////////////
    // Connect the Reader's TX to the RX Pin on the Arduino. Use 
    #define RFID_RX_PIN 99
    #define RFID_TX_PIN 7 //set 0 if Softserial RX should match D0 on the Arduino (handy e.g. for SNARC as wiring is then possible with one connector)
    
    // Configure the Library in UART Mode
    //SeeedRFIDLib RFID(RFID_RX_PIN, RFID_TX_PIN);
    
    // Configure the Library in WIEGAND Mode
    SeeedRFIDLib RFID(WIEGAND_26BIT); 
    RFIDTag tag;

////////////////////////////////////////////////////////////////////////
//CONFIGURE ETHERNET
////////////////////////////////////////////////////////////////////////
    byte server[] = { 192, 168, 0, 14 }; //ip Address of the server you will connect to
    
    //The location to go to on the server
    //make sure to keep HTTP/1.0 at the end, this is telling it what type of file it is
    String location = "/TheEdge_VisitorProfiles/API/view_list_distinctusercheckins_all_2.php HTTP/1.0";
    
    // if need to change the MAC address (Very Rare)
    byte mac[] = { 0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED };


EthernetClient client;

char inString[32]; // string for incoming serial data
int stringPos = 0; // string index counter
boolean startRead = false; // is reading?

void setup(){
  Ethernet.begin(mac);
  Serial.begin(9600);
  Serial.println("Serial Ready");
}

void loop(){
  
  
  
/////UART MODE
//  if(RFID.isIdAvailable()) {
//    tag = RFID.readId();
//    Serial.print("ID:       ");
//    Serial.println(tag.id);
//    Serial.print("ID (HEX): ");
//    Serial.println(tag.raw);
//    delay(1000);
//
//    String pageValue = connectAndRead(); //connect to the server and read the output
//    Serial.println(pageValue); //print out the findings.
//
//  }

//////WIEGAND MODE
    if(RFID.isIdAvailable()) {
        tag = RFID.readId();
        // In Wiegand Mode, we only get the card code
        Serial.print("CC = ");
        Serial.println(tag.id); 
        
      String pageValue = connectAndRead(); //connect to the server and read the output
      Serial.println(pageValue); //print out the findings.
        
    }
  

}

String connectAndRead(){
  //connect to the server

  Serial.println("connecting...");

  //port 80 is typical of a www page
  if (client.connect(server, 80)) {
    Serial.println("connected");
    client.print("GET ");
    client.println(location);
    client.println();

    //Connected - Read the page
    return readPage(); //go and read the output

  }else{
    return "connection failed";
  }

}

String readPage(){
  //read the page, and capture & return everything between '<' and '>'

  stringPos = 0;
  memset( &inString, 0, 32 ); //clear inString memory

  while(true){

    if (client.available()) {
      char c = client.read();
      //Serial.print(c);
      
      if (c == '[' ) { //'<' is our begining character
        startRead = true; //Ready to start reading the part 
      }else if(startRead){

        if(c != ','){ //'>' is our ending character
          inString[stringPos] = c;
          stringPos ++;
        }else{
          //got what we need here! We can disconnect now
          startRead = false;
          client.stop();
          client.flush();
          Serial.println("disconnecting.");
          return inString;

        }

      }
    }

  }

}
