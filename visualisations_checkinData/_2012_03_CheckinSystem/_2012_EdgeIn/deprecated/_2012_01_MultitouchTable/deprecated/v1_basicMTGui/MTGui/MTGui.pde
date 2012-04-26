GUI gui1; 
GUI gui2; 
GUI gui3; 
GUI gui4; 


color fg1 = color(255,0,0,128); 
color fg2 = color(0,0,255,128); 
color fg = fg1; 

color switchForeground() {
  fg = ((fg == fg1) ? fg2 : fg1);
  return fg;  
}

color randomColor() {
	return color(random(255), random(255), random(255));  
}

	
Keyboard keyboard;
LabelEditor editor; 

void setup(){ 
	size(screen.width, screen.height); 
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
        gui4 = new Floorplan();			 
} 
 
void draw(){ 
	background(200,200,200);
	resetMatrix(); 
	gui1.draw();  
	gui2.draw();  
	gui3.draw();
        gui4.draw();
	//keyboard.moveTo(keyboard.pos.x + random(-0.01,0.01), keyboard.pos.y + random(-0.01,0.01));
  	keyboard.render();
		 
} 



void mouseClicked() {
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

void mouseReleased() {
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
	
	void onTouch() {
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
	
	void step() {
		target.setRotation(target.angle + PI/256); 
	}
}
		
		
	

