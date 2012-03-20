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

