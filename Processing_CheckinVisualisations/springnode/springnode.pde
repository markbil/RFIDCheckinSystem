// whaletoast.pde

import org.json.*;

char attract_key = 'n';  // change if similiar sets attract or repel
boolean attract = true;
char mode_key = 'm';  // change between skills or interests
boolean mode = true;  // true for skills, false for interests

float SPRING_COEFFICIENT =  5.0;
float DAMPENING_COEFFICIENT = 4.0;

int WIN_W = 800, WIN_H = 600;
int WIN_W_2 = WIN_W/2, WIN_H_2 = WIN_H/2;

float ALPHA_MIN = 0.3;
int bg = 0;

String baseURL = "http://meetmee.javaprovider.net/php/TheEdge_VisitorProfiles/API/view_list_distinctusercheckins_all.php";

int last_update = millis();

Node[] nodes;

boolean mouse_pressed = false, mouse_released = false;

void setup() 
{ 
//  size(WIN_W, WIN_H);
  size(800, 600);
  
  // parse JSON
  String result = join(loadStrings( baseURL ), "");
  try {
    JSONArray checkins = new JSONArray(result);
    int checkins_length = checkins.length();
    println("number of users " + checkins_length);
    
    nodes = new Node[checkins_length];
    
    for (int i = 0; i < checkins_length; i++){
      nodes[i] = new Node();
      Node n = (Node)nodes[i];
      JSONObject checkin = checkins.getJSONObject(i);

      // user details
      n.id = int(checkin.getString("edge_user_id"));
      n.firstname = checkin.getString("firstname");
      n.lastname = checkin.getString("lastname");  
      n.occupation = checkin.getString("occupation");  
      n.status_msg = checkin.getString("statusmessage");        
         
      // last checkin
      String timestamp = checkin.getString("checkin_timestamp");
      n.ci_year = int(timestamp.substring(0, 4));
      n.ci_month = int(timestamp.substring(5, 7));
      n.ci_day = int(timestamp.substring(8, 10));
      n.ci_hour = int(timestamp.substring(11, 13));
      n.ci_minute = int(timestamp.substring(14, 16));
      n.ci_second = int(timestamp.substring(17, 19));
      n.sublocation = checkin.getString("checkin_sublocation");
      
      JSONArray skills = checkin.getJSONArray("expertise");
      n.skills = new String[skills.length()];
      for (int j = 0; j < skills.length(); j++)
        n.skills[j] = skills.getString(j);
        
      JSONArray interests = checkin.getJSONArray("interests");
      n.interests = new String[interests.length()];
      for (int j = 0; j < interests.length(); j++)
        n.interests[j] = interests.getString(j);        
        
      n.init();

       println("loaded " + n.firstname + " " + n.lastname + " " + n.id); 
     }
  } catch (JSONException e) 
  {
    println ("There was an error parsing the JSONObject.");
  }
  
  for (int i = 0; i < nodes.length; i++) 
    nodes[i].calculate_dists_interests();
  
}

void draw() 
{
  background(bg);

  int now = millis();
  float dt = (now - last_update)/1000.0;
  last_update = now;
  
  for (int i = 0; i < nodes.length; i++) 
  { 
    Node n = (Node)nodes[i];
    n.time_update();    
    n.update(dt);
    n.render();
  }
  
  mouse_pressed = false;
  mouse_released = false;
  
}

class Node
{
  // kinematics
  float x, y;
  float vx, vy;
  float ax, ay;
  
  float m;  // mass
  float k;  // spring
  float c;  // dampener
  
  // spring natural length
  float[] dists;
  float d_scale;  
  
  // user properties
  int id;
  String firstname;
  String lastname;
  String occupation;
  String status_msg;
  String[] interests;
  String[] skills;

  // time since last checkin  
  int ci_year;
  int ci_month;
  int ci_day;
  int ci_hour;
  int ci_minute;
  int ci_second;
  String sublocation;

  // appearance
  float radius;
  float alphatran;
  color col;
  boolean selected;
  boolean hovered;
  
   
  Node()
  {}
  
  void init()
  {
    x = random(0, WIN_W);
    y = random(0, WIN_H);
    vx = vy = 0.0;
    ax = ay = 0.0;

    radius = 25;
    col = color(0, 0, 0);
    
    m = 1.0;
    k = SPRING_COEFFICIENT;
    c = DAMPENING_COEFFICIENT;
    
    d_scale = 100;        
    dists = new float[nodes.length];
    selected = false;    
  }
  
  void time_update()
  {
//    alphatran = (1.0 - days/7.0)*(1.0 - ALPHA_MIN) + ALPHA_MIN;
//    if (alphatran < ALPHA_MIN) alphatran = ALPHA_MIN;
  }
  
  void check_mouse()
  {
    float dx = float(mouseX) - x;
    float dy = float(mouseY) - y;
    
    if (dx*dx + dy*dy < radius*radius) hovered = true;      
    else hovered = false;
    
    if (hovered && mousePressed) selected = true;
    if (mouse_released) selected = false;

    if (selected)
    {
      x = mouseX;
      y = mouseY;
    }
  }
  
