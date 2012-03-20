class Button extends Widget {

  Button(String title) {
    super(new Point(0.0, 0.0)); 
    setTextMargin(1.5); 
    setTextString(title);
  }

  void drawBoundingBox() {
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

  void drawText() {
    if (alpha(textColor) > 0) { // this is weird... I know
      textFont(getFont());
      fill(textColor);		
      textAlign(CENTER, CENTER); 				
      text(getTextString(), 0, 0);
    }
  }

  void drawWidget() {
    drawBoundingBox(); 
    drawText();
  }
}

class RoundButton extends Button {
  long lastTouch;
  int DELAY = 400; 

  RoundButton(String title) {
    super(title); 
    textColor = color(255); 
    setFont(createFont("Arial", 20)); 
    setFontSize(20); 
    lastTouch = System.currentTimeMillis() - DELAY;
  }

  void roundrect(float x, float y, float w, float h, float r) {
    ellipseMode(CORNER);
    strokeCap(SQUARE);
    long t = System.currentTimeMillis() - lastTouch; 
    color c = color(255, min(255*(t/DELAY), 255), min(255*(t/DELAY), 255)); 
    //    stroke(c);
    //    textColor = c; 
    if (t > DELAY) {
      smooth(); 
      noFill(); 
      stroke(strokeColor);
    } 
    else {
      noSmooth(); 
      fill(c);
      noStroke(); 
      rectMode(CORNERS);  
      rect(x, y+r, x+w, y+h-r);
      rect(x+r, y, x+w-r, y+h);
    }
    arc(x, y, 2*r, 2*r, radians(180.0), radians(270.0));
    arc(x+w-2*r, y, 2*r, 2*r, radians(270.0), radians(360.0));
    arc(x, y+h-2*r, 2*r, 2*r, radians(90.0), radians(180.0));
    arc(x+w-2*r, y+h-2*r, 2*r, 2*r, radians(0.0), radians(90.0));
    line(x+r, y, x+w-r, y);
    line(x+w, y+r, x+w, y+h-r);
    line(x+w-r, y+h, x+r, y+h);
    line(x, y+h-r, x, y+r);
  }


  void drawWidget() {
    java.awt.Rectangle r = getBoundingBox().getBounds(); 
    roundrect((float)r.getX(), (float)r.getY(), (float)r.getWidth(), (float)r.getHeight(), 10); 
    drawText();
  }

  void onTouch() {
    lastTouch = System.currentTimeMillis();
  }
}
