class BasicAnimator extends BasicEditor {
	
	BasicAnimator(Widget target) {
		super(target); 
		target.addAnimator(this);
	} 
		
	void step() {
	}
}