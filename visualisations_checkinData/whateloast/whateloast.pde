// whaletoast.pde

import org.json.*;

char attract_key = 'n';  // change if similiar sets attract or repel
char mode_key = 'm';  // change between skills or interests
boolean mode = true;  // true for skills, false for interests

float SPRING_COEFFICIENT = 2.0;
float DAMPENING_COEFFICIENT = 1.0;

int WIN_W = 640;
int WIN_H = 480;
float ALPHA_MIN = 0.3;
int bg = 0;

String baseURL = "http://meetmee.javaprovider.net/php/TheEdge_VisitorProfiles/API/view_list_distinctusercheckins_all.php";

int last_update = millis();

Node[] nodes;

void setup () 
{ 
  size(WIN_W, WIN_H);
  
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
      n.months = int(checkin.getString("months_since_checkin"));
      n.days = int(checkin.getString("days_since_checkin"));
      n.hours = int(checkin.getString("hours_since_checkin"));
      n.minutes = int(checkin.getString("minutes_since_checkin"));
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

void draw () 
{
  background(bg);

  int now = millis();
  float dt = (now - last_update)/1000.0;
  last_update = now;
  
  for (int i = 0; i < nodes.length; i++) 
  { 
    Node n = (Node)nodes[i];
    n.time_update();

/*
    // collisions with other nodes
    for (int i = 0; i < nodes.length; i++)
      for (int j = i + 1; j < nodes.length; i++)
        Node n1 = (Node)nodes[i];
        Node n2 = (Node)nodes[j];
        if (distance_to_from(n1, n2) < n1.radius + n2.radius)
        {
          float[] dir = unit_vec_dir(n1, n2);
          float v = sqrt(vx*vx + vy*vy);
          vx = -dir[0]*v;
          vy = -dir[1]*v;        
        }
      }
*/
    
    n.update(dt);
    n.render();
  }
  
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
  int months;
  int days;
  int hours;
  int minutes;
  String sublocation;

  // appearance
  float radius;
  float alphatran;
  color col;
  
   
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
  }
  
  void time_update()
  {
    alphatran = (1.0 - days/7.0)*(1.0 - ALPHA_MIN) + ALPHA_MIN;
    if (alphatran < ALPHA_MIN) alphatran = ALPHA_MIN;
  }
  
  void calculate_dists_skills()
  {
    for (int i = 0; i < nodes.length; i++)
    {
      Node n = (Node)nodes[i];
      if (n == this) continue;
      List union_words = union(skills, n.skills);
      dists[i] = 1.0 - float(union_words.size())/(skills.length + n.skills.length - union_words.size());
    }
  }
  
  void calculate_dists_interests()
  {
    for (int i = 0; i < nodes.length; i++)
    {
      Node n = (Node)nodes[i];
      if (n == this) continue;
      List union_words = union(interests, n.interests);
      dists[i] = 1.0 - float(union_words.size())/(interests.length + n.interests.length - union_words.size());
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
      ax += dir[0]*k*(des_dist - px_dist)/m;
      ay += dir[1]*k*(des_dist - px_dist)/m;      
    }
    
    // velocity dampen
    ax -= c*vx/m;    
    ay -= c*vy/m;
  }
  
  void render()
  {
    fill(0, 128, 255, 255*alphatran);
    stroke(255);
    ellipse(x, y, 2*radius, 2*radius);
    fill(255, 255, 255);
    text(lastname + ", " + firstname, x, y);
  }
  
  void update_kinematics(float dt)
  {
    vx += ax*dt;
    vy += ay*dt;    
   
    // collisions with walls 
    if (x < 0)
    {
      x = 0;
      vx = -vx;
    }    
    if (x > WIN_W)
    {
      x = WIN_W;
      vx = -vx;
    }    
    if (y < 0)
    {
      y = 0;
      vy = -vy;
    }    
    if (y > WIN_H)
    {
      y = WIN_H;
      vy = -vy;
    }
            
    x += vx*dt;
    y += vy*dt;    
  }
}

List union(String[] words0, String[] words1)
{
  List res = new ArrayList();
  for (int i = 0; i < words0.length; i++)
    for (int j = i+1; j < words1.length; j++)
    {
      if (words0[i] == words1[j])
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
    for (int i = 0; i < nodes.length; i++)
        nodes[i].invert_dists();
  }
  
}
