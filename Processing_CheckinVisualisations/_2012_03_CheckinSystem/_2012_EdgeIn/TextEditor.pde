class TextEditor extends BasicEditor {
  TextEditor(TextField target) {
    super(target);
  }

  void addCharacter(String c) {
    target.setTextString(target.getTextString() + c);
  }

  void deleteCharacter() {
  	if (target.getTextString().length() > 0) {
	    target.setTextString(target.getTextString().substring(0, target.getTextString().length() -1));
  	}
  }
  
  void done() {
  	systemKeyboard.setEditor(null); 
  	//systemKeyboard.setVisible(false); 
  	((TextField)target).editing = false; 
  }
}

