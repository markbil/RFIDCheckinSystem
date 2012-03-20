import processing.serial.*;
import java.awt.datatransfer.*;

Serial myPort;  
String inString;

PFont fontA;
PImage jpg;

ClipHelper cp = new ClipHelper();

void setup() 
{
  size(500, 500); 
  myPort = new Serial(this, Serial.list()[0], 9600);
  myPort.bufferUntil('\n'); 
  fontA = loadFont("HelveticaNeue-24.vlw");
  textFont(fontA, 24);
  jpg = loadImage("scan.jpg");
  imageMode(CENTER);
  textAlign(CENTER);
}

void draw()
{
  background(255);
  image(jpg, width/2, height/2);  
  
  if(inString != null){
    fill(150,255);
  text("RFID = " + inString, width/2, height/2);
  text("...has been copied to the clipboard!", width/2, height/2 + 30);
  }
}

void serialEvent (Serial myPort) {
  
  inString = myPort.readStringUntil('\n');

  if (inString != null) {    
    inString = trim(inString); // trim off any whitespace:
  print("RFID = " + inString + " : ");
  cp.copyString(inString);
   
 }  
}

