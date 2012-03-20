class Key extends RoundButton {
  Keyboard keyboard; 

  Key(Keyboard keyboard, String title) {
    super(title); 
    this.keyboard = keyboard;
  }

  void onTouch() {
    super.onTouch(); 
    if (keyboard.editor != null) {
      if (getTextString().contains("Delete")) keyboard.editor.deleteCharacter();
      else if (getTextString().contains("Enter")) keyboard.editor.done(); 
      else keyboard.editor.addCharacter(getTextString().toLowerCase());
    }
  }
}

