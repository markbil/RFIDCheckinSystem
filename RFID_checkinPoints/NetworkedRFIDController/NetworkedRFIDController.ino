/*
 NetworkedRFIDController Sketch by Mark Bilandzic, 11 April 2012
 
 This sketch reads an RFID card through an RFID reader and makes a GET request to a URL with the RFID numbers as a parameter.
 The sketch is written for the SNARC (Simple NetworkAble RFID Controller), designed by Lawrence "Lemming" Dixon http://www.hsbne.org/projects/SNARC, however
 the code is fully compatible with an Arduino 1.0+ and attached Ethernet-Shield.
 
 Code is based on:
 - RFID reader code by
     - Martijn The - http://www.martijnthe.nl/ 
     - BARRAGAN - http://people.interaction-ivrea.it/h.barragan 
     - HC Gilje - http://hcgilje.wordpress.com/resources/rfid_id12_tagreader/
     - Martijn The - http://www.martijnthe.nl/
- Arduino Ethernet Client sketch by bildr.org: http://bildr.org/2011/06/arduino-ethernet-client/
- buzz() function by Rob Faludi: http://www.faludi.com/2007/04/23/buzzer-arduino-example-code/

Hardware Wiring:
- Buzzer according to http://www.budurl.com/buzzer
- RFID-Reader according to...
     - http://www.seeedstudio.com/wiki/Electronic_brick_-_125Khz_RFID_Card_Reader
     - set jumper on the RFID reader to UART mode
     - connect TX of RFID reader to a RX of the Arduino. define SoftSerial accordingly
 */


#include <Ethernet.h>
#include <SPI.h>
#include <SoftwareSerial.h>


////////////////////////////////////////////////////////////////////////
//CONFIGURE RFID READER
////////////////////////////////////////////////////////////////////////
    
    // Configure the Library in UART Mode
    SoftwareSerial mySerial(7, 8); // 7-Rx, 8=Tx


////////////////////////////////////////////////////////////////////////
//CONFIGURE ETHERNET
////////////////////////////////////////////////////////////////////////
    byte server[] = { 192, 168, 0, 13 }; //ip Address of the server you will connect to
    byte mac[] = { 0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED };
    
    EthernetClient client;
    char inString[32]; // string for incoming serial data
    int stringPos = 0; // string index counter
    boolean startRead = false; // is reading?


////////////////////////////////////////////////////////////////////////
//CONFIGURE API SETTINGS
////////////////////////////////////////////////////////////////////////
    int im_type = 1; // should be set to 1 on every RFID reader. 1 stands for RFID in the Checkin-DB
    int sublocation = 3; //set location key according to where the RFID reader is installed, e.g. 1 for Window Bays 1.
//    String thirdpartyid = "9999999"; //actual RFID number. set random number for test purposes...




//FEEDBACK LEDs
// SNARC has two on-board LEDs: green LED = DIGITAL PIN 5, red LED = DIGITAL PIN 6
int greenpin = 5;       //flash green LED to confirm successful connection
int redpin = 6;         //flash red LED to indicate that connection failed
int yellowpin = 18;     //no function in this sketch, but can be activated instead of buzzer to confirm that RFID card has been read
int speakerPin = 19;

boolean writingToDB = false;

void setup(){
  
  pinMode(yellowpin, OUTPUT); //define led pin as output
  pinMode(greenpin, OUTPUT); //define led pin as output
  pinMode(redpin, OUTPUT); //define led pin as output
  pinMode(speakerPin, OUTPUT);
  
  Serial.begin(9600);
  mySerial.begin(9600);
  
  Serial.println("Serial...");  
  Serial.println("Ethernet...");
  Ethernet.begin(mac);
  Serial.println("Setup finished.");
  
}

