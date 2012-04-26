
color cursorColors[] = { 
  color(0, 0, 128, 128), 
  color(0, 128, 0, 128), 
  color(0, 128, 128, 128), 
  color(128, 0, 0, 128), 
  color(128, 0, 128, 128), 
  color(128, 128, 0, 128)
}; 


TuioProcessing tuioClient;
void initTuioHandler() {
  this.tuioClient = new TuioProcessing(this);
} 

//TUIO Handlers
void addTuioObject(TuioObject tobj) {
  //println("add object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle());
}

// called when an object is removed from the scene
void removeTuioObject(TuioObject tobj) {
  //println("remove object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+")");
}

// called when an object is moved
void updateTuioObject (TuioObject tobj) {
  //println("update object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle()  +" "+tobj.getMotionSpeed()+" "+tobj.getRotationSpeed()+" "+tobj.getMotionAccel()+" "+tobj.getRotationAccel());
}

// called when a cursor is added to the scene
void addTuioCursor(TuioCursor tcur) {
  //println("add cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY());
  allCursors.add(new MTCursor(tcur));
}

// called when a cursor is moved
void updateTuioCursor (TuioCursor tcur) {
  //println("update cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY() +" "+tcur.getMotionSpeed()+" "+tcur.getMotionAccel());
}

// called when a cursor is removed from the scene
void removeTuioCursor(TuioCursor tcur) {
  //println("remove cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+")");
}

// called after each message bundle
// representing the end of an image frame
void refresh(TuioTime bundleTime) { 
  //redraw();
}

void drawTuioCursors() {
  //  Vector tuioCursorList = tuioClient.getTuioCursors();
  //  for (int i=0; i < tuioCursorList.size(); i++) {
  //    TuioCursor tcur = (TuioCursor) tuioCursorList.elementAt(i);
  //    Vector pointList = tcur.getPath();
  //    color c = cursorColors[tcur.getCursorID() % 6]; 
  //    stroke(c);
  //    fill(c);
  //    ellipse( tcur.getScreenX(width), tcur.getScreenY(height), 60, 60);
  //  }
  for (int i = 0; i < allCursors.size(); i++) {
    MTCursor cursor =  (MTCursor) allCursors.get(i); 
    color c = cursor.getColor(); 
    stroke(c);
    fill(c);
    ellipseMode(CENTER);
    ellipse(cursor.getPosition().x, cursor.getPosition().y, 60, 60);
  }
}

int MTCURSOR_JUST_CREATED = TuioCursor.TUIO_ADDED; 
int MTCURSOR_JUST_DELETED = TuioCursor.TUIO_REMOVED; 
int MTCURSOR_MOVING = 2;


class MTCursor {

  int state = MTCURSOR_JUST_CREATED; 

  TuioCursor tuioCursor; 
  Widget target = null; 
  Point savedPosition = null;
  long timestamp;  

  MTCursor(TuioCursor tc) {  
    this.tuioCursor = tc;
    this.timestamp = System.currentTimeMillis();
    allCursors.add(this);
  }

  void setState(int state) {
    this.state = state;
  }

  int getState() {
    if (tuioCursor.getTuioState() == TuioCursor.TUIO_REMOVED) {
      state = MTCURSOR_JUST_DELETED;
    }
    return state;
  }

  void setTarget(Widget target) {
    this.target = target;
  }

  void savePosition() {
    savedPosition = getPosition();
  }

  Point getTranslation() {
    float dx = tuioCursor.getScreenX(width) - savedPosition.x; 
    float dy = tuioCursor.getScreenY(height) - savedPosition.y;
    savedPosition = getPosition(); 
    return new Point(dx, dy);
  }

  Point getPosition() {
    return new Point(tuioCursor.getScreenX(width), tuioCursor.getScreenY(height));
  }
  
  color getColor() {
     return cursorColors[tuioCursor.getCursorID() % 6]; 
  }
}

class MouseCursor extends MTCursor {

  MouseCursor() {
    super(null);
  }

  int getState() {
    return state;
  }

  Point getTranslation() {
    float dx = mouseX - savedPosition.x; 
    float dy = mouseY - savedPosition.y;
    savedPosition =  getPosition(); 
    return new Point(dx, dy); 
  }

  Point getPosition() {
    return new Point(mouseX, mouseY);
  }
  
  color getColor() {
     return color(255, 0,0); 
   }

}

