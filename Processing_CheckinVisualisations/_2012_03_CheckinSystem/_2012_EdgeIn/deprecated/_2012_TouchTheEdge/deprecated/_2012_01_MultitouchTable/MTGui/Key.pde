class Key extends Button {
  Keyboard keyboard; 

  Key(Keyboard keyboard, String title) {
    super(title); 
    this.keyboard = keyboard;
    textColor = color(255); 
    setFont(createFont("Arial", 20)); 
    setFontSize(20); 
  }

  void roundrect(float x, float y, float w, float h, float r) {
    ellipseMode(CORNER);
    strokeCap(SQUARE);    
    stroke(255); 
    noFill(); 
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
    if (keyboard.editor != null) {
      if (getTextString().contains("Delete")) keyboard.editor.deleteCharacter();
      else if (getTextString().contains("Enter")) keyboard.editor.done(); 
      else keyboard.editor.addCharacter(getTextString().toLowerCase());
    }
  }
}

