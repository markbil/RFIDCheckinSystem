class LabelEditor extends BasicEditor {
	LabelEditor(Label target) {
		super(target); 
	}
	
	void addCharacter(String c) {
		Label l = (Label) target; 
		l.textString += c; 
	}
	
	void deleteCharacter() {
		Label l = (Label) target; 
		l.textString = l.textString.substring(0, l.textString.length() -1); 
	}
}