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


boolean MULTITOUCH_MODE = true; 

BasicAnimator createManipulator(Widget target) {
  if (MULTITOUCH_MODE) {
    println("return multitouch anim");
    return new AManipulationAnimator(target);
  } 
  else {
        println("return singletouch anim");
    return new ASingleTouchAnimator(target);
  }
}


class ASingleTouchAnimator extends BasicAnimator {
  ASingleTouchAnimator(Widget target) {
    super(target);
  }


  MTCursor oldCursor = null; 
  boolean dragging = false; 

  void step() {
    if (target.cursors.size() > 0) {
      MTCursor cursor = (MTCursor) target.cursors.get(0); 
      Point c = target.screenPosition; 
      Point t = cursor.getTranslation(); 
      Point p1 = cursor.getPosition(); 
      float d1 = c.distance( p1 );

      if (cursor != oldCursor) {
        oldCursor = cursor; 
        if (d1 < target.getRadius() * target.scaleFactor) {
          dragging = true;
        } 
        else {
          dragging = false; //scaling
        }
      }    

      if (dragging) {
        //drag
        target.center = new Point(target.center.x + t.x, target.center.y + t.y);
      } 
      else {
        //rotate & scale
        Point p2 = new Point(p1.x - t.x, p1.y - t.y); 
        float a1 = atan2(p1.y - c.y, p1.x - c.x); 
        float a2 = atan2(p2.y - c.y, p2.x - c.x); 

        float d2 = c.distance( p2 );
        target.setRotation(target.angle + a1 - a2); 
        target.setScale(target.scaleFactor * (d1 / d2));
      }
    }
  }
}

class AManipulationAnimator extends BasicAnimator {

  //Point targetCenter;

 AManipulationAnimator(Widget target) {
    super(target);
  }

  void step() {
    //recalculate rotation / translation / size
    if (target.cursors.size() == 1) {
      //1 finger case: translate to follow the cursor
      MTCursor cursor = (MTCursor) target.cursors.get(0); 
      Point translation = cursor.getTranslation(); 
      target.center = new Point(target.center.x + translation.x, target.center.y + translation.y); 
      //target.setTranslation(cursor.getTranslation());
    } 
    else if (target.cursors.size() == 2) {
      //2 fingers case: rotate, translate and scale to follow the cursors
      MTCursor c1 = (MTCursor) target.cursors.get(0); 
      MTCursor c2 = (MTCursor) target.cursors.get(1); 

      Point t1 = c1.getTranslation(); 
      Point t2 = c2.getTranslation(); 

      Point p1 = c1.getPosition();       
      Point p2 = c2.getPosition();    

      Point oldP1 = new Point(p1.x - t1.x, p1.y - t1.y);     
      Point oldP2 = new Point(p2.x - t2.x, p2.y - t2.y);

      float d1 = oldP1.distance(oldP2); 
      float d2 = p1.distance(p2);

      Point m1 = new Point((oldP1.x + oldP2.x)/2, (oldP1.y + oldP2.y)/2); 
      Point m2 = new Point((p1.x + p2.x)/2, (p1.y + p2.y)/2); 

      float a1 = atan2(oldP1.y - oldP2.y, oldP1.x - oldP2.x); 
      float a2 = atan2(p1.y - p2.y, p1.x - p2.x); 

      target.setRotation(target.angle + a2 - a1); 
      target.setTranslation(m2.x - m1.x, m2.y - m1.y); 
      target.setScale(target.scaleFactor * (d2 / d1));
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
    if (angle <= PI/2) {
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
    if (angle <= PI/2) {
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
    if (angle <= PI/2) {
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
        rectMode(CORNERS); 
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

