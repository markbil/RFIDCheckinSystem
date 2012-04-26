Keyboard systemKeyboard; 

class Keyboard extends GUI {
  Key[] keys;        // Array of keys 

    PVector pos;       // center of the keyboard. Replace the kCenter of the Tiper3MapMaker. So here this points is, the keyboard will be draw arround (using polar geometry) 
  float north = 0;   // this is the radient of rotation of the keyboard

  boolean border;    // this is came from the Tiper3MapMaker, and is usefull for preventing opening empty keyboard maps
  float   borderWidth;  // This is the width and height of the keyboard
  float   borderHeight; // It wirted on the first line of the .kbd file 

  PFont font;

  //----------------------------------- CONSTRUCTOR FUNTIONS  
  Keyboard(int _x, int _y) {
    super(new Point(_x, _y)); 
    pos = new PVector(_x, _y);                     // Set the initial position of the keyboard

    font = createFont("Arial", 12);                // Load the font
    String[] data = loadStrings("map.kbd");       // Load the map of the keys made by Tiper3MapMaker 

    if ( data.length > 1 ) {                       // Populate the information from the keyboard map file to the keys variable
      keys = new Key[data.length-1];              // Set the lenght of total key parameters

      // The first line of the file is for the border the center point and width & height
      String[] borderValues = split(data[0], ","); // of the keyboard. This is usefull only to this program.

      borderWidth = float(borderValues[2]);       // the fist to borderValues are the ones of kCenter used by Tiper3MapMaker. Here is useless      
      borderHeight = float(borderValues[3]);
      border = true;                              

      setBoundaries((int)borderWidth, (int)borderHeight); 


      for (int i = 0; i < keys.length; i++) {       // Here start reading and extracting the rest of the keys parameters (remember that the fist line only have the info about the keyboard center and width&height)
        String[] values = split(data[i+1], ",");   // Extract the content between , 
        float rad = float(values[1]);             // the first value is the Letter or Key, the second one is radio from the center
        float ang   = float(values[2]);           // the 3th is the angle on radians from the center (this last to parameters are the ones that let the keabord be redraw in any angle and continue working)
        int w  = int(values[3]);                  // the 4th and 5th are the with and height of each key. 
        int h   = int(values[4]);
        //keys[i] = new Key(pos, values[0], rad, ang, w, h); // Finaly enter the information in to the "keys" array
        //keys[i] = new Key(new PVector(0,0), values[0], rad, ang, w, h); // Finaly enter the information in to the "keys" array

        Key key = new Key(this, values[0]); 
        key.setTranslation(rad * cos(ang), rad * sin(ang));
        key.setBoundaries(Integer.parseInt(values[3]), Integer.parseInt(values[4])); 
        addWidget(key);
      }
    }
  }



  void onTouch() {
    if (allCursors.size() > 0) {
      MTCursor c = (MTCursor) allCursors.get(0); 
      Point p = c.getPosition(); 
      //check((int)p.x, (int)p.y); 

      println("touch " + p.x + ":" + p.y);
    } 
    else {
      println("sorry, touch got, but no cursor!");
    }
  }

 
  private boolean visible = true;
  boolean isVisible() {
    return visible;
  }

  void setVisible(boolean visible) {
    this.visible = visible;
  }    

  private TextEditor editor = null;
  void setEditor(TextEditor editor) {
    this.editor = editor;
  }

  public void drawWidget() {
    rBox(0, 0, (int)borderWidth, (int)borderHeight, color(0), color(255), false);
    super.drawWidget();
  }

  // this is just the funtion that allow you to draw the beatifull shape of a mac key.
  private void rBox(int x, int y, int _w, int _h, color _bg, color _fg, boolean mode) {
    float a;
    float b;

    if (mode) {    // Mode = true -> box or key
      a = _h/6;
      b =  a/4;
    } 
    else {      // Mode = false -> rectangualr or keyboard
      a = _h/12;
      b =  a/6;
    }

    float W = _w/2;
    float H = _h/2;

    fill(_bg);
    strokeWeight( 2 );
    stroke(_fg);
    beginShape(); 
    vertex(       x +W -a, y -H );

    bezierVertex( x +W -b, y -H, 
    x +W, y -H +b, 
    x +W, y -H +a);

    vertex(       x +W, y +H -a);

    bezierVertex( x +W, y +H -b, 
    x +W -b, y +H, 
    x +W -a, y +H);

    vertex(       x -W +a, y +H );

    bezierVertex( x -W +b, y +H, 
    x -W, y +H -b, 
    x -W, y +H -a );

    vertex(       x -W, y -H +a );

    bezierVertex( x -W, y -H +b, 
    x -W +b, y -H, 
    x -W +a, y -H );
    endShape(CLOSE);
  }
}


