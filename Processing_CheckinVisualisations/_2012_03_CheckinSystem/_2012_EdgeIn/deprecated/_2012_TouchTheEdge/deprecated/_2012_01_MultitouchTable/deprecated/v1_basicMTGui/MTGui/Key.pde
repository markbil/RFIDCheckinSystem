class Key{
  // The position of the Key is stored and managed using polar geometry.
  // This will allow the keboard to be draw rotated and continue to be funtional.
  // In order to do that first we need the center o polar center position
  PVector center; // this is the x and y position of the center of the keyboard
  
  float rad = 0; // radio from the center of the keyboard
  float ang = 0; // angle from the center of the keyboard
  
  // Then this class can convert from polar (rad, ang) to cartesian (x, y) geometry
  PVector pos;   // This is the position of the key in x and y coordinates
  
  float north = 0;  // This is seams useles now but when the keyboard start rotation this will give
                    // the correct angle of how to be draw
  
  String s;        // the sting of the KEY
  
  int w = 53;      // width 
  int h = 53;      // height
  
  PFont font;
  color fg = color(255);
  color bg = color(0);
  
  // -------------------------------------------------------- Constructors
  Key(PVector _center, String _s){
    s = _s;
    font = createFont("Arial",(h/10)*3);
    calcPos(_center,0);
  }
  
  Key(PVector _center, String _s,float _rad, float _ang, int _w, int _h){
    rad = _rad;
    ang = _ang;
    s = _s;
    w = _w;
    h = _h;
    
    font = createFont("Arial",(h/10)*3);
    calcPos(_center,0);
  }
  // -------------------------------------------------------- Location Funtion
  
  // The next 3 funtion give the cartesian (x and y) coodinates from the 
  // global variables rad and ang (polar coordinates)
  void calcPos(PVector _center,float _north){
    north = _north;
    center = _center;
    
    pos = new PVector(calcX(),calcY());
    pos.add(center);
  }
  
  float calcX(){
    float posX = rad * cos(ang + north);
    return posX;
  }

  float calcY(){
    float posY = rad * sin(ang + north);
    return posY;
  }    
  
  // This next 3 funtion make exactly the oposite. Set the rad and ang from
  // a given x and y position. 
  void moveTo(int _x, int _y){
    PVector place = new PVector(_x,_y);
    rad = calcRad(place);
    ang = calcAng(place);
    calcPos(center,north);
  }
  
  float calcRad(PVector _pos){
    float distance = _pos.dist(center);
    return distance;
  }
  
  float calcAng(PVector _pos){
    _pos.sub(center);
    return _pos.heading2D();
  }
  
  // ------------------------------------------------------------------- Draw and Check
  void render(){
    pushMatrix();
      translate(pos.x, pos.y);
      rotate(north);
      rBox(0,0,w,h,bg,fg,true);
      fill(fg);
      textFont(font);
      textAlign(CENTER);
      text(s,0,(h/10)*1.3);
    popMatrix();
  }

  boolean isOver(PVector _loc){
    if (pos.dist(_loc) <= w/2) return true;
    else return false;
  }

  boolean isOver(int _x, int _y){
    PVector _loc = new PVector(_x,_y);
    if (pos.dist(_loc) <= h/2) return true;
    else return false;
  }  
}
