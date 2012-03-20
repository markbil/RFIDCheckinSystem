class Button extends Widget {
	
	//Label label;
    String buttonText; 
	
	Button(String title) {
		super(new Point(0.0, 0.0)); 
		//label = new Label(title);
        buttonText = title; 
		//bb = new java.awt.Polygon(); 
	}
	
	void drawWidget() {
		fill(fillColor); 
		stroke(strokeColor); 
		
		if (bb == null) {
			bb = new java.awt.Polygon();  
			int fontSize = getFontSize(); 
			bb.addPoint((int)(-textWidth(buttonText)/1.5), (int)(-fontSize/1.5)); 
			bb.addPoint((int)(textWidth(buttonText)/1.5), (int)(-fontSize/1.5)); 
			bb.addPoint((int)(textWidth(buttonText)/1.5), (int)(fontSize/1.5)); 
			bb.addPoint((int)(-textWidth(buttonText)/1.5), (int)(fontSize/1.5)); 		
		}
		
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
			textFont(getFont());
			fill(textColor);		
			//translate(-textWidth(buttonText)/2.0, getFontSize()/2.0); 	
			textAlign(CENTER, CENTER); 				
			text(buttonText, 0, 0);
		}
	}	
}
