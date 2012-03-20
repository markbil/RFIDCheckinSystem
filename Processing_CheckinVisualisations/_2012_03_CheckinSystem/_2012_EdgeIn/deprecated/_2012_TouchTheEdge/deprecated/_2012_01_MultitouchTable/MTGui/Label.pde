class Label extends Widget {

  Label(String textString) {
    super(new Point(0.0, 0.0)); 
    setTextMargin(2.0); 
    setTextString(textString);
  }

  void drawWidget() {		
    textFont(getFont());
    fill(textColor);
    int fontSize = getFontSize();
    textAlign(CENTER, CENTER); 	
    text(getTextString(), 0, 0);
  }

  String toString() {
    return "L: " + getTextString();
  }
}

