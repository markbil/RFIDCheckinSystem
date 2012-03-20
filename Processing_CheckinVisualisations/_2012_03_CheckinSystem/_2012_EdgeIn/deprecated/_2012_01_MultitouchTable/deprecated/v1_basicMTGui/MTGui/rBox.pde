// this is just the funtion that allow you to draw the beatifull shape of a mac key.
void rBox(int x, int y, int _w, int _h, color _bg, color _fg, boolean mode){
  float a;
  float b;
  
  if (mode){    // Mode = true -> box or key
    a = _h/6;
    b =  a/4;
  } else {      // Mode = false -> rectangualr or keyboard
    a = _h/12;
    b =  a/6;
  }
  
  float W = _w/2;
  float H = _h/2;
  
  fill(_bg);
  strokeWeight( 2 );
  stroke(_fg);
  beginShape(); 
    vertex(       x +W -a,  y -H );
    
    bezierVertex( x +W -b , y -H,
                  x +W    , y -H +b, 
                  x +W    , y -H +a);
                  
    vertex(       x +W    , y +H -a);
    
    bezierVertex( x +W    , y +H -b,
                  x +W -b , y +H,
                  x +W -a , y +H);
                  
    vertex(       x -W +a , y +H );
    
    bezierVertex( x -W +b , y +H,
                  x -W    , y +H -b,
                  x -W    , y +H -a );
                  
    vertex(       x -W    , y -H +a );
    
    bezierVertex( x -W    , y -H +b,
                  x -W +b , y -H,
                  x -W +a , y -H );
  endShape(CLOSE);
}
