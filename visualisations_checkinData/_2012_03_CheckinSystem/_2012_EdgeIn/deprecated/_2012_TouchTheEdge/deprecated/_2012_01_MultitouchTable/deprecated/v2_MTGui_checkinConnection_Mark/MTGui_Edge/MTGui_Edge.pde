GUI gui1; 
GUI gui2; 
GUI gui3; 
GUI floorplan;
Button checkinButton;
PApplet pa;

final String DOMAIN = "meetmee.javaprovider.net";
final String ADDR = "/php/edge_multitouch/checkin_submit.php";
//final String DOMAIN = "localhost";
//final String ADDR = "/edge_multitouch/checkin_submit.php";


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
	


void setup(){ 
	size(1024, 768); 
        pa = this;
	
	//how to define a touch callback on the fly...
//	Label l1 = new Label("Hello World") {
//		public void onTouch() {
//			textColor = randomColor();
//		}
//	}; 	
//	l1.addAnimator(new TwisterAnimator(l1)); 

	gui1 = new GUI(); 
//	gui1.addWidget(l1); 	
        floorplan = new Floorplan();

        checkinButton = new Button("Checkin!"){ 
          public void onTouch(){
              println("touch: " + this);
              String location = ((Floorplan)floorplan).getSelectedFloorplanButton();
              Connection c = new Connection(pa, DOMAIN, ADDR);
              c.sendCheckin(location, "I am in window bay 1213");         
              
          };
        };
        checkinButton.setTranslation(600, 700);		 
} 
 
void draw(){ 
	background(200,200,200);
	
	gui1.draw();  
//	gui2.draw();  
//	gui3.draw();
        floorplan.draw();
        checkinButton.draw();
} 

void mouseClicked() {
	lastTouch = new Point(mouseX, mouseY); 
}

void mouseReleased() {
}

