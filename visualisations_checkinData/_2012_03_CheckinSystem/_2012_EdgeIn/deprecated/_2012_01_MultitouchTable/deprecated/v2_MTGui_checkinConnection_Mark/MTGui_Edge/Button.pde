class Button extends Widget {
	
	//Label label;
    String buttonText; 
	
	Button(String title) {
		super(new Point(0.0, 0.0)); 
		//label = new Label(title);
                buttonText = title; 
		bb = new java.awt.Polygon(); 
		bb.addPoint((int)(-textWidth(buttonText)/1.5), (int)(-systemFontSize/1.5)); 
		bb.addPoint((int)(textWidth(buttonText)/1.5), (int)(-systemFontSize/1.5)); 
		bb.addPoint((int)(textWidth(buttonText)/1.5), (int)(systemFontSize/1.5)); 
		bb.addPoint((int)(-textWidth(buttonText)/1.5), (int)(systemFontSize/1.5)); 		
	}
	
	void drawWidget() {
		fill(fillColor); 
		stroke(strokeColor); 
		
		beginShape();
			java.awt.geom.PathIterator i = bb.getPathIterator(null); 
			while(i.isDone() == false) {
				float[] points = new float[6];
				int type = i.currentSegment(points);
				if (type == java.awt.geom.PathIterator.SEG_MOVETO || type == java.awt.geom.PathIterator.SEG_LINETO) {
					vertex(points[0], points[1]); 
				} 
				i.next(); 
			}  
		endShape(CLOSE);
		
		if (alpha(textColor) > 0) { // this is weird... I know
			textFont(font);
			fill(textColor);		
			translate(-textWidth(buttonText)/2.0, systemFontSize/2.0); 				
			text(buttonText, 0, 0);
		}
	}	
}
