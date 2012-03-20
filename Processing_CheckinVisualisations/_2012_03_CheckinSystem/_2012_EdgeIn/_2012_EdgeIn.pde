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
  size( screen.width, screen.height); 
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



