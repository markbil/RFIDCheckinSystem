class BasicAnimator extends BasicEditor {

  BasicAnimator(Widget target) {
    super(target); 
    target.addAnimator(this);
  } 

  void step() {
  }
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
}


class ManipulationAnimator extends BasicAnimator {

  //Point targetCenter;
  
  ManipulationAnimator(Widget target) {
    super(target);
    //targetCenter = target.center; 
  }
  
  void step() {
    //recalculate rotation / translation / size
    if (target.cursors.size() == 1) {
      //1 finger case: translate to follow the cursor
      MTCursor cursor = (MTCursor) target.cursors.get(0); 
      Point translaton = cursor.getTranslation(); 
      target.center = new Point(target.center.x + translaton.x, target.center.y + translaton.y); 
      //target.setTranslation(cursor.getTranslation());
    } 
    else if (target.cursors.size() == 2) {
      //2 fingers case: rotate, translate and scale to follow the cursors
    } 
    else if (target.cursors.size() > 2) {
      //3+ fingers case: translate to follow the baricenter of the cursors, scale to match the shape of the hand
    }
  }
}


class TwisterAnimator extends BasicAnimator {
 TwisterAnimator(GUI target) {
   super(target);
 }

 float angle = 0.0;
 void step() {
   target.setRotation(angle);
   angle += PI/1000;
 }
}

class ScaleAnimator extends BasicAnimator {
 ScaleAnimator(GUI target) {
   super(target);
 }

 float angle = 0.0;
 void step() {
   target.setScale(cos(angle) * cos(angle));
   angle += PI/200;
 }
}

class GUIScaleOutAnimator extends BasicAnimator {
 GUIScaleOutAnimator(GUI target) {
   super(target);
 }

 float angle = 0.0;
 void step() {
   target.setScale(cos(angle) * cos(angle));
   if(angle <= PI/2){
     angle += PI/20;
   }
 }
}

class GUIScaleInAnimator extends BasicAnimator {
 GUIScaleInAnimator(GUI target) {
   super(target);
 }

 float angle = 0.0;
 void step() {
   target.setScale(sin(angle) * sin(angle));
   if(angle <= PI/2){
     angle += PI/20;
   }
 }
}

class GUIFadeOutAnimator extends BasicAnimator {
 int step = 255;
 float angle = 0.0;
 GUIFadeOutAnimator(GUI target) {
   super(target);
   Widget w = new Widget(0, 0) {
     void drawWidget() {
       fill(systemBackgroundColor, step);
       noStroke();
       rect(-width, -height, width*2, height*2);
     }
   };
   target.addWidget(w);
 }

 void step() {
   step = (int) (255 * sin(angle) * sin(angle));
   if (angle <= PI/2){
     angle += PI/50;
   }
 }
 
 public void setFaderInvisible() {
   step = 0; 
  }
 
}

class GUIFaderAnimator extends BasicAnimator {
 int step = 255;
 float angle = 0.0;
 GUIFaderAnimator(GUI target) {
   super(target);
   Widget w = new Widget(0, 0) {
     void drawWidget() {
       fill(systemBackgroundColor, step);
       noStroke();
       rect(-width, -height, width*2, height*2);
     }
   };
   target.addWidget(w);
 }

 void step() {
   step = (int) (255 * sin(angle) * sin(angle));
   angle += PI/200;
 }
 
 public void setFaderInvisible() {
   step = 0; 
  }
 
}

