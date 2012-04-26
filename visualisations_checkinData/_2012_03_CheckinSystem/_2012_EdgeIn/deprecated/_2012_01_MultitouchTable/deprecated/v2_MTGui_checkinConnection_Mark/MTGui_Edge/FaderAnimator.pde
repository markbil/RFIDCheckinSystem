color fadeColorOut(color c, int steps) {
	float alphaChannel = 0.0; 
	if (steps != 0) { 
		 alphaChannel = alpha(c); 
		alphaChannel -= (alphaChannel / steps);
	} 
        println("fade out: " + red(c) +":"+  green(c)+":"+ blue(c)+":"+ alphaChannel);  
	return color(red(c), green(c), blue(c), alphaChannel);  
}

color fadeColorIn(color c, int steps) {
	float alphaChannel = 255.0; 
	if (steps != 0) { 
		alphaChannel = alpha(c); 
		alphaChannel += ((255-alphaChannel) / steps);
	} 
        
        println("fade in: " + red(c) +":"+  green(c)+":"+ blue(c)+":"+ alphaChannel);  
	return color(red(c), green(c), blue(c), alphaChannel);  
}

class FaderAnimator extends BasicAnimator {
	FaderAnimator(Widget target) {
		super(target); 
	}
	
	int steps = 0;
	
	void fadeTargetIn() {
		steps = 10; 
	}
	
	void fadeTargetOut() {
		steps = -10; 
	} 
	 
	void step() {
		if (steps < 0) {
			target.fillColor = fadeColorOut(target.fillColor, -steps);
			target.strokeColor = fadeColorOut(target.strokeColor, -steps);
			target.textColor = fadeColorOut(target.textColor, -steps);
			steps++;  
		}
		
		if (steps > 0) {
			target.fillColor = fadeColorIn(target.fillColor, steps);
			target.strokeColor = fadeColorIn(target.strokeColor, steps);
			target.textColor = fadeColorIn(target.textColor, steps);
			steps--; 
		}
			
	}
}