void loop(){
  
/////UART MODE
  byte i = 0;
  byte val = 0;
  byte code[6];
  byte checksum = 0;
  byte bytesread = 0;
  byte tempbyte = 0;
  String rfid = "";
  if(!writingToDB){
    if(mySerial.available() > 0) {
      writingToDB = true;
      if((val = mySerial.read()) == 2) {        // check for header 
      
        bytesread = 0; 
        while (bytesread < 12) {                        // read 10 digit code + 2 digit checksum
          if( mySerial.available() > 0) { 
            val = mySerial.read();
            if((val == 0x0D)||(val == 0x0A)||(val == 0x03)||(val == 0x02)) { // if header or stop bytes before the 10 digit reading 
              break;                                    // stop reading
            }
            
            // Do Ascii/Hex conversion:
            if ((val >= '0') && (val <= '9')) {
              val = val - '0';
            } else if ((val >= 'A') && (val <= 'F')) {
              val = 10 + val - 'A';
            }
  
            // Every two hex-digits, add byte to code:
            if (bytesread & 1 == 1) {
              // make some space for this hex-digit by
              // shifting the previous hex-digit with 4 bits to the left:
              code[bytesread >> 1] = (val | (tempbyte << 4));
  
              if (bytesread >> 1 != 5) {                // If we're at the checksum byte,
                checksum ^= code[bytesread >> 1];       // Calculate the checksum... (XOR)
              };
            } else {
              tempbyte = val;                           // Store the first hex digit first...
            };
  
            bytesread++;                                // ready to read next digit
          } 
        } 
  
        // Output to Serial:
  
        if (bytesread == 12) {                          // if 12 digit read is complete
          //Serial.print("5-byte code: ");
          for (i=0; i<6; i++) {
            if (code[i] < 16){
              //Serial.print("0");
              rfid = rfid + "0";
            }
            //Serial.print(code[i], HEX);
            rfid = rfid + String(code[i], HEX);
          }  
          
          //Serial.println();
          Serial.print("Checksum: ");
          Serial.print(code[5], HEX);
          if (code[5] == checksum){
            Serial.println(" -- passed.");
            
              //blinkPin(yellowpin, 500); // acknowledge that RFID card has been read
              buzz(speakerPin, 600, 500); // buzz the buzzer on speakerPin at xxxHz for xxx milliseconds
            
              rfid.toUpperCase();
              Serial.println("RFID: " + rfid);
              
              String url_base = "/RFIDCheckinSystem/checkin_submit_manual.php?";
              String url_param1 = "im_type=" + String(im_type);
              String url_param2 = "&thirdpartyid=" + rfid;
              String url_param3 = "&sublocation=" + String(sublocation);
              String url_httptail = " HTTP/1.0";
              
              String url_complete = url_base + url_param1 + url_param2 + url_param3 + url_httptail;
              Serial.println("url: " + url_complete);
              

                
            String pageValue = connectAndRead(url_complete); //connect to the server and read the output
            Serial.println(pageValue); //print out the findings.
              
          }
          else
            Serial.println(" -- error.");
          
          Serial.println();
        }
  
        bytesread = 0;
      }
      //delay(2000);
      writingToDB = false;
    }
  }
}

String connectAndRead(String url){
  //connect to the server
  
  Serial.println("connecting...");

  //port 80 is typical of a www page
  if (client.connect(server, 80)) {
    Serial.println("connected");
    client.print("GET ");
    client.println(url);
    client.println();

    blinkPin(greenpin, 500); //flash green LED to confirm successful connection
    return readPage(); //go and read the output

  }else{
    blinkPin(redpin, 1000); //flash red LED to indicate that connection failed
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
      Serial.print(c);
      
      //opportunity to store a char[] that occurs in between particular characters
      if (c == '[' ) { //'<' is our begining character
        startRead = true; //Ready to start reading the part 
      }else if(startRead){

        if(c != '+'){ //'>' is our ending character
          inString[stringPos] = c;
          stringPos ++;
        }else{
          //got what we need here! We can disconnect now
          startRead = false;
        }

      }
    
    }
    else{
      client.stop();
      client.flush();
      Serial.println();
      Serial.println("disconnecting.");
      return inString;
    }
  }

}

void blinkPin(int c, int ms){
    digitalWrite(c, HIGH);
    delay(ms);
    digitalWrite(c, LOW);
    //delay(ms);
}

void buzz(int targetPin, long frequency, long length) {
  long delayValue = 1000000/frequency/2; // calculate the delay value between transitions
  //// 1 second's worth of microseconds, divided by the frequency, then split in half since
  //// there are two phases to each cycle
  long numCycles = frequency * length/ 1000; // calculate the number of cycles for proper timing
  //// multiply frequency, which is really cycles per second, by the number of seconds to 
  //// get the total number of cycles to produce
 for (long i=0; i < numCycles; i++){ // for the calculated length of time...
    digitalWrite(targetPin,HIGH); // write the buzzer pin high to push out the diaphram
    delayMicroseconds(delayValue); // wait for the calculated delay value
    digitalWrite(targetPin,LOW); // write the buzzer pin low to pull back the diaphram
    delayMicroseconds(delayValue); // wait againf or the calculated delay value
  }
}
