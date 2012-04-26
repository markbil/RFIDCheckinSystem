class Label extends Widget {
	
	String textString;
	 
	Label(String textString) {
		super(new Point(0.0, 0.0)); 
		this.textString = textString; 
		textFont(systemFont);
		
		//bb = new java.awt.Polygon(); 
	}
	
	void drawWidget() {		
		textFont(getFont());
		fill(textColor);
		
		int fontSize = getFontSize(); 			

		if (bb == null) {
			bb = new java.awt.Polygon();  
			bb.addPoint((int)(-textWidth(textString)/2.0), (int)(-fontSize/2.0)); 
			bb.addPoint((int)(textWidth(textString)/2.0), (int)(-fontSize/2.0)); 
			bb.addPoint((int)(textWidth(textString)/2.0), (int)(fontSize/2.0)); 
			bb.addPoint((int)(-textWidth(textString)/2.0), (int)(fontSize/2.0)); 
		}
		
		//translate(-textWidth(textString)/2.0, fontSize/2.0); 	
		
		textAlign(CENTER, CENTER); 	
		
		text(textString, 0, 0);
	}
	
	String toString() {
		return "L: " + textString; 
	}
		
}