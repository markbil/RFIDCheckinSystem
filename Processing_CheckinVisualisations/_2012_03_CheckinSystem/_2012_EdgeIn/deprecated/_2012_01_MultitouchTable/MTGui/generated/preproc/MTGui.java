import processing.core.*; 
import processing.xml.*; 

import bluetoothDesktop.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class MTGui extends PApplet {

class BasicAnimator extends BasicEditor {

  BasicAnimator(Widget target) {
    super(target); 
    target.addAnimator(this);
  } 

  public void step() {
  }
}


class BasicEditor {
  Widget target; 

  BasicEditor(Widget target) {
    this.target = target;
  }
  
  public void done() {
  	//override me
  }
}


Bluetooth bt;
ArrayList clients = new ArrayList();
ArrayList images = new ArrayList();
PApplet papplet;

// image display properties
final int IMAGE_HEIGHT = 200;
final int IMAGE_WIDTH = 200;
final int IMAGE_BORDER = 10;

class BluetoothServerGUI extends GUI {
	
	BluetoothServerGUI(PApplet parent) {
	//  size(1024,768);
	 // font = createFont("Courier", 15);
	//  textFont(font);
	  try {
	    bt = new Bluetooth(parent, "57f1d57d4bf54ff8b25e70e60adf9fbc"); // This UUID matches the UUID in the client Android app
	    bt.start("imageServer");  // Start the service
	  } 
	  catch (RuntimeException e) {
	    println("bluetooth device is not available. (or license problem if using avetana)"); 
	    println(e);
	  }
	  papplet = parent;
	}

	public void drawWidget() {

	  // update all the clients
	  for (int i=0; i< clients.size(); i++) {
	    ((ImageClient) clients.get(i)).update(); 
	  }
	
	  // draw all the images
	  for (int i=0; i< images.size(); i++) {
	    //pushMatrix();
	    //translate(IMAGE_BORDER + (i%5)*(IMAGE_BORDER+IMAGE_WIDTH), IMAGE_BORDER + int(i/5.0) * (2*IMAGE_BORDER+IMAGE_HEIGHT));
	    ((ImageHandler) images.get(i)).draw();
	    //text(((ImageHandler) images.get(i)).name, 0, IMAGE_HEIGHT+15);
	    //popMatrix();
	  }
	  
	  super.drawWidget(); 
	
	}
}


// callback for the bluetooth library
// gets called when a new client connects
public void clientConnectEvent(Client c) {
  clients.add(new ImageClient(c));
  println("new client: " + c.device.name);
}

/*****************************************************
 *
 * Class ImageClient
 * handles the connection to the bluetooth client
 *
 *****************************************************/

class ImageClient {

  Client bluetoothClient;         // the bluetooth client
  ImageHandler currentImage;      // holds the image that is currently being loaded
  boolean loadingImage = false;   // if we are currently loading an image


    ImageClient(Client bluetoothClient) {
    this.bluetoothClient = bluetoothClient;
  } 

  public void update() {
    if (loadingImage) {
      // we are loading an image, so check for new bytes
      int nrBytes = bluetoothClient.available();
      if (nrBytes>0) {
      	println("reading " + nrBytes + " bytes"); 
        byte[] inBytes = new byte[nrBytes];
        bluetoothClient.readBytes(inBytes);
        // send the new Bytes to the Image-object
        loadingImage = ! currentImage.addBytes(inBytes);
      } 
    } 
    else {
      // we're not yet loading an image, so check for an int 
      // the mobile phone sends the nr of bytes of the new image, if there is one
      if (bluetoothClient.available() > 0) {
      	int expected = bluetoothClient.readInt(); 
      	println("Expect to read " + expected + " bytes"); 
        currentImage = new ImageHandler(expected, bluetoothClient.device.name);
        images.add(currentImage);
        loadingImage = true;
      }
    }
  }
}

/*****************************************************
 *
 * Class ImageHAndler
 * stores & displays a received image
 *
 *****************************************************/
 
 class ImageHandler extends Widget {

  private PGraphics myRenderer;
  private PImage myImage;
  private int byteSize;
  private int loadedBytes;
  private boolean loaded = false;
  private byte[] imageBytes;
  String name; 

  ImageHandler(int byteSize, String name) {
  	super(0,0); 
    this.byteSize = byteSize;
    this.name = name;
    myImage = createImage(100,100, RGB);
    myRenderer = createGraphics(IMAGE_WIDTH, IMAGE_HEIGHT, JAVA2D);
    imageBytes = new byte[0];
  } 

  public void drawWidget() {
  	translate(-IMAGE_WIDTH / 2.0f, -IMAGE_HEIGHT / 2.0f); 
    image(myImage, 0, 0, IMAGE_WIDTH, IMAGE_HEIGHT);
  }


  // adds the new bytes to the byte-array
  // returns true if the image was loaded completely
  // returns false if the image is not yet loaded
  public boolean addBytes(byte[] newBytes) {
    // add new bytes to our byte-array
    for (int i=0; i< newBytes.length; i++ ) {
      imageBytes = (byte[]) append(imageBytes, newBytes[i]);
    }

    // draw the loading progress in my renderer
    myRenderer.beginDraw();
    myRenderer.background(0);
    myRenderer.noFill();
    myRenderer.stroke(255);
    myRenderer.rect(0,0,IMAGE_WIDTH, IMAGE_HEIGHT);
    myRenderer.rect(5, IMAGE_HEIGHT-10, IMAGE_WIDTH-10, 5);
    myRenderer.fill(255);
    myRenderer.rect(5, IMAGE_HEIGHT-10, map(imageBytes.length, 0, byteSize, 0, IMAGE_WIDTH), 5);
    myRenderer.endDraw();

    // get the image from the renderer
    myImage = myRenderer;

    // is the image loaded completely?
    if (imageBytes.length == byteSize) {
      myImage = bytesToPImage(imageBytes);
      loaded = true;
      println(name + " sent " + round(byteSize/1024.0f) + " kB");
      return true;
    }
    return false;
  }

  // takes an array of bytes and creates a PImage from it.
  // seen here: http://processing.org/discourse/yabb_beta/YaBB.cgi?board=Integrate;action=display;num=1134385140
  public PImage bytesToPImage(byte[] bytes) {
    Image awtImage = java.awt.Toolkit.getDefaultToolkit().createImage(bytes);
    java.awt.MediaTracker tracker = new java.awt.MediaTracker(papplet);
    tracker.addImage(awtImage, 0);
    try {
      tracker.waitForAll();
    } 
    catch (InterruptedException e) { 
    }
    PImage newPImage = new PImage(awtImage);
    return newPImage;
  }

}
class Button extends Widget {

  Button(String title) {
    super(new Point(0.0f, 0.0f)); 
    setTextMargin(1.5f); 
    setTextString(title);
  }

  public void drawBoundingBox() {
    fill(fillColor); 
    stroke(strokeColor); 

    beginShape();
    java.awt.geom.PathIterator i = getBoundingBox().getPathIterator(null); 
    while (i.isDone () == false) {
      float[] points = new float[6];
      int type = i.currentSegment(points);
      if (type == java.awt.geom.PathIterator.SEG_MOVETO || type == java.awt.geom.PathIterator.SEG_LINETO) {
        vertex(points[0], points[1]);
      } 
      i.next();
    }  
    endShape(CLOSE);
  }

  public void drawText() {
    if (alpha(textColor) > 0) { // this is weird... I know
      textFont(getFont());
      fill(textColor);		
      textAlign(CENTER, CENTER); 				
      text(getTextString(), 0, 0);
    }
  }
	
  public void drawWidget() {
	drawBoundingBox(); 
	drawText(); 
  }
}


public int fadeColorOut(int c, int steps) {
	float alphaChannel = 0.0f; 
	if (steps != 0) { 
		 alphaChannel = alpha(c); 
		alphaChannel -= (alphaChannel / steps);
	} 
        println("fade out: " + red(c) +":"+  green(c)+":"+ blue(c)+":"+ alphaChannel);  
	return color(red(c), green(c), blue(c), alphaChannel);  
}

public int fadeColorIn(int c, int steps) {
	float alphaChannel = 255.0f; 
	if (steps != 0) { 
		alphaChannel = alpha(c); 
		alphaChannel += ((255-alphaChannel) / steps);
	} 
        
        println("fade in: " + red(c) +":"+  green(c)+":"+ blue(c)+":"+ alphaChannel);  
	return color(red(c), green(c), blue(c), alphaChannel);  
}

class FaderAnimator extends BasicAnimator {
	FaderAnimator(Widget target) {
		super(target); 
	}
	
	int steps = 0;
	
	public void fadeTargetIn() {
		steps = 10; 
	}
	
	public void fadeTargetOut() {
		steps = -10; 
	} 
	 
	public void step() {
		if (steps < 0) {
			target.fillColor = fadeColorOut(target.fillColor, -steps);
			target.strokeColor = fadeColorOut(target.strokeColor, -steps);
			target.textColor = fadeColorOut(target.textColor, -steps);
			steps++;  
		}
		
		if (steps > 0) {
			target.fillColor = fadeColorIn(target.fillColor, steps);
			target.strokeColor = fadeColorIn(target.strokeColor, steps);
			target.textColor = fadeColorIn(target.textColor, steps);
			steps--; 
		}
			
	}
}


class FloorplanButton extends Button {
  int id;
  //        boolean selected = false;
  Floorplan floorplan;



  FloorplanButton(String title, int id, Floorplan f) {
    super(title);
    this.id = id;
    this.floorplan = f;
  }


  public void onTouch() {
    //if NOT an already selected space is being touched on...
    if (floorplan.selectedFloorplanButton != this) {
      //println("not this");
      if (floorplan.selectedFloorplanButton.id != 0) {
        //println("not nowhere");
        floorplan.selectedFloorplanButton.fillColor = systemFillColor; //paint the previously selected area back to white
        floorplan.selectedFloorplanButton.textColor = systemTextColor; //paint the previously selected area back to white
      }
      floorplan.selectedFloorplanButton = this;
      print(getTextString());
      floorplan.selectedFloorplanButton.fillColor = floorplan.selectedSpaceFillColor; //paint the currently selected area
      floorplan.selectedFloorplanButton.textColor = floorplan.selectedSpaceTextColor;
      println(" (id=" + floorplan.selectedFloorplanButton.id +")");
    }
    else {
      //if already selected space is being touched on...
      //println("else");
      floorplan.selectedFloorplanButton.fillColor = systemFillColor;
      floorplan.selectedFloorplanButton.textColor = systemTextColor;
      floorplan.selectedFloorplanButton = floorplan.noWhere;
      println(" (id=" + floorplan.selectedFloorplanButton.id +")");
    }
  }
}


Point lastTouch = null; 

class GUI extends Widget {
	
	Point center;  
	float scale = 1.0f; 
	float angle = 0.0f; 
	ArrayList widgets = new ArrayList(); 
	
	//create a new GUI centered on the screen; 
	GUI() {
		super(new Point(width / 2.0f, height / 2.0f)); 
	}
		
	

	//create a new GUI centered at absolute coordinates x,y
	GUI(Point center) {
		super(center); 
	}
		
	public void drawWidget() {
		line(-100, 0, 100, 0);
		line(0, -100, 0, 100);
		
		
		for (int i = 0; i < widgets.size(); i++) {
			Widget w = (Widget) widgets.get(i); 
			w.draw(); 
		}
	}
		
	
	//add a child widget  to this GUI
	public void addWidget(Widget child) {
		widgets.add(child); 
	}
	
	public void removeWidget(Widget child) {
		widgets.remove(widgets.indexOf(child)); 
	}
}

		

class Key{
  // The position of the Key is stored and managed using polar geometry.
  // This will allow the keboard to be draw rotated and continue to be funtional.
  // In order to do that first we need the center o polar center position
  PVector center; // this is the x and y position of the center of the keyboard
  
  float rad = 0; // radio from the center of the keyboard
  float ang = 0; // angle from the center of the keyboard
  
  // Then this class can convert from polar (rad, ang) to cartesian (x, y) geometry
  PVector pos;   // This is the position of the key in x and y coordinates
  
  float north = 0;  // This is seams useles now but when the keyboard start rotation this will give
                    // the correct angle of how to be draw
  
  String s;        // the sting of the KEY
  
  int w = 53;      // width 
  int h = 53;      // height
  
  PFont font;
  int fg = color(255);
  int bg = color(0);
  
  // -------------------------------------------------------- Constructors
  Key(PVector _center, String _s){
    s = _s;
    font = createFont("Arial",(h/10)*3);
    calcPos(_center,0);
  }
  
  Key(PVector _center, String _s,float _rad, float _ang, int _w, int _h){
    rad = _rad;
    ang = _ang;
    s = _s;
    w = _w;
    h = _h;
    
    font = createFont("Arial",(h/10)*3);
    calcPos(_center,0);
  }
  // -------------------------------------------------------- Location Funtion
  
  // The next 3 funtion give the cartesian (x and y) coodinates from the 
  // global variables rad and ang (polar coordinates)
  public void calcPos(PVector _center,float _north){
    north = _north;
    center = _center;
    
    pos = new PVector(calcX(),calcY());
    pos.add(center);
  }
  
  public float calcX(){
    float posX = rad * cos(ang + north);
    return posX;
  }

  public float calcY(){
    float posY = rad * sin(ang + north);
    return posY;
  }    
  
  // This next 3 funtion make exactly the oposite. Set the rad and ang from
  // a given x and y position. 
  public void moveTo(int _x, int _y){
    PVector place = new PVector(_x,_y);
    rad = calcRad(place);
    ang = calcAng(place);
    calcPos(center,north);
  }
  
  public float calcRad(PVector _pos){
    float distance = _pos.dist(center);
    return distance;
  }
  
  public float calcAng(PVector _pos){
    _pos.sub(center);
    return _pos.heading2D();
  }
  
  // ------------------------------------------------------------------- Draw and Check
  public void render(){
    pushMatrix();
      translate(pos.x, pos.y);
      rotate(north);
      rBox(0,0,w,h,bg,fg,true);
      fill(fg);
      textFont(font);
      textAlign(CENTER);
      text(s,0,(h/10)*1.3f);
    popMatrix();
  }

  public boolean isOver(PVector _loc){
    if (pos.dist(_loc) <= w/2) return true;
    else return false;
  }

  public boolean isOver(int _x, int _y){
    PVector _loc = new PVector(_x,_y);
    if (pos.dist(_loc) <= h/2) return true;
    else return false;
  }  
}

Keyboard systemKeyboard; 

class Keyboard {
  Key[] keys;        // Array of keys 

    PVector pos;       // center of the keyboard. Replace the kCenter of the Tiper3MapMaker. So here this points is, the keyboard will be draw arround (using polar geometry) 
  float north = 0;   // this is the radient of rotation of the keyboard

  boolean border;    // this is came from the Tiper3MapMaker, and is usefull for preventing opening empty keyboard maps
  float   borderWidth;  // This is the width and height of the keyboard
  float   borderHeight; // It wirted on the first line of the .kbd file 

  PFont font;

  //----------------------------------- CONSTRUCTOR FUNTIONS  
  Keyboard(int _x, int _y) {
    pos = new PVector(_x, _y);                     // Set the initial position of the keyboard

    font = createFont("Arial", 12);                // Load the font
    String[] data = loadStrings("map.kbd");       // Load the map of the keys made by Tiper3MapMaker 

    if ( data.length > 1 ) {                       // Populate the information from the keyboard map file to the keys variable
      keys = new Key[data.length-1];              // Set the lenght of total key parameters

      // The first line of the file is for the border the center point and width & height
      String[] borderValues = split(data[0], ","); // of the keyboard. This is usefull only to this program.

      borderWidth = PApplet.parseFloat(borderValues[2]);       // the fist to borderValues are the ones of kCenter used by Tiper3MapMaker. Here is useless      
      borderHeight = PApplet.parseFloat(borderValues[3]);
      border = true;                              

      for (int i = 0; i < keys.length; i++) {       // Here start reading and extracting the rest of the keys parameters (remember that the fist line only have the info about the keyboard center and width&height)
        String[] values = split(data[i+1], ",");   // Extract the content between , 
        float rad = PApplet.parseFloat(values[1]);             // the first value is the Letter or Key, the second one is radio from the center
        float ang   = PApplet.parseFloat(values[2]);           // the 3th is the angle on radians from the center (this last to parameters are the ones that let the keabord be redraw in any angle and continue working)
        int w  = PApplet.parseInt(values[3]);                  // the 4th and 5th are the with and height of each key. 
        int h   = PApplet.parseInt(values[4]);
        keys[i] = new Key(pos, values[0], rad, ang, w, h); // Finaly enter the information in to the "keys" array
      }
    } 
    else {                                      // If the file is empty or just the header with the border.
      keys = new Key[0];                          //  No keys are load
      border = false;                             //  Nothing is draw
    }
  }

  // Rotate the keyBoard
  public void rot(float _ang) {
    north = _ang;
    update();
  }

  // Move the central point in order to re-draw the keyboard in another place
  public void moveTo(float _x, float _y) {
    pos = new PVector(_x, _y);
    update();
  }

  //Update the information of the position and rotation of each key (just in the array of keys, NOT on the file... so this is temporal)
  public void update() {
    for (int i = 0; i< keys.length; i++) {
      keys[i].calcPos(pos, north);
    }
  }

  // Draw the keyBoard
  public void render() {
    if (visible) { 
      //First draw the border of the keyboard. For that will push, translate, rotate and pop the Matrix.
      pushMatrix();
      translate(pos.x, pos.y);
      rotate(north);
      rBox(0, 0, (int)borderWidth, (int)borderHeight, color(0), color(255), false);
      popMatrix();
      // After that draw all the keys. If the keyboard is moved or rotated each one of the keys are previusly updated to on each angle and position
      for (int i = 0; i < keys.length; i++) keys[i].render();
    }
  }


  // ----------------------------------------------------------------------------- Events
  // Check if the x and y coordinates are over the keyboard
  public boolean isOver(int _x, int _y) {
  	
  	if (!visible) return false; 
  	
    PVector _loc = new PVector(_x, _y); 
    if (pos.dist(_loc) <= borderWidth/2) return true;
    else return false;
  }

  // Check if the vector coordinates is over the keyboard
  public boolean isOver(PVector _loc) {
    if (pos.dist(_loc) <= borderWidth/2) return true;
    else return false;
  }

  // Check every key if certain x and y position is over it... and return the letter of each one  
  public String check(int _x, int _y) {    // (Note that if you change the .kbd file you can writte words insted of just put the letter in order to make complex combinations like SPACE, SHIFT, etc)
    String pressed = "";           // If nothing is press a nothing is return

    for (int i = 0; i< keys.length; i++) {
      if (keys[i].isOver(_x, _y)) {
        keys[i].bg = color(255);
        keys[i].fg = color(0);
        pressed = keys[i].s;
      } 
      else {
        keys[i].bg = color(0);
        keys[i].fg = color(255);
      }
    }
    
    if (editor != null) {
    	if (pressed.contains("Delete")) editor.deleteCharacter();
    	else if (pressed.contains("Enter")) editor.done(); 
    	else editor.addCharacter(pressed.toLowerCase());
    }

    return pressed;
  }

  private boolean visible = true;
  public boolean isVisible() {
    return visible;
  }

  public void setVisible(boolean visible) {
    this.visible = visible;
  }    

  private TextEditor editor = null;
  public void setEditor(TextEditor editor) {
    this.editor = editor;
  }
}



class Label extends Widget {

  Label(String textString) {
    super(new Point(0.0f, 0.0f)); 
    setTextMargin(2.0f); 
    setTextString(textString);
  }

  public void drawWidget() {		
    textFont(getFont());
    fill(textColor);
    int fontSize = getFontSize();
    textAlign(CENTER, CENTER); 	
    text(getTextString(), 0, 0);
  }

  public String toString() {
    return "L: " + getTextString();
  }
}




GUI gui1; 
GUI gui2; 
GUI gui3; 
GUI gui4;
GUI gui5; 


int fg1 = color(255, 0, 0, 128); 
int fg2 = color(0, 0, 255, 128); 
int fg = fg1; 

public int switchForeground() {
  fg = ((fg == fg1) ? fg2 : fg1);
  return fg;
}

public int randomColor() {
  return color(random(255), random(255), random(255));
}

public void setup() { 
  size(screen.width, screen.height); 
  smooth(); 
  systemKeyboard = new Keyboard(500, 500);
  systemKeyboard.setVisible(false);   

  //how to define a touch callback on the fly...
  Label l1 = new Label("Hello World") {
    public void onTouch() {
      textColor = randomColor();
    }
  }; 
  l1.setFont(createFont("Arial", 48)); 
  l1.addAnimator(new TwisterAnimator(l1));
  //editor = new LabelEditor(l1); 

  gui1 = new GUI(new Point(200, 200)); 
  gui1.addWidget(l1); 	

  gui2 = new LabelMatrix(); 
  gui3 = new Buttons(500, 500);
  gui4 = new Floorplan();
  gui5 = new BluetoothServerGUI(this); 
} 

public void draw() { 
  background(200, 200, 200);
  resetMatrix(); 
//  gui1.draw();  
//  gui2.draw();  
//  gui4.draw();
//  gui3.draw();
  gui5.draw(); 
  //keyboard.moveTo(keyboard.pos.x + random(-0.01,0.01), keyboard.pos.y + random(-0.01,0.01));
  //keyboard.render();
  systemKeyboard.render();
} 



public void mouseClicked() {
  lastTouch = new Point(mouseX, mouseY); 

  if (systemKeyboard.isOver(mouseX, mouseY) ) {
    systemKeyboard.check(mouseX, mouseY);
  }
}

public void mouseReleased() {
}



//--------------------------- EXAMPLE STUFF
class Button1 extends Button {
  Button2 target; 

  Button1(String text) {
    super(text);
    fillColor = color(255, 0, 0, 255); 
    strokeColor = color(0, 255, 0, 255); 
    textColor = color(0, 0, 255, 255);
  }

  public void onTouch() {
    target.fillColor = switchForeground();
  }
}

class Button2 extends Button {
  FaderAnimator fader;  		

  Button2(String text) {
    super(text);
  }

  boolean b1IsVisible = true; 

  public void onTouch() {
    if (b1IsVisible) {
      fader.fadeTargetOut();
      b1IsVisible = false;
    } 
    else { 
      fader.fadeTargetIn();
      b1IsVisible = true;
    }
  }
}


class Buttons extends GUI {

  Buttons(int a, int b) {
    super (new Point(a, b)); 
    Button1 b1; 
    Button2 b2; 
    TextField t1; 
    
    t1 = new TextField("What are you up to?"); 
    t1.setTranslation(200, -300); 
    t1.setBoundaries(600, 80); 

    b1 = new Button1("Button 1"); 
    b1.setTranslation(-400, -100); 

    b2 = new Button2("Button 2");
    b1.target = b2; 

    b2.setTranslation(400, 100);
    b2.setRotation(PI/8);
    b2.fader = new FaderAnimator(b1);

    addWidget(b1); 
    addWidget(b2);
    addWidget(t1);
  }
}

class LabelMatrix extends GUI {

  LabelMatrix() {
    for (int i = 0; i < 10; i++) {
      Label l = new Label("Label-" + i); 
      l.setRotation(PI/8 * i); 
      l.setTranslation(300, 0); 
      addWidget(l);
    }
  }
}

class TwisterAnimator extends BasicAnimator {
  TwisterAnimator(Widget target) {
    super(target);
  }

  public void step() {
    target.setRotation(target.angle + PI/256);
  }
}


class Point {
	float x = 0.0f; 
	float y = 0.0f; 
	Point(float x, float y) {
		this.x = x; 
		this.y = y; 
	}
}
		
class TextEditor extends BasicEditor {
  TextEditor(TextField target) {
    super(target);
  }

  public void addCharacter(String c) {
    target.setTextString(target.getTextString() + c);
  }

  public void deleteCharacter() {
  	if (target.getTextString().length() > 0) {
	    target.setTextString(target.getTextString().substring(0, target.getTextString().length() -1));
  	}
  }
  
  public void done() {
  	systemKeyboard.setEditor(null); 
  	systemKeyboard.setVisible(false); 
  	((TextField)target).editing = false; 
  }
}


class TextField extends Button {

  TextField(String initString) {
    super(initString);
  }

  boolean editing = false; 
  TextEditor editor = new TextEditor(this); 
  
  public void onTouch() {
    if (!editing) {
      setTextString(""); 
      systemKeyboard.setEditor(editor); 
      systemKeyboard.setVisible(true);
      editing = true; 
    } else {
	  editor.done(); 
      editing = false; 
    }    	
  }
  
  int w = 0; 
  int h = 0;   
  
  public void setBoundaries(int w, int h) {
  	this.w = w; 
  	this.h = h; 
  	super.setBoundaries(w, h); 
  }
  
  public void drawWidget() {
  	drawBoundingBox(); 
  	
  	if (alpha(textColor) > 0) { // this is weird... I know
	    textFont(getFont());
	    fill(textColor);		
	    textAlign(LEFT, CENTER); 				
	    text(getTextString(), (int)((-w / 2.0f) + (h/3.0f)), 0);
  	}
  }
  	
}


int systemFontSize = 48;
int systemFillColor = color(255, 255, 255); 
int systemStrokeColor = color(0, 0, 0);   
PFont systemFont = createFont( "Times", systemFontSize);
int systemTextColor = color(0, 0, 0); 


class Widget {
  Point center = new Point(0, 0); 
  float scaleFactor = 1.0f; 
  float angle = 0.0f; 
  boolean rotateFirst = false; 
  boolean translateFirst = false; 
  private java.awt.Polygon bb;  
  boolean autoBB = true; 

  private float textMargin = 1.5f; 
  public void setTextMargin(float textMargin) {
    this.textMargin = textMargin; 
    if (autoBB) bb = createBoundingBox(textString, textMargin);
  }

  public float getTextMargin() {
    return textMargin;
  }

  private String textString = "";
  public void setTextString(String textString) {
    this.textString = textString; 
    if (autoBB) bb = createBoundingBox(textString, textMargin);
  }

  public String getTextString() {
    return textString;
  }

  public java.awt.Polygon getBoundingBox() {
    if (bb == null) {
      bb = new java.awt.Polygon();
    }
    return bb;
  }


  public java.awt.Polygon createBoundingBox(String label, float margin) {
    
    textFont(getFont(), fontSize);
    java.awt.Polygon  bb = new java.awt.Polygon();
    bb.addPoint((int)(-textWidth(label)/margin), (int)(-fontSize/margin)); 
    bb.addPoint((int)( textWidth(label)/margin), (int)(-fontSize/margin)); 
    bb.addPoint((int)( textWidth(label)/margin), (int)( fontSize/margin)); 
    bb.addPoint((int)(-textWidth(label)/margin), (int)( fontSize/margin));
    return bb;
  }


  ArrayList animators = new ArrayList();

  //appearance. if null use system defaults
  int fillColor = systemFillColor; 
  int strokeColor = systemStrokeColor; 
  int textColor = systemTextColor; 

  private PFont font = systemFont;
  public void setFont(PFont newFont) {
    this.font = newFont; 
    if (autoBB) bb = createBoundingBox(textString, textMargin);
  }
  
  public PFont getFont() {
    return this.font;
  }		

  private int fontSize = systemFontSize; 
  public void setFontSize(int newSize) {
    this.fontSize = newSize; 
    if (autoBB) bb = createBoundingBox(textString, textMargin);
  }
  public int getFontSize() {
    return fontSize;
  }


  Widget(Point center) {
    this.center = center;
  }
  
  Widget(int x, int y) {
  	this.center = new Point(x, y); 
  }

  //move GUI relative to center
  public void setTranslation(Point distance) {
    setTranslation(distance.x, distance.y);
  }

  public void setTranslation(float x, float y) {
    if (!rotateFirst) translateFirst = true; 
    center.x += x; 
    center.y += y;
  }

  public void setRotation(float angle) {
    if (!translateFirst) rotateFirst = true; 
    this.angle = angle;
  }

  public void setScale(float scaleFactor) {
    this.scaleFactor = scaleFactor;
  }

  public void setBoundaries(int w, int h) {
    bb = new java.awt.Polygon();
    bb.addPoint((int)(-w/2), (int)(-h/2)); 
    bb.addPoint((int)(w/2), (int)(-h/2)); 
    bb.addPoint((int)(w/2), (int)(h/2)); 
    bb.addPoint((int)(-w/2), (int)(h/2));
    autoBB = false;
  }


  public void draw() {
    pushMatrix();

    if (translateFirst) {
      translate(center.x, center.y); 
      rotate(angle);
    } 
    else {
      rotate(angle);
      translate(center.x, center.y);
    }			 

    scale(scaleFactor);

    if (lastTouch != null) {
      if (this.contains((int)lastTouch.x, (int)lastTouch.y)) {
        this.onTouch();
        lastTouch = null;
      }
    }

    applyAnimations(); 		
    drawWidget();  


    popMatrix();
  }

  public void applyAnimations() {
    for (int i = 0; i < animators.size(); i++) {
      BasicAnimator animator = (BasicAnimator) animators.get(i); 
      animator.step();
    }
  }

  public void drawWidget() {
    //ok... this is a bit tricky... to create a new widget you must ALWAYS
    //override the drawWidget function, but if you implement a container your 
    //drawWidget will call the draw() on its children
    println("You MUST override the drawWidget() method from class Widget!!! " + this);
  }; 

  public boolean contains(int x, int y) {
    if (bb == null) return false; 

    //else

      java.awt.Polygon projectedBB = new java.awt.Polygon(); 					
    java.awt.geom.PathIterator i = getBoundingBox().getPathIterator(null); 

    while (i.isDone () == false) { 
      float[] points = new float[6];
      int type = i.currentSegment(points);

      if (type == java.awt.geom.PathIterator.SEG_MOVETO || type == java.awt.geom.PathIterator.SEG_LINETO) {
        int px = (int)screenX(points[0], points[1]); 
        int py = (int)screenY(points[0], points[1]);
        projectedBB.addPoint(px, py);
      }

      i.next();
    }  
    return projectedBB.contains(x, y);
  }

  public void addAnimator(BasicAnimator animator) {
    animators.add(animator);
  }

  public void removeAnimator(BasicAnimator animator) {
    animators.remove(animators.indexOf(animator));
  }

  public void onTouch() {
    //override this method to catch Mouse and TUIO events
    println("touch: " + this);
  }
}


class Floorplan extends GUI {

        int selectedSpaceFillColor = color(127, 0, 0);
        int selectedSpaceTextColor = color(255, 255, 255);
        FloorplanButton noWhere = new FloorplanButton("nowhere", 0, this);
        FloorplanButton selectedFloorplanButton = noWhere;

	Floorplan() {
           
          for (int i = 0; i < 11; i++) {
            FloorplanButton b1 = new FloorplanButton("Window Bay\n" + (i+1), i+1, this);
            b1.setTranslation((i-5)*90, -250);
            b1.setFont(createFont("Arial", 10));
            b1.setBoundaries(70, 70);
            addWidget(b1);
            
          }
          
          for (int i = 0; i < 2; i++) {
            FloorplanButton l1 = new FloorplanButton("Lab " + (i+1), i+1+11, this);
            l1.setFont(createFont("Arial", 10));
            l1.setBoundaries(160, 120);
            l1.setTranslation(405, (i-1)*140);
            addWidget(l1);
            
          }
          
          FloorplanButton a = new FloorplanButton("Auditorium", 15, this);
            a.setFont(createFont("Arial", 10));  
            a.setBoundaries(350, 270);
            a.setTranslation(-220, -20);
            addWidget(a);

          FloorplanButton l3 = new FloorplanButton("Lab 3", 16, this);
            l3.setFont(createFont("Arial", 10));
            l3.setBoundaries(70, 120);
            l3.setTranslation(270, 5);
            addWidget(l3);
            
          FloorplanButton c = new FloorplanButton("Coffee Kiosk", 17, this);
            c.setFont(createFont("Arial", 10));
            c.setBoundaries(100, 50);
            c.setTranslation(135, 5);
            addWidget(c);
	
	}

}





// this is just the funtion that allow you to draw the beatifull shape of a mac key.
public void rBox(int x, int y, int _w, int _h, int _bg, int _fg, boolean mode){
  float a;
  float b;
  
  if (mode){    // Mode = true -> box or key
    a = _h/6;
    b =  a/4;
  } else {      // Mode = false -> rectangualr or keyboard
    a = _h/12;
    b =  a/6;
  }
  
  float W = _w/2;
  float H = _h/2;
  
  fill(_bg);
  strokeWeight( 2 );
  stroke(_fg);
  beginShape(); 
    vertex(       x +W -a,  y -H );
    
    bezierVertex( x +W -b , y -H,
                  x +W    , y -H +b, 
                  x +W    , y -H +a);
                  
    vertex(       x +W    , y +H -a);
    
    bezierVertex( x +W    , y +H -b,
                  x +W -b , y +H,
                  x +W -a , y +H);
                  
    vertex(       x -W +a , y +H );
    
    bezierVertex( x -W +b , y +H,
                  x -W    , y +H -b,
                  x -W    , y +H -a );
                  
    vertex(       x -W    , y -H +a );
    
    bezierVertex( x -W    , y -H +b,
                  x -W +b , y -H,
                  x -W +a , y -H );
  endShape(CLOSE);
}

    static public void main(String args[]) {
        PApplet.main(new String[] { "--bgcolor=#ECE9D8", "MTGui" });
    }
}