  void calculate_dists_skills()
  {
    for (int i = 0; i < nodes.length; i++)
    {
      Node n = (Node)nodes[i];
      if (n == this) continue;
      List intersection_words = intersection(skills, n.skills);
      dists[i] = float(intersection_words.size())/(skills.length + n.skills.length - intersection_words.size());
      if (attract) dists[i] = 1.0 - dists[i];
      
      // debug print
      /*String s = new String();
      s = lastname + " <=> " + n.lastname + " intersection: ";
      for (int j = 0; j < intersection_words.size(); j++)
        s += intersection_words.get(j) + ", ";
      println(s + " " + dists[i]);*/
    }
  }
  
  void calculate_dists_interests()
  {
    for (int i = 0; i < nodes.length; i++)
    {
      Node n = (Node)nodes[i];
      if (n == this) continue;
      List intersection_words = intersection(interests, n.interests);
      dists[i] = float(intersection_words.size())/(interests.length + n.interests.length - intersection_words.size());
      if (attract) dists[i] = 1.0 - dists[i];
      
      // debug print
      /*String s = new String();
      s = lastname + " <=> " + n.lastname + " intersection: ";
      for (int j = 0; j < intersection_words.size(); j++)
        s += intersection_words.get(j) + ", ";
      println(s + " " + dists[i]); */      
    }    
  }
  
  void invert_dists()
  {
    for (int i = 0; i < dists.length; i++)
      dists[i] = 1-dists[i];
  }
 
  void update(float dt)
  {
    update_accel();
    update_kinematics(dt);
    check_mouse();
  }
  
  void update_accel() 
  {
    ax = ay = 0.0;
    
    // process springs
    for (int i = 0; i < dists.length; i++)
    {
      Node n = (Node)nodes[i];
      if (n == this) continue;
      float[] dir = unit_vec_dir(this, n);
      float des_dist = d_scale*dists[i] + 1.4*(radius + n.radius);
      float px_dist = distance_to_from(n, this);
      if (px_dist > 3*d_scale || px_dist == 0.0) continue;
      ax += dir[0]*k*(des_dist - px_dist)/m;
      ay += dir[1]*k*(des_dist - px_dist)/m;

      int error = int(255*(des_dist/px_dist-0.5));
      stroke(error, 0, 255-error);
      line(x, y, n.x, n.y);
    }
    
    // velocity dampen
    ax -= c*vx/m;
    ay -= c*vy/m;
            
  }
  
  void render()
  {
    stroke(255);

    if (selected)
    {
      fill(color(255, 0, 0));
      ellipse(x, y, 2.5*radius, 2.5*radius);
                  
      fill(220, 120, 10);
      rect(x, y, 300, 100);
      String skillstxt = "";
      for (int i = 0; i < skills.length; i++)
        skillstxt += skills[i] + ", ";
      fill(255, 255, 255);
      text("\n"  + occupation + ".\n" + skillstxt, x, y);
    }
    else if (hovered)
    {
      fill(color(128, 0, 0));     
      ellipse(x, y, 2.25*radius, 2.25*radius);              
    }
    else
    {   
      fill(color(0, 0, 255));
      ellipse(x, y, 2*radius, 2*radius);
    }
    fill(255, 255, 255);
    text(firstname + "\n" + lastname.substring(0, 1) + ".", x-radius/2.0, y);
    
  }
  
  void update_kinematics(float dt)
  {
    vx += ax*dt;
    vy += ay*dt;
       
    // collisions with walls 
    if (x < radius)
    {
      x = radius;
      vx = -vx;
    }    
    if (x > WIN_W - radius)
    {
      x = WIN_W - radius;
      vx = -vx;
    }    
    if (y < radius)
    {
      y = radius;
      vy = -vy;
    }    
    if (y > WIN_H - radius)
    {
      y = WIN_H - radius;
      vy = -vy;
    }
            
    x += vx*dt;
    y += vy*dt;    
  }
}

List intersection(String[] words0, String[] words1)
{
  List res = new ArrayList();
  for (int i = 0; i < words0.length; i++)
    for (int j = 0; j < words1.length; j++)
    {
      if (words0[i].equals(words1[j]))
        res.add(words0[i]);
    }  
  return res;
}

float distance_to_from(Node n0, Node n1)
{
  float dx = n0.x - n1.x;
  float dy = n0.y - n1.y;
  return sqrt(dx*dx + dy*dy);
}

float[] unit_vec_dir(Node n0, Node n1)
{
  float dx = n0.x - n1.x;
  float dy = n0.y - n1.y;
  float len = sqrt(dx*dx + dy*dy);
  float[] res = new float [2];
  if (len != 0.0)
    res[0] = dx/len; res[1] = dy/len;
  return res;
}

void mouseClicked()
{  mouse_pressed = true; }

void mouseReleased()
{  mouse_released = true; }

void keyPressed() 
{
  if (key == mode_key) 
  {
    mode = !mode;
    if (mode == true)
      for (int i = 0; i < nodes.length; i++)
        nodes[i].calculate_dists_skills(); 
    else
      for (int i = 0; i < nodes.length; i++)
        nodes[i].calculate_dists_interests();           
  }
  
  if (key == attract_key) 
  {
    attract = !attract;
    for (int i = 0; i < nodes.length; i++)
        nodes[i].invert_dists();
  } 
  
  if (mode)
    println("mode is skills");
  else
    println("mode is interests");
  if (attract)
    println("like attracts");      
  else
    println("like repels");            
}
 
