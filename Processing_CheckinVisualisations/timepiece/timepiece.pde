int WIN_W = 800;
int WIN_H = 600;

int last_update = millis();

boolean mode = false;
float unravel = 0.0;  
float speed = 0.4;

Timepiece t = new Timepiece();

void setup() 
{ 
  size(800, 600);
  smooth();
}

void draw() 
{
  int now = millis();
  float dt = (now - last_update)/1000.0;
  last_update = now;
  
  if (mode) 
    if (unravel < 1.0)
      unravel += speed*dt;
    else unravel = 1.0;
  else 
    if (unravel > 0.0)
      unravel -= speed*dt;
    else unravel = 0.0;
  
//  unravel = float(mouseX)/WIN_W;
  
  background(0, 0, 0);
  
  translate((1.0-unravel)*WIN_W/2.0 + unravel*t.spiral_factor/t.data.size(), (1+0.8*unravel)*WIN_H/2.0);
  scale(1.0+0.5*unravel*WIN_W/t.spiral_factor, 1);
  t.render(unravel);
}

class Timepiece
{ 
  ArrayList<Float> data; 
  float spiral_factor;
  float unit_length;
    
  Timepiece()
  {
    spiral_factor = 400;
    unit_length = 10;
    data = new ArrayList<Float>();    
    for (int i = 0; i < 24; i++) data.add(float(i));
  }
  
  void render(float unravelness)
  {    
    float dr = unravelness*spiral_factor/data.size();
    float da = TWO_PI*(1.0-unravelness)/data.size();
                   
    for (int i = 0; i < data.size(); i++)
    {
      float r0 = dr*i;
      float a0 = da*i;
      float r1 = dr*(i+1);
      float a1 = da*(i+1);
      
      if (i == data.size() - 1)
      {
        r1 = r0;
        a1 = a0;
      }
                
      stroke(255, 0, 0);
      strokeWeight(5);
      line(r0*cos(a0), r0*sin(a0), r1*cos(a1), r1*sin(a1));
      
      stroke(255, 153, 0);
      strokeWeight(2 + unravelness*(spiral_factor/data.size()-2));
      float val = unit_length*data.get(i);
      line(r0*cos(a0), r0*sin(a0), r0*cos(a0)+val*sin(a0), r0*sin(a0)-val*cos(a0));
    }
    
  }
    
}

void mouseClicked()
{}

void mouseReleased()
{}

void keyPressed() 
{
  if (key == 'm')
    mode = !mode;
}
 
