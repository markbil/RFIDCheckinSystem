Point lastTouch = null; 

class GUI extends Widget {

  Point center;  
  float scale = 1.0; 
  float angle = 0.0; 
  ArrayList widgets = new ArrayList(); 
  boolean drawCross = false; 

  //create a new GUI centered on the screen; 
  GUI() {
    super(new Point(width / 2.0, height / 2.0));
  }



  //create a new GUI centered at absolute coordinates x,y
  GUI(Point center) {
    super(center);
  }

  void drawWidget() {
    if (drawCross) {
      stroke(0, 0, 0); 
      line(-100, 0, 100, 0);
      line(0, -100, 0, 100);
    }

    for (int i = 0; i < widgets.size(); i++) {
      Widget w = (Widget) widgets.get(i); 
      w.draw();
    }
  }


  //add a child widget  to this GUI
  void addWidget(Widget child) {
    widgets.add(child);
  }

  void removeWidget(Widget child) {
    widgets.remove(widgets.indexOf(child));
  }
}


