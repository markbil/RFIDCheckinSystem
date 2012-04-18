// timepiece.pde

import org.json.*;

int WIN_W = 800;
int WIN_H = 600;

int last_update = millis();

boolean mode = false;
float unravel = 0.0;  
float speed = 0.5;

String url = "http://meetmee.javaprovider.net/php/TheEdge_VisitorProfiles/API/view_number_distinctusercheckins_perhour.php";

Timepiece t;

  
int min_hour = 12;    // lower bound for timepiece
int max_hour = 24;   // uppder bound for timepiece

void setup() 
{ 
  size(800, 600);
  smooth();
    
  t = new Timepiece(max_hour - min_hour);
  
  // parse JSON
  String result = join(loadStrings(url), "");
  try {
    JSONArray checkins = new JSONArray(result);
    int checkins_length = checkins.length();
 
    println("number of hours recorded " + checkins_length);
    
    for (int i = 0; i < checkins_length; i++)
    {
      JSONObject checkin = checkins.getJSONObject(i);
      
      String shour = checkin.getString("hour");
      int nhour = int(shour);
      
      if (nhour < min_hour || nhour > max_hour) continue;
      t.data.set(nhour-min_hour, float(checkin.getString("distinct_usercheckins")));
      t.desc.set(nhour-min_hour, shour); 
    }      
  } catch (JSONException e)
  {
    println ("There was an error parsing the JSONObject.");
  }  
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
  
  background(0, 0, 0);
  translate((1.0-unravel)*WIN_W/2.0 + unravel*t.spiral_factor/t.data.size(), (1+0.8*unravel)*WIN_H/2.0);
  scale(1.0+0.5*unravel*WIN_W/t.spiral_factor, 1);
  t.render(unravel);
  float time = hour()-min_hour + minute()/60.0;
  t.render_line(unravel, time);
}

class Timepiece
{ 
  ArrayList<Float> data;
  ArrayList<String> desc;
  float spiral_factor;
  float unit_length;
    
  Timepiece(int npartitions)
  {
    spiral_factor = 400;
    unit_length = 10;
    data = new ArrayList<Float>();
    desc = new ArrayList<String>();
    for (int i = 0; i < npartitions; i++) 
    {
      data.add(0.0);
      desc.add("");
    }
  }
  
  
  void render_line(float unravelness, float pos)
  {
    float r0 = pos*unravelness*spiral_factor/data.size();
    float a0 = pos*TWO_PI*(1.0-unravelness)/data.size();
    
    // ray
    stroke(255, 153, 255, 128);
    float sw = 1+0.25*unravelness*(spiral_factor/data.size()-2);
    strokeWeight(sw);
    float val = 0.9*0.25*WIN_H;
    line(r0*cos(a0), r0*sin(a0), r0*cos(a0)+val*sin(a0), r0*sin(a0)-val*cos(a0));
  }
  
  // draw this timepiece
  void render(float unravelness)
  {    
    float dr = unravelness*spiral_factor/data.size();
    float da = TWO_PI*(1.0-unravelness)/data.size();
    float maxval = Collections.max(data);
    textAlign(CENTER);
    
    // each ray
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
                
      // spiral segment
      stroke(128, 0, 0, 50);
      strokeWeight(5);
      line(r0*cos(a0), r0*sin(a0), r1*cos(a1), r1*sin(a1));
      
      // ray
      stroke(255, 153, 0);
      float sw = 2 + 0.9*unravelness*(spiral_factor/data.size()-2);
      strokeWeight(sw);
      float val = 0.9*0.5*WIN_H*data.get(i)/maxval;
      line(r0*cos(a0), r0*sin(a0), r0*cos(a0)+val*sin(a0), r0*sin(a0)-val*cos(a0));
      fill(255, 255, 0, unravelness*255);
      text(desc.get(i), r0*cos(a0), r0*sin(a0)+1.5*sw);
      text(int(data.get(i)), r0*cos(a0)+val*sin(a0), r0*sin(a0)-val*cos(a0)-1.5*sw);
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
 
