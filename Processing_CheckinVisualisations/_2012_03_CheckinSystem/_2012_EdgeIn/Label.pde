class Label extends Widget {

  String alignment;
  
  Label(String textString) {
    super(new Point(0.0, 0.0)); 
    setTextMargin(2.0); 
    setTextString(textString);
  }

  Label(String textString, String alignment) {
    super(new Point(0.0, 0.0)); 
    this.alignment = alignment;
    setTextMargin(2.0); 
    setTextString(textString);
  }
  

  void drawWidget() {		
    textFont(getFont());
    fill(textColor);
    int fontSize = getFontSize();
    
    if(alignment == "left")
      textAlign(LEFT, CENTER); 	
    else
      textAlign(CENTER, CENTER);
      
    text(getTextString(), 0, 0);
  }

  String toString() {
    return "L: " + getTextString();
  }
}

