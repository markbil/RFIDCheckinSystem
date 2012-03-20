int systemFontSize = 48;
color systemFillColor = color(255, 255, 255); 
color systemStrokeColor = color(0, 0, 0);   
PFont systemFont = createFont( "Times", systemFontSize);
color systemTextColor = color(0, 0, 0); 

ArrayList allCursors = new ArrayList();

//long visited = 0; 
//long num_cursors = 0; 
//long MAX_CURSORS = 128; 
//MTCursor[] cursors = new MTCursors[MAX_CURSORS]; 
//
//void addNewCursor(MTCursor c) {
//  cursors[num_cursors % MAX_CURSOR] = c; 
//  num_cursors++; 
//}



void cleanupCursors() {
  ArrayList toRemove = new ArrayList();
  //call this on draw() to update the cursors 
  for (int i = allCursors.size()-1; i >=0; i--) {
    MTCursor c = (MTCursor) allCursors.get(i); 

    if (c.visited) {


      if (c.getState() == MTCURSOR_JUST_CREATED) {
        c.setState(MTCURSOR_MOVING);
        
        if (c.target != null ) {
          c.target.addCursor(c); 
          c.target.onTouch();
        }
      }
    } else {
      c.visited = true;
    }

    if (c.getState() == MTCURSOR_JUST_DELETED) {
      if (c.target != null) {
        c.target.removeCursor(c);
      }
      toRemove.add(c);
    }
  }

  for (int i = 0; i < toRemove.size(); i++) {
    allCursors.remove(toRemove.get(i));
  }
}


class Widget {
  Point center = new Point(0, 0); 
  float scaleFactor = 1.0; 
  float angle = 0.0; 
  boolean rotateFirst = false; 
  boolean translateFirst = false; 
  private java.awt.Polygon bb;  
  boolean autoBB = true; 
  GUI container = null; 


  void setContainer(GUI gui) {
    this.container = gui; 
  }
  
  private float textMargin = 1.5; 
  void setTextMargin(float textMargin) {
    this.textMargin = textMargin; 
    if (autoBB) bb = createBoundingBox(textString, textMargin);
  }

  float getTextMargin() {
    return textMargin;
  }

  private String textString = "";
  void setTextString(String textString) {
    this.textString = textString; 
    if (autoBB) bb = createBoundingBox(textString, textMargin);
  }

  String getTextString() {
    return textString;
  }

  java.awt.Polygon getBoundingBox() {
    if (bb == null) {
      bb = new java.awt.Polygon();
    }
    return bb;
  }

  float radius = 0.0; 
  float getRadius() {
    return radius;
  }

  java.awt.Polygon createBoundingBox(String label, float margin) {

    textFont(getFont(), fontSize);
    java.awt.Polygon  bb = new java.awt.Polygon();
    bb.addPoint((int)(-textWidth(label)/margin), (int)(-fontSize/margin)); 
    bb.addPoint((int)( textWidth(label)/margin), (int)(-fontSize/margin)); 
    bb.addPoint((int)( textWidth(label)/margin), (int)( fontSize/margin)); 
    bb.addPoint((int)(-textWidth(label)/margin), (int)( fontSize/margin));

    radius = (textWidth(label)/margin + fontSize/margin) / 4; 
    return bb;
  }


  ArrayList animators = new ArrayList();

  //appearance. if null use system defaults
  color fillColor = systemFillColor; 
  color strokeColor = systemStrokeColor; 
  color textColor = systemTextColor; 

  private PFont font = systemFont;

  void setFont(PFont newFont) {
    this.font = newFont; 
    if (autoBB) bb = createBoundingBox(textString, textMargin);
  }

  PFont getFont() {
    return this.font;
  }		

  private int fontSize = systemFontSize; 
  void setFontSize(int newSize) {
    this.fontSize = newSize; 
    if (autoBB) bb = createBoundingBox(textString, textMargin);
  }
  int getFontSize() {
    return fontSize;
  }


  Widget(Point center) {
    this.center = center;
    font = systemFont;
  }

  Widget(int x, int y) {
    this.center = new Point(x, y);
    font = systemFont;
  }

  //move GUI relative to center
  void setTranslation(Point p) {
    setTranslation(p.x, p.y);
  }

  void setTranslation(float x, float y) {
    //if (!rotateFirst) translateFirst = true; 
    center.x += x; 
    center.y += y;
  }

  void setRotation(float angle) {
    //if (!translateFirst) rotateFirst = true; 
    this.angle = angle;
  }

  void setScale(float scaleFactor) {
    this.scaleFactor = scaleFactor;
  }

  void setBoundaries(int w, int h) {
    bb = new java.awt.Polygon();
    bb.addPoint((int)(-w/2), (int)(-h/2)); 
    bb.addPoint((int)(w/2), (int)(-h/2)); 
    bb.addPoint((int)(w/2), (int)(h/2)); 
    bb.addPoint((int)(-w/2), (int)(h/2));

    radius = (w + h) / 4.0;     
    autoBB = false;
  }


  Point screenPosition = new Point(0.0, 0.0);

  void draw() {
    pushMatrix();
    translate(center.x, center.y); 
    rotate(angle);
    scale(scaleFactor);

    screenPosition.x = screenX(0, 0); 
    screenPosition.y = screenY(0, 0); 

    // foreach new cursor, if this.contains(c) -> bid for target acquisition. the last bid is the good one, so toplevel widgets will get the events. 
    for (int i = 0; i < allCursors.size(); i++) {
      MTCursor c = (MTCursor) allCursors.get(i); 

      if (c.getState() == MTCURSOR_JUST_CREATED) {

        if (this.contains(c.getPosition())) {
          c.setTarget(this);
        }
      }
    }


    applyAnimations(); 		
    drawWidget();  


    popMatrix();
  }

  void applyAnimations() {
    for (int i = 0; i < animators.size(); i++) {
      BasicAnimator animator = (BasicAnimator) animators.get(i); 
      animator.step();
    }
  }

  void drawWidget() {
    //ok... this is a bit tricky... to create a new widget you must ALWAYS
    //override the drawWidget function, but if you implement a container your 
    //drawWidget will call the draw() on its children
    println("You MUST override the drawWidget() method from class Widget!!! " + this);
  }; 


  boolean contains(Point p) {
    return contains((int)p.x, (int)p.y);
  }

  boolean contains(int x, int y) {
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

  ArrayList cursors = new ArrayList();    

  void addCursor(MTCursor c) {
    cursors.add(c);
    c.savePosition();
  }

  void removeCursor(MTCursor c) {
    int position = cursors.indexOf(c); 
    if (position >= 0) {
      cursors.remove(position);
    }
  }


  void addAnimator(BasicAnimator animator) {
    animators.add(animator);
  }

  void removeAnimator(BasicAnimator animator) {
    animators.remove(animators.indexOf(animator));
  }

  void onTouch() {
    //override this method to catch Mouse and TUIO events
    if (container != null) {
      int index = container.widgets.indexOf(this); 
      container.widgets.remove(index); 
      container.widgets.add(this); 
    }
    println("touch: " + this);
  }
}

