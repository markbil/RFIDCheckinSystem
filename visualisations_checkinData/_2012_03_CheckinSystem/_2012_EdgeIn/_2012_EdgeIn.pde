import bluetoothDesktop.*;
import TUIO.*; 
import processing.opengl.*; 

color systemBackgroundColor = color(214, 248, 112); 

//PaperSketchApp paperSketch; 
//ProjectExplorerApp projectExplorer; 
//CheckinSystemApp checkinSystem;
CheckinsOverviewApp checkinsOverview;
RFIDReaderApp rfidReaderApp;

String host_server = "localhost";

void setup() { 
//  size( screen.width, screen.height); 
  size( screen.width/2, screen.height/2); 
//  size( 900, 700); 
  
  smooth(); 
  initTuioHandler();
  MULTITOUCH_MODE = true; 
  
//paperSketch = new PaperSketchApp(this); 
//  projectExplorer = new ProjectExplorerApp(this); 
//checkinSystem = new CheckinSystemApp(this);
  checkinsOverview = new CheckinsOverviewApp(this);
//  rfidReaderApp = new RFIDReaderApp(this);
} 


void draw() { 
  background(systemBackgroundColor);
//  paperSketch.draw(); 
//  projectExplorer.draw(); 
// checkinSystem.draw();
  checkinsOverview.draw();
//  rfidReaderApp.draw();
  
  cleanupCursors(); 
  drawTuioCursors();
} 



