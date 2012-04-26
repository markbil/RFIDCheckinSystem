class PaperSketchApp {
  GUI bluetoothServerGUI;
  GUI buttons; 
  PaperSketchApp(PApplet applet) {
    bluetoothServerGUI = new BluetoothServerGUI(applet);
    buttons = new GUI();
    this.setup(); 
  }


  void setup() {
    // or try MULTITOUCH_MODE = true and place fake touches using keys 1, 2, 3

    Button saveButton = new SaveStateButton("Save state", bluetoothServerGUI); 
    saveButton.setTranslation(0, height / 2 - 50); 
    buttons.addWidget(saveButton); 

    Button backButton = new BackButton("Back", bluetoothServerGUI); 
    backButton.setTranslation(-130, height / 2 - 50); 
    buttons.addWidget(backButton); 

    Button fwdButton = new FwdButton("Fwd", bluetoothServerGUI); 
    fwdButton.setTranslation(130, height / 2 - 50); 
    buttons.addWidget(fwdButton);
  }

  void draw() {
    bluetoothServerGUI.draw();
    buttons.draw();
  }
}


ArrayList stateLists = new ArrayList(); 
int currentState = -1; 

class SaveStateButton extends PaperSketchRoundButton {

  SaveStateButton(String title, GUI gui) {    
    super(title, gui);
  }

  void onTouch() {
    super.onTouch();

    HashMap stateList = new HashMap(); 
    for (int i = 0; i < container.widgets.size(); i++) {
      Widget w = (Widget) container.widgets.get(i); 
      State s = new State();
      s.center = new Point(w.center.x, w.center.y); 
      s.scaleFactor = w.scaleFactor; 
      s.angle = w.angle; 

      stateList.put(w, s);
    }

    stateLists.add(stateList); 
    currentState = stateLists.size() -1;
  }
}

class BackButton extends PaperSketchRoundButton {
  BackButton(String title, GUI gui) {    
    super(title, gui);
  }

  void onTouch() {
    super.onTouch();
    if (currentState > 0) {
      currentState--; 
      HashMap stateList = (HashMap) stateLists.get(currentState); 

      for (int i = 0; i < container.widgets.size(); i++) {
        Widget w = (Widget) container.widgets.get(i); 

        State s = (State) stateList.get(w); 

        if (s == null) {
          s = new State(); 
          s.center = new Point(w.center.x, w.center.y); 
          s.angle = w.angle; 
          s.scaleFactor = 0.0;
        } 
        StateAnimator animator = new StateAnimator(w, 1000, s);
      }
    }
  }
}

class FwdButton extends PaperSketchRoundButton {
  FwdButton(String title, GUI gui) {    
    super(title, gui);
  }

  void onTouch() {
    super.onTouch();
    if (currentState < stateLists.size()-1) {
      currentState++; 
      HashMap stateList = (HashMap) stateLists.get(currentState); 

      for (int i = 0; i < container.widgets.size(); i++) {
        Widget w = (Widget) container.widgets.get(i); 

        State s = (State) stateList.get(w); 

        if (s == null) {
          s = new State(); 
          s.center = new Point(w.center.x, w.center.y); 
          s.angle = w.angle; 
          s.scaleFactor = 0.0;
        } 
        StateAnimator animator = new StateAnimator(w, 1000, s);
      }
    }
  }
}

class PaperSketchRoundButton extends RoundButton {
  GUI container; 
  PaperSketchRoundButton(String title, GUI container) {
    super(title); 
    setFont(createFont("Arial", 18)); 
    textColor = color(0, 0, 255); 
    strokeColor = color(0, 0, 255); 
    setBoundaries(120, 60);
    this.container = container;
  }
}

class State {
  Point center; 
  float scaleFactor; 
  float angle;
} 

class StateAnimator extends BasicAnimator {
  long timestamp; 
  int delay; 
  State finalState; 
  State initialState = new State(); 

  StateAnimator(Widget target, int delay, State finalState) {
    super(target); 
    timestamp = System.currentTimeMillis();
    this.delay = delay; 
    this.finalState = finalState;

    initialState.center = new Point(target.center.x, target.center.y); 
    initialState.angle = target.angle; 
    initialState.scaleFactor = target.scaleFactor;
  }


  void step() {
    long now = System.currentTimeMillis();

    long elapsed = now - timestamp; 
    if (elapsed < delay) {
      float step = (((float)elapsed) / delay) * HALF_PI;
      float mult = sin(step); 

      target.setScale(initialState.scaleFactor + (finalState.scaleFactor - initialState.scaleFactor) * mult); 
      target.setRotation(initialState.angle + (finalState.angle - initialState.angle) * mult); 
      Point p = new Point(0, 0); 
      p.x = initialState.center.x + (finalState.center.x - initialState.center.x) * mult; 
      p.y = initialState.center.y + (finalState.center.y - initialState.center.y) * mult; 
      target.center = p;
    }  
    else {
      //animation done, detach
      target.removeAnimator(this);
      println("Anim done!");
    }
  }
}

