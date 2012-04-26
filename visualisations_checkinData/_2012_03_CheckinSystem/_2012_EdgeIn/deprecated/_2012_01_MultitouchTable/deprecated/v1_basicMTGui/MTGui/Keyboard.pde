class Keyboard{
  Key[] keys;        // Array of keys 
  
  PVector pos;       // center of the keyboard. Replace the kCenter of the Tiper3MapMaker. So here this points is, the keyboard will be draw arround (using polar geometry) 
  float north = 0;   // this is the radient of rotation of the keyboard
  
  boolean border;    // this is came from the Tiper3MapMaker, and is usefull for preventing opening empty keyboard maps
  float   borderWidth;  // This is the width and height of the keyboard
  float   borderHeight; // It wirted on the first line of the .kbd file 
  
  PFont font;
    
  //----------------------------------- CONSTRUCTOR FUNTIONS
  Keyboard(int _x, int _y){
    pos = new PVector(_x,_y);                     // Set the initial position of the keyboard
    
    font = createFont("Arial",12);                // Load the font
    String[] data = loadStrings("map.kbd");       // Load the map of the keys made by Tiper3MapMaker 
    
    if ( data.length > 1 ){                       // Populate the information from the keyboard map file to the keys variable
      keys = new Key[data.length-1];              // Set the lenght of total key parameters
    
                                                  // The first line of the file is for the border the center point and width & height
      String[] borderValues = split(data[0],","); // of the keyboard. This is usefull only to this program.
      
      borderWidth = float(borderValues[2]);       // the fist to borderValues are the ones of kCenter used by Tiper3MapMaker. Here is useless      
      borderHeight = float(borderValues[3]);
      border = true;                              
    
      for(int i = 0; i < keys.length; i++){       // Here start reading and extracting the rest of the keys parameters (remember that the fist line only have the info about the keyboard center and width&height)
        String[] values = split(data[i+1],",");   // Extract the content between , 
        float rad = float(values[1]);             // the first value is the Letter or Key, the second one is radio from the center
        float ang   = float(values[2]);           // the 3th is the angle on radians from the center (this last to parameters are the ones that let the keabord be redraw in any angle and continue working)
        int w  = int(values[3]);                  // the 4th and 5th are the with and height of each key. 
        int h   = int(values[4]);
        keys[i] = new Key(pos, values[0], rad, ang, w, h); // Finaly enter the information in to the "keys" array
      }
    } else {                                      // If the file is empty or just the header with the border.
      keys = new Key[0];                          //  No keys are load
      border = false;                             //  Nothing is draw
    }                        
    
  }
  
  // Rotate the keyBoard
  void rot(float _ang){
    north = _ang;
    update();
  }
  
  // Move the central point in order to re-draw the keyboard in another place
  void moveTo(float _x, float _y){
    pos = new PVector(_x, _y);
    update();
  }
  
  //Update the information of the position and rotation of each key (just in the array of keys, NOT on the file... so this is temporal)
  void update(){
    for(int i = 0; i< keys.length; i++){
      keys[i].calcPos(pos,north);
    }
  }
  
  // Draw the keyBoard
  void render(){
    //First draw the border of the keyboard. For that will push, translate, rotate and pop the Matrix.
    pushMatrix();
      translate(pos.x,pos.y);
      rotate(north);
      rBox(0, 0, (int)borderWidth, (int)borderHeight, color(0), color(255), false);
    popMatrix();
    // After that draw all the keys. If the keyboard is moved or rotated each one of the keys are previusly updated to on each angle and position
    for(int i = 0; i < keys.length; i++) keys[i].render();
  }
  
  
  // ----------------------------------------------------------------------------- Events
  // Check if the x and y coordinates are over the keyboard
  boolean isOver(int _x, int _y){
    PVector _loc = new PVector(_x,_y); 
    if (pos.dist(_loc) <= borderWidth/2) return true;
    else return false;
  }
  
  // Check if the vector coordinates is over the keyboard
  boolean isOver(PVector _loc){
    if (pos.dist(_loc) <= borderWidth/2) return true;
    else return false;
  }
  
  // Check every key if certain x and y position is over it... and return the letter of each one  
  String check(int _x, int _y){    // (Note that if you change the .kbd file you can writte words insted of just put the letter in order to make complex combinations like SPACE, SHIFT, etc)
    String pressed = "";           // If nothing is press a nothing is return
    
    for(int i = 0; i< keys.length; i++){
      if (keys[i].isOver(_x,_y)){
        keys[i].bg = color(255);
        keys[i].fg = color(0);
        pressed = keys[i].s; 
      } else{
        keys[i].bg = color(0);
        keys[i].fg = color(255);
      }
    }
    return pressed;
  }
}


