int systemFontSize = 48;
color systemFillColor = color(255, 255, 255); 
color systemStrokeColor = color(0,0,0);   
PFont systemFont = createFont( "Times", systemFontSize);
color systemTextColor = color(0,0,0); 


class Widget {
	Point center = new Point(0,0); 
	float scaleFactor = 1.0; 
	float angle = 0.0; 
	boolean rotateFirst = false; 
	boolean translateFirst = false; 
	java.awt.Polygon bb;  
	ArrayList animators = new ArrayList();
	
	//appearance. if null use system defaults
	color fillColor = systemFillColor; 
	color strokeColor = systemStrokeColor; 
	color textColor = systemTextColor; 

	private PFont font = systemFont;
	void setFont(PFont newFont) {
		this.font = newFont; 
		bb = null; 
	}
	PFont getFont() {
		return this.font; 
	}		

	private int fontSize = systemFontSize; 
	void setFontSize(int newSize) {
		this.fontSize = newSize; 
		bb = null; 
	}
	int getFontSize() {
		return fontSize; 
	}
        
	
	Widget(Point center) {
		this.center = center; 
	}
	
	//move GUI relative to center
	void setTranslation(Point distance) {
		setTranslation(distance.x, distance.y); 
	}
	
	void setTranslation(float x, float y) {
		if (!rotateFirst) translateFirst = true; 
		center.x += x; 
		center.y += y; 	
	}
	
	void setRotation(float angle) {
		if (!translateFirst) rotateFirst = true; 
		this.angle = angle;
	}

	void setScale(float scaleFactor) {
		this.scaleFactor = scaleFactor; 
	}
	
	
	void draw() {
		pushMatrix();
		
		if (translateFirst) {
			translate(center.x, center.y); 
			rotate(angle);
		} else {
			rotate(angle);
			translate(center.x, center.y); 
		}			 
		
		scale(scaleFactor);
		
		if (lastTouch != null) {
			if (this.contains((int)lastTouch.x, (int)lastTouch.y)) {
				this.onTouch();
				lastTouch = null;  
			}
		}
		 
		applyAnimations(); 		
		drawWidget();  
		
				
		popMatrix(); 		
	}
	
	void applyAnimations() {
		for (int i = 0; i < animators.size(); i++) {
			BasicAnimator animator = (BasicAnimator) animators.get(i); 
			animator.step(); 
		}
	}
		
	void drawWidget() {
		//ok... this is a bit tricky... to create a new widget you must ALWAYS
		//override the drawWidget function, but if you implement a container your 
		//drawWidget will call the draw() on its children
		println("You MUST override the drawWidget() method from class Widget!!! " + this); 
	}; 
	
	java.awt.Polygon getBoundingBox() {
		//override me for mouse and MT picking to work
		return bb; 
	}
	
	boolean contains(int x, int y) {
		if (bb == null) return false; 
		
		//else
		
		java.awt.Polygon projectedBB = new java.awt.Polygon(); 					
		java.awt.geom.PathIterator i = getBoundingBox().getPathIterator(null); 

		while(i.isDone() == false) { 
			float[] points = new float[6];
			int type = i.currentSegment(points);
			
			if (type == java.awt.geom.PathIterator.SEG_MOVETO || type == java.awt.geom.PathIterator.SEG_LINETO) {
				int px = (int)screenX(points[0], points[1]); 
				int py = (int)screenY(points[0], points[1]);
				projectedBB.addPoint(px, py);
			}
			 
			i.next(); 
		}  
		return projectedBB.contains(x, y); 				
	}
	
	void addAnimator(BasicAnimator animator) {
		animators.add(animator); 
	}
	
	void removeAnimator(BasicAnimator animator) {
		animators.remove(animators.indexOf(animator)); 	
	}
	
	void onTouch() {
		//override this method to catch Mouse and TUIO events
		println("touch: " + this); 
	}
}
