class Point {
  float x = 0.0; 
  float y = 0.0; 
  Point(float x, float y) {
    this.x = x; 
    this.y = y;
  }

  float distance(Point p) {
    float dx = (x - p.x); 
    float dy = (y - p.y); 
    return sqrt(dx*dx + dy*dy);
  }
  
  String toString() {
    return new String("" + x + ":" + y);
  }
}

