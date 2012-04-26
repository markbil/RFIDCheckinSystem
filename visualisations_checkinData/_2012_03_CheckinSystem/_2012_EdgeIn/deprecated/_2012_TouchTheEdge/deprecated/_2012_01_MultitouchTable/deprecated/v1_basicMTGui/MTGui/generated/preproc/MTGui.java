import processing.core.*; 
import processing.xml.*; 

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
}

class Button extends Widget {
	
	//Label label;
    String buttonText; 
	
	Button(String title) {
		super(new Point(0.0f, 0.0f)); 
		//label = new Label(title);
        buttonText = title; 
		//bb = new java.awt.Polygon(); 
	}
	
	public void drawWidget() {
		fill(fillColor); 
		stroke(strokeColor); 
		
		if (bb == null) {
			bb = new java.awt.Polygon();  
			int fontSize = getFontSize(); 
			bb.addPoint((int)(-textWidth(buttonText)/1.5f), (int)(-fontSize/1.5f)); 
			bb.addPoint((int)(textWidth(buttonText)/1.5f), (int)(-fontSize/1.5f)); 
			bb.addPoint((int)(textWidth(buttonText)/1.5f), (int)(fontSize/1.5f)); 
			bb.addPoint((int)(-textWidth(buttonText)/1.5f), (int)(fontSize/1.5f)); 		
		}
		
		beginShape();
			java.awt.geom.PathIterator i = bb.getPathIterator(null); 
			while(i.isDone() == false) {
				float[] points = new float[6];
				int type = i.currentSegment(points);
				if (type == java.awt.geom.PathIterator.SEG_MOVETO || type == java.awt.geom.PathIterator.SEG_LINETO) {
					vertex(points[0], points[1]); 
				} 
				i.next(); 
			}  
		endShape(CLOSE);
		
		if (alpha(textColor) > 0) { // this is weird... I know
			textFont(getFont());
			fill(textColor);		
			//translate(-textWidth(buttonText)/2.0, getFontSize()/2.0); 	
			textAlign(CENTER, CENTER); 				
			text(buttonText, 0, 0);
		}
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

class Keyboard{
  Key[] keys;        // Array of keys 
  
  PVector pos;       // center of the keyboard. Replace the kCenter of the Tiper3MapMaker. So here this points is, the keyboard will be draw arround (using polar geometry) 
  float north = 0;   // this is the radient of rotation of the keyboard
  
  boolean border;    // this is came from the Tiper3MapMaker, and is usefull for preventing opening empty keyboard maps
  float   borderWidth;  // This is the width and height of the keyboard
  float   borderHeight; // It wirted on the first line of the .kbd file 
  
  PFont font;
    
  //----------------------------------- CONSTRUCTOR FUNTIONS
  Keyboard(int _x, int _y){
    pos = new PVector(_x,_y);                     // Set the initial position of the keyboard
    
    font = createFont("Arial",12);                // Load the font
    String[] data = loadStrings("map.kbd");       // Load the map of the keys made by Tiper3MapMaker 
    
    if ( data.length > 1 ){                       // Populate the information from the keyboard map file to the keys variable
      keys = new Key[data.length-1];              // Set the lenght of total key parameters
    
                                                  // The first line of the file is for the border the center point and width & height
      String[] borderValues = split(data[0],","); // of the keyboard. This is usefull only to this program.
      
      borderWidth = PApplet.parseFloat(borderValues[2]);       // the fist to borderValues are the ones of kCenter used by Tiper3MapMaker. Here is useless      
      borderHeight = PApplet.parseFloat(borderValues[3]);
      border = true;                              
    
      for(int i = 0; i < keys.length; i++){       // Here start reading and extracting the rest of the keys parameters (remember that the fist line only have the info about the keyboard center and width&height)
        String[] values = split(data[i+1],",");   // Extract the content between , 
        float rad = PApplet.parseFloat(values[1]);             // the first value is the Letter or Key, the second one is radio from the center
        float ang   = PApplet.parseFloat(values[2]);           // the 3th is the angle on radians from the center (this last to parameters are the ones that let the keabord be redraw in any angle and continue working)
        int w  = PApplet.parseInt(values[3]);                  // the 4th and 5th are the with and height of each key. 
        int h   = PApplet.parseInt(values[4]);
        keys[i] = new Key(pos, values[0], rad, ang, w, h); // Finaly enter the information in to the "keys" array
      }
    } else {                                      // If the file is empty or just the header with the border.
      keys = new Key[0];                          //  No keys are load
      border = false;                             //  Nothing is draw
    }                        
    
  }
  
  // Rotate the keyBoard
  public void rot(float _ang){
    north = _ang;
    update();
  }
  
  // Move the central point in order to re-draw the keyboard in another place
  public void moveTo(float _x, float _y){
    pos = new PVector(_x, _y);
    update();
  }
  
  //Update the information of the position and rotation of each key (just in the array of keys, NOT on the file... so this is temporal)
  public void update(){
    for(int i = 0; i< keys.length; i++){
      keys[i].calcPos(pos,north);
    }
  }
  
  // Draw the keyBoard
  public void render(){
    //First draw the border of the keyboard. For that will push, translate, rotate and pop the Matrix.
    pushMatrix();
      translate(pos.x,pos.y);
      rotate(north);
      rBox(0, 0, (int)borderWidth, (int)borderHeight, color(0), color(255), false);
    popMatrix();
    // After that draw all the keys. If the keyboard is moved or rotated each one of the keys are previusly updated to on each angle and position
    for(int i = 0; i < keys.length; i++) keys[i].render();
  }
  
  
  // ----------------------------------------------------------------------------- Events
  // Check if the x and y coordinates are over the keyboard
  public boolean isOver(int _x, int _y){
    PVector _loc = new PVector(_x,_y); 
    if (pos.dist(_loc) <= borderWidth/2) return true;
    else return false;
  }
  
  // Check if the vector coordinates is over the keyboard
  public boolean isOver(PVector _loc){
    if (pos.dist(_loc) <= borderWidth/2) return true;
    else return false;
  }
  
  // Check every key if certain x and y position is over it... and return the letter of each one  
  public String check(int _x, int _y){    // (Note that if you change the .kbd file you can writte words insted of just put the letter in order to make complex combinations like SPACE, SHIFT, etc)
    String pressed = "";           // If nothing is press a nothing is return
    
    for(int i = 0; i< keys.length; i++){
      if (keys[i].isOver(_x,_y)){
        keys[i].bg = color(255);
        keys[i].fg = color(0);
        pressed = keys[i].s; 
      } else{
        keys[i].bg = color(0);
        keys[i].fg = color(255);
      }
    }
    return pressed;
  }
}



class Label extends Widget {
	
	String textString;
	 
	Label(String textString) {
		super(new Point(0.0f, 0.0f)); 
		this.textString = textString; 
		textFont(systemFont);
		
		//bb = new java.awt.Polygon(); 
	}
	
	public void drawWidget() {		
		textFont(getFont());
		fill(textColor);
		
		int fontSize = getFontSize(); 			

		if (bb == null) {
			bb = new java.awt.Polygon();  
			bb.addPoint((int)(-textWidth(textString)/2.0f), (int)(-fontSize/2.0f)); 
			bb.addPoint((int)(textWidth(textString)/2.0f), (int)(-fontSize/2.0f)); 
			bb.addPoint((int)(textWidth(textString)/2.0f), (int)(fontSize/2.0f)); 
			bb.addPoint((int)(-textWidth(textString)/2.0f), (int)(fontSize/2.0f)); 
		}
		
		//translate(-textWidth(textString)/2.0, fontSize/2.0); 	
		
		textAlign(CENTER, CENTER); 	
		
		text(textString, 0, 0);
	}
	
	public String toString() {
		return "L: " + textString; 
	}
		
}
class LabelEditor extends BasicEditor {
	LabelEditor(Label target) {
		super(target); 
	}
	
	public void addCharacter(String c) {
		Label l = (Label) target; 
		l.textString += c; 
	}
	
	public void deleteCharacter() {
		Label l = (Label) target; 
		l.textString = l.textString.substring(0, l.textString.length() -1); 
	}
}
GUI gui1; 
GUI gui2; 
GUI gui3; 

int fg1 = color(255,0,0,128); 
int fg2 = color(0,0,255,128); 
int fg = fg1; 

public int switchForeground() {
  fg = ((fg == fg1) ? fg2 : fg1);
  return fg;  
}

public int randomColor() {
	return color(random(255), random(255), random(255));  
}

	
Keyboard keyboard;
LabelEditor editor; 

public void setup(){ 
	size(1024, 768); 
    keyboard = new Keyboard(width/2,height/2);
        
	
	//how to define a touch callback on the fly...
	Label l1 = new Label("Hello World") {
		public void onTouch() {
			textColor = randomColor();
		}
	}; 
	l1.setFont(createFont("Arial", 48)); 
	l1.addAnimator(new TwisterAnimator(l1));
	editor = new LabelEditor(l1); 

	gui1 = new GUI(new Point(200, 200)); 
	gui1.addWidget(l1); 	
	
	gui2 = new LabelMatrix(); 
	gui3 = new Buttons(500, 500); 		 
} 
 
public void draw(){ 
	background(200,200,200);
	resetMatrix(); 
	gui1.draw();  
	gui2.draw();  
	gui3.draw();
	//keyboard.moveTo(keyboard.pos.x + random(-0.01,0.01), keyboard.pos.y + random(-0.01,0.01));
  	keyboard.render();
		 
} 



public void mouseClicked() {
	lastTouch = new Point(mouseX, mouseY); 
	
	if ( keyboard.isOver(mouseX,mouseY) ){
    	String pressed = keyboard.check(mouseX,mouseY);
    	if (!pressed.equals("")) {    		
    		if (pressed.contains("Delete")) {
    			editor.deleteCharacter(); 
    		} else {
    			editor.addCharacter(pressed.toLowerCase()); 
    		}
    	}
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
		} else { 
			fader.fadeTargetIn();
			b1IsVisible = true;
		} 
	}
}


class Buttons extends GUI {

