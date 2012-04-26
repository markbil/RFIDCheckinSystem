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


FakeCursor f1 = null; 
FakeCursor f2 = null; 
FakeCursor f3 = null; 

void keyPressed() {
  switch(key) {
    case '1':
     if (f1 == null) f1 = new FakeCursor(); 
     else {
       f1.setState(MTCURSOR_JUST_DELETED);
       f1 = null; 
     }
     break; 
    case '2': 
     if (f2 == null) f2 = new FakeCursor(); 
     else {
       f2.setState(MTCURSOR_JUST_DELETED);
       f2 = null; 
     }
     break; 
    case '3': 
     if (f3 == null) f3 = new FakeCursor(); 
     else {
       f3.setState(MTCURSOR_JUST_DELETED);
       f3 = null; 
     }
     break; 
  }
}


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
void addTuioObject(TuioObject tobj) {}

// called when an object is removed from the scene
void removeTuioObject(TuioObject tobj) {}

// called when an object is moved
void updateTuioObject (TuioObject tobj) {}

// called when a cursor is added to the scene
void addTuioCursor(TuioCursor tcur) {
  new MTCursor(tcur);
}

// called when a cursor is moved
void updateTuioCursor (TuioCursor tcur) {}

// called when a cursor is removed from the scene
void removeTuioCursor(TuioCursor tcur) {}

// called after each message bundle
// representing the end of an image frame
void refresh(TuioTime bundleTime) { }

void drawTuioCursors() {
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
  boolean visited = false;

  TuioCursor tuioCursor; 
  Widget target = null; 
  Point savedPosition = null;

  MTCursor(TuioCursor tc) {  
    this.tuioCursor = tc;
    this.state = MTCURSOR_JUST_CREATED;
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
     return color(255, 0,0, 128); 
   }

}

class FakeCursor extends MTCursor {

  float x, y; 
  FakeCursor() {
    super(null);
    x = mouseX; 
    y = mouseY; 
  }

  int getState() {
    return state;
  }

  Point getTranslation() {
    return new Point(0.0, 0.0); 
  }

  Point getPosition() {
    return new Point(x, y);
  }
  
  color getColor() {
     return color(255, 0, 255, 128); 
   }

}


