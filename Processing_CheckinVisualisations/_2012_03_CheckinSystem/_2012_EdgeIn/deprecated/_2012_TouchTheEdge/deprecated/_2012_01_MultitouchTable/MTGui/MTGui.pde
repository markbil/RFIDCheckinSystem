import bluetoothDesktop.*;
import TUIO.*; 

PApplet pa;

color systemBackgroundColor = color(214, 248, 112); 

GUI gui1; 
GUI gui2; 
GUI gui3;
GUI floorplanGUI;

GUIFadeOutAnimator gui1_GUIFadeOutAnimator;
GUIScaleInAnimator gui1_GUIScaleInAnimator;
GUIScaleOutAnimator gui1_GUIScaleOutAnimator;
GUIScaleInAnimator gui2_GUIScaleInAnimator;
GUIScaleOutAnimator gui2_GUIScaleOutAnimator;


TwisterAnimator gui1_TwisterAnimator;

Button nextButton;
Button backButton;
Button checkinButton;
TextField textfield;


GUI bluetoothServerGUI;
Keyboard systemKeyboard; 

//variable 
boolean gui1_visible = true;
boolean gui2_visible = false;
boolean gui3_visible = false;
boolean checkinButton_visible = false;


//final String DOMAIN = "meetmee.javaprovider.net";
//final String ADDR = "/php/edge_multitouch/checkin_submit.php";
final String DOMAIN = "localhost";
final String ADDR = "/edge_multitouch/checkin_submit.php";


void setup() { 
  size(screen.width, screen.height-100); 
  smooth(); 
  initTuioHandler();
  pa = this;
  
  //GUI1
  gui1 = new GUI(); 
  Label label1_gui1 = new Label("What are you here for today?");
  label1_gui1.setTranslation(0,0);
  
  textfield = new TextField("");
  textfield.setTranslation(0,100);
  textfield.setBoundaries(1000,50);
  
  systemKeyboard = new Keyboard(0,300);
  
  
  systemKeyboard.setEditor(textfield.editor); 
  textfield.editing = true;
  
 
  backButton = new Button("Back"){ 
  public void onTouch(){
        println("touch: " + this);
         gui1_visible = true;
         gui2_visible = false;
         checkinButton_visible = false;         
         
    };
  };
  backButton.setTranslation((screen.width/5),(screen.height/5)*4); 
  
  nextButton = new Button("Next"){ 
  public void onTouch(){
        println("touch: " + this);
//         gui1_GUIFadeOutAnimator = new GUIFadeOutAnimator(gui1);
//         //gui1_TwisterAnimator = new TwisterAnimator(gui1);
//         gui1_GUIScaleOutAnimator = new GUIScaleOutAnimator(gui1);
         gui1_visible = false;
         gui2_visible = true;
//         gui2_GUIScaleInAnimator = new GUIScaleInAnimator(gui2);
         
         
    };
  };
  nextButton.setTranslation((screen.width/5)*4,(screen.height/5)*4);   

  gui1.addWidget(label1_gui1);
  gui1.addWidget(textfield);
  gui1.addWidget(systemKeyboard);
  gui1.setTranslation(0,-(screen.height/3));
  
  
  
  //GUI2
  gui2 = new GUI(); 
  Label label1_gui2 = new Label("What place will you be using?");
  floorplanGUI = new Floorplan();
  floorplanGUI.setScale(1);
  floorplanGUI.setTranslation(-(screen.width/2),-(screen.height/2)+400);


  gui2.addWidget(label1_gui2);
  gui2.addWidget(floorplanGUI);
//  gui2.addWidget(backButton);
  
  gui2.setTranslation(0,-(screen.height/3));
  //new ManipulationAnimator(floorplanGUI); 
  
  
  //GUI3
  checkinButton = new Button("Checkin!"){ 
  public void onTouch(){
        println("touch: " + this);
        String location = ((Floorplan)floorplanGUI).getSelectedFloorplanButton();
        String statusmsg = textfield.getTextString();
        println("Checking in..... " + "Location: " + location + "\t Statusmessage: " + statusmsg);
        Connection c = new Connection(pa, DOMAIN, ADDR);
        c.sendCheckin(location, statusmsg);
         gui1_visible = true;
         gui2_visible = false;
         gui3_visible = false;
         textfield.setTextString(""); 
        checkinButton_visible = false;
    };
  };
  
  checkinButton.setTranslation((screen.width/5)*4,(screen.height/5)*4);
  
  //other GUIs
  bluetoothServerGUI = new BluetoothServerGUI(this);
  Label label1 = new Label("HELLO HELLO"); 
  Label label2 = new Label("WORLD WORLD"); 
  label2.setRotation(90); 
  //new ManipulationAnimator(gui2); 
  
  bluetoothServerGUI.addWidget(label1);
  bluetoothServerGUI.addWidget(label2);
  

 
// gui1_GUIFaderAnimator.setFaderInvisible(); 
// gui1.removeAnimator(gui1_GUIFaderAnimator);
// gui1.removeAnimator(gui1_TwisterAnimator);
// gui1.removeAnimator(gui1_ScaleAnimator);
  
} 

void draw() { 
  background(systemBackgroundColor);
  //bluetoothServerGUI.draw();
  if (gui1_visible){
    gui1.draw();
    nextButton.draw();
  }
  if (gui2_visible){
    gui2.draw();
    backButton.draw();
  }
  if (checkinButton_visible){
    checkinButton.draw();
  }



  
  cleanupCursors(); 
  drawTuioCursors();
} 


MouseCursor mouse; 
void mousePressed() {
  if (mouse != null) {
      mouse.setState(MTCURSOR_JUST_DELETED);
  } 
  mouse = new MouseCursor();
}

void mouseReleased() {
  mouse.setState(MTCURSOR_JUST_DELETED);
  mouse = null; 
}