	Buttons(int a, int b) {
              super (new Point(a , b)); 
		Button1 b1; 
		Button2 b2; 
		
		
	    b1 = new Button1("Button 1"); 
		b1.setTranslation(-400, -100); 
		
	    b2 = new Button2("Button 2");
	    b1.target = b2; 
	     
		b2.setTranslation(400, 100);
		b2.setRotation(PI/8);
		b2.fader = new FaderAnimator(b1);
		 
		 
		 
		addWidget(b1); 
		addWidget(b2); 		
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
		
int systemFontSize = 48;
int systemFillColor = color(255, 255, 255); 
int systemStrokeColor = color(0,0,0);   
PFont systemFont = createFont( "Times", systemFontSize);
int systemTextColor = color(0,0,0); 


class Widget {
	Point center = new Point(0,0); 
	float scaleFactor = 1.0f; 
	float angle = 0.0f; 
	boolean rotateFirst = false; 
	boolean translateFirst = false; 
	java.awt.Polygon bb;  
	ArrayList animators = new ArrayList();
	
	//appearance. if null use system defaults
	int fillColor = systemFillColor; 
	int strokeColor = systemStrokeColor; 
	int textColor = systemTextColor; 

	private PFont font = systemFont;
	public void setFont(PFont newFont) {
		this.font = newFont; 
		bb = null; 
	}
	public PFont getFont() {
		return this.font; 
	}		

	private int fontSize = systemFontSize; 
	public void setFontSize(int newSize) {
		this.size = size; 
		bb = null; 
	}
	public int getFontSize() {
		return fontSize; 
	}
        
	
	Widget(Point center) {
		this.center = center; 
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
	
	
	public void draw() {
		pushMatrix();
		
		if (translateFirst) {
			translate(center.x, center.y); 
			rotate(angle);
		} else {
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
	
	public java.awt.Polygon getBoundingBox() {
		//override me for mouse and MT picking to work
		return bb; 
	}
	
	public boolean contains(int x, int y) {
		if (bb == null) return false; 
		
		//else
		
		java.awt.Polygon projectedBB = new java.awt.Polygon(); 					
		java.awt.geom.PathIterator i = getBoundingBox().getPathIterator(null); 

		while(i.isDone() == false) { 
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
