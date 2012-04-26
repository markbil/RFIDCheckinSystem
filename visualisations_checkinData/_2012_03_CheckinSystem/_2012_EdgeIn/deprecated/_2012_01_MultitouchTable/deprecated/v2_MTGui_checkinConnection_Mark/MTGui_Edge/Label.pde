class Label extends Widget {
	
	String textString;
	 
	Label(String textString) {
		super(new Point(0.0, 0.0)); 
		this.textString = textString; 
		textFont(systemFont);
		
		bb = new java.awt.Polygon(); 
		bb.addPoint((int)(-textWidth(textString)/2.0), (int)(-systemFontSize/2.0)); 
		bb.addPoint((int)(textWidth(textString)/2.0), (int)(-systemFontSize/2.0)); 
		bb.addPoint((int)(textWidth(textString)/2.0), (int)(systemFontSize/2.0)); 
		bb.addPoint((int)(-textWidth(textString)/2.0), (int)(systemFontSize/2.0)); 
	}
	
	void drawWidget() {		
		textFont(font);
		fill(textColor);
		
		translate(-textWidth(textString)/2.0, systemFontSize/2.0); 		
		
		text(textString, 0, 0);
	}
	
	String toString() {
		return "L: " + textString; 
	}
		
}