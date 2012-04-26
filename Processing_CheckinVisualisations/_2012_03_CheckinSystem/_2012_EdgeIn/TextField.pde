class TextField extends Button {

  TextField(String initString) {
    super(initString);
  }

  boolean editing = false; 
  TextEditor editor = new TextEditor(this); 
  
  void onTouch() {
    if (!editing) {
      setTextString(""); 
      systemKeyboard.setEditor(editor); 
      systemKeyboard.setVisible(true);
      editing = true; 
    } else {
	  editor.done(); 
      editing = false; 
    }    	
  }
  
  int w = 0; 
  int h = 0;   
  
  void setBoundaries(int w, int h) {
  	this.w = w; 
  	this.h = h; 
  	super.setBoundaries(w, h); 
  }
  
  void drawWidget() {
  	drawBoundingBox(); 
  	
  	if (alpha(textColor) > 0) { // this is weird... I know
	    textFont(getFont());
	    fill(textColor);		
	    textAlign(LEFT, CENTER); 				
	    text(getTextString(), (int)((-w / 2.0) + (h/3.0)), 0);
  	}
  }
  	
}

