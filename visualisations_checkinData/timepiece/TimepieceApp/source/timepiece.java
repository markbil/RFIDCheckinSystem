import processing.core.*; 
import processing.xml.*; 

import org.json.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class timepiece extends PApplet {

// timepiece.pde



int WIN_W = 800;
int WIN_H = 600;

int last_update = millis();

int last_fetch;
int fetch_refresh_time = 5; // seconds

boolean mode = false;
float unravel = 0.0f;  
float speed = 0.5f;

String url = "http://meetmee.javaprovider.net/php/TheEdge_VisitorProfiles/API/view_number_distinctusercheckins_perhour_15minslots.php";


Timepiece t;

int numsegs = 4*12;

public void setup() 
{ 
  size(800, 600);
  //size( screen.width, screen.height); 
  smooth();
  fetch_json(url);
  last_fetch = millis();
}

public void draw() 
{
  int now = millis();
  float dt = (now - last_update)/1000.0f;
  last_update = now;
  
  if (now - last_fetch > fetch_refresh_time*1000) 
  {
    fetch_json(url);
    last_fetch = now;
  }
  
  if (mode) 
    if (unravel < 1.0f)
      unravel += speed*dt;
    else unravel = 1.0f;
  else 
    if (unravel > 0.0f)
      unravel -= speed*dt;
    else unravel = 0.0f;
  
  background(0, 0, 0);
  translate((1.0f-unravel)*WIN_W/2.0f + unravel*t.spiral_factor/numsegs, (1+0.8f*unravel)*WIN_H/2.0f);
  scale(1.0f+0.5f*unravel*WIN_W/t.spiral_factor, 1);
  t.render(unravel);
  float time = hour()%12 + minute()/60.0f;
  t.render_line(unravel, time);
}

class Timepiece
{ 
  float d[];
  String desc[];
  float spiral_factor;
  float unit_length;
    
  Timepiece(float data[], String description[])
  {
    spiral_factor = 400;
    unit_length = 10;
    set_data(data, description);
  }
  
  public void set_data(float data[], String description[]) 
  {
    d = data;
    desc = description;
  }
    
  public void render_line(float unravelness, float pos)
  {
    float r0 = 4*pos*unravelness*spiral_factor/d.length;
    float a0 = 4*pos*TWO_PI*(1.0f-unravelness)/d.length;
    
    // ray
    stroke(255, 153, 255, 128);
    float sw = 1.0f+0.25f*unravelness*(spiral_factor/d.length)-2;
    if (sw < 1) sw = 1;
    strokeWeight(sw);
    float val = 0.9f*0.25f*WIN_H;
    line(r0*cos(a0), r0*sin(a0), r0*cos(a0)+val*sin(a0), r0*sin(a0)-val*cos(a0));
  }
  
  // draw this timepiece
  public void render(float unravelness)
  {    
    float dr = unravelness*spiral_factor/d.length;
    float da = TWO_PI*(1.0f-unravelness)/d.length;
    float maxval = 0;
    for (int i = 0; i < d.length; i++)
      maxval = max(maxval, d[i]);
           
    textAlign(RIGHT);
    
    float sw = 2.0f + 0.9f*unravelness*(spiral_factor/d.length)-2;
    if (sw < 2) sw = 2;
    textSize(sw);
    
    // each ray
    for (int i = 0; i < d.length; i++)
    {      
      float r0 = dr*i;
      float a0 = da*i;
      float r1 = dr*(i+1);
      float a1 = da*(i+1);
      
      if (i == d.length - 1)
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
      strokeWeight(sw);
      float val = (unravel/2 + 1.0f)*0.9f*0.5f*WIN_H*d[i]/maxval;
      line(r0*cos(a0), r0*sin(a0), r0*cos(a0)+val*sin(a0), r0*sin(a0)-val*cos(a0));
      fill(255, 255, 0, unravelness*255);
      text(PApplet.parseInt(d[i]), r0*cos(a0)+val*sin(a0), r0*sin(a0)-val*cos(a0)-1.5f*sw);
      pushMatrix();
      translate(r0*cos(a0), r0*sin(a0)+1.5f*sw);
      rotate(-PI/2);
      text(desc[i], 0, sw/4.0f);
      popMatrix();
    }
  }
}

public void fetch_json(String url)
{
  println("fetching from " + url);
  
    // parse JSON
  String result = join(loadStrings(url), "");
  try {
    JSONArray checkins = new JSONArray(result);
    int checkins_length = checkins.length();
 
    println("number of time slots recorded " + checkins_length);

    float data[] = new float[numsegs];
    String desc[] = new String[numsegs];
    
    for (int i = 0; i < checkins_length; i++)
    {
      JSONObject checkin = checkins.getJSONObject(i);
      
      String shour = checkin.getString("hour");
      int nhour = PApplet.parseInt(shour);

      String squarter = checkin.getString("quarterofhour");
      int nquarter = PApplet.parseInt(squarter);
      
      int index =  4*(nhour-12)+nquarter;     
      if (index < 0) continue;   // only PM times
      
      
      data[index] = PApplet.parseFloat(checkin.getString("distinct_usercheckins"));
    }
    
    for (int i = 0; i < numsegs; i++)
      desc[i] = ((i/4 != 0)?(i/4):"12") + ":" + ((i%4 != 0)?(15*(i%4)):"00");
    
    t = new Timepiece(data, desc);
    
  } catch (JSONException e)
  {
    println ("There was an error parsing the JSONObject.");
  }
  
}

public void mouseClicked()
{}

public void mouseReleased()
{}

public void keyPressed() 
{
  if (key == 'm')
    mode = !mode;
}
 
  static public void main(String args[]) {
    PApplet.main(new String[] { "--present", "--bgcolor=#666666", "--stop-color=#cccccc", "timepiece" });
  }
}
