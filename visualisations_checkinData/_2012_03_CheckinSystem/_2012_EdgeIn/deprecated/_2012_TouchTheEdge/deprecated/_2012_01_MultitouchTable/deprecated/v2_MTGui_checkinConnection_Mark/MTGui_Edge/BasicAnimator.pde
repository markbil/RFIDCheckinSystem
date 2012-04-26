class BasicAnimator {
	Widget target; 
	
	BasicAnimator(Widget target) {
		this.target = target;
		target.addAnimator(this); 
	}
	
	void step() {
	}
}