import org.json.*;

class CheckinsOverviewApp {

    SimpleThread_checkinsOverviewApp thread_callDB;

    int threadwaittime = 1500; //ms before each DB-fetch    
    String baseURL = "http://meetmee.javaprovider.net/php/TheEdge_VisitorProfiles/API/view_list_distinctusercheckins_all.php";
//    String baseURL = "http://localhost/TheEdge_VisitorProfiles/API/view_list_distinctusercheckins_all_2.php";
    	
    // name of the table that will be created
    String table    = "";
    
    PApplet applet;
    //an array of locally synchronised usercards
    ArrayList userCards;

  CheckinsOverviewApp(PApplet applet) {
    this.applet = applet;
    setup(applet);
  }

  void setup(PApplet applet) {
    thread_callDB = new SimpleThread_checkinsOverviewApp(threadwaittime,"callDB", this);
    thread_callDB.start();
  }
  
  ArrayList getUserCard(){
    return this.userCards;
  }

  void draw() {
      translate((-width/2) + 50 , (-height/2) + 50);
      try {  //Null-Pointerexception could pop up if the thread happens to set userCards = null for synchronisation purposes, e.g. every 4th thread count
        if (userCards != null){ //make sure not to draw userCards until the thread has populated the local userCards ArrayList with the JSON result from the API

          int numberOfTilesAcross;
          int numberOfTilesDown;
          
          for (int i = 0; i < userCards.size(); i++) {      
            UserCard uc = (UserCard)((userCards).get(i));
            uc.draw();
                    
            numberOfTilesAcross = width / int((uc.getUserCard_width()*uc.getUserCard_scale())+uc.getUserCard_width()*0.05);
//            numberOfTilesAcross = 2;
//            println("# tiles across:" + numberOfTilesAcross);
//            println("#i: " + i);
            
            if((i+1) % numberOfTilesAcross == 0){
                 translate(-(numberOfTilesAcross-1)*((uc.getUserCard_width()*uc.getUserCard_scale())+uc.getUserCard_width()*0.05), (uc.getUserCard_height()*uc.getUserCard_scale())+uc.getUserCard_height()*0.05);

            } else{
                 translate(((uc.getUserCard_width()*uc.getUserCard_scale())+uc.getUserCard_width()*0.05), 0);
            }
//            
          }
        }
      } catch (Exception e) {
        println(e);
      }


  }
  
    //gets user data from all checked-in users and stores them in local array variables
  void getUserData(){                
      // parse JSON
      String result = join(loadStrings( baseURL ), "");
      try {
        JSONArray checkins = new JSONArray(result);
        int checkins_length = checkins.length();
        println("number of users " + checkins_length);
        
        for (int i = 0; i < checkins_length; i++){

          JSONObject checkin = checkins.getJSONObject(i);
          
          String edge_user_id = checkin.getString("edge_user_id");
          String firstname = checkin.getString("firstname");
          String lastname = checkin.getString("lastname");
          String occupation = checkin.getString("occupation");
          String statusmessage = checkin.getString("statusmessage");
          String checkin_timestamp = checkin.getString("checkin_timestamp");
          String timepassed = "";
          int months_since_checkin = checkin.getInt("months_since_checkin");
          int days_since_checkin = checkin.getInt("days_since_checkin");
          int hours_since_checkin = checkin.getInt("hours_since_checkin");
          int minutes_since_checkin = checkin.getInt("minutes_since_checkin");
          
          if(months_since_checkin > 0) timepassed = months_since_checkin + " months";
          else if(days_since_checkin > 0) timepassed = days_since_checkin + " days";
          else if(hours_since_checkin > 0) timepassed = hours_since_checkin + " hours";
          else if(minutes_since_checkin >= 0) timepassed = minutes_since_checkin + " minutes";
          
          String sublocation = checkin.getString("checkin_sublocation");
          println(firstname + " \t " + lastname + " \t " + timepassed + " \t " + sublocation);
          
          String[] expertise_arr={};
          String[] interests_arr={};
          String[] questions_arr={};
    
          
          JSONArray skills = checkin.getJSONArray("expertise");           
          for (int j = 0; j < skills.length(); j++){
            expertise_arr = (String[])(append(expertise_arr, skills.getString(j)));
          }
            
          JSONArray interests = checkin.getJSONArray("interests");
          for (int j = 0; j < interests.length(); j++){
            interests_arr = (String[])(append(interests_arr, interests.getString(j)));
          }     
            
          /////STORE retrieved JSON Objects into a locally stored ArrayList of UserCards
          
          
          //check if user-checkin that has been retrieved form the DB is already being displayed, if yes update userCard, if no add userCard                  
            if (userCards != null){ //current local usercard array not empty, e.g. first DB call
              boolean edge_user_id_exists = false;
              for(int k=0; k < userCards.size(); k++){ //iterate through all locally stored userCards
                if(edge_user_id.equals(((UserCard)userCards.get(k)).edge_user_id)){ //if a user from the DB call has already a local userCard...
                    if(checkin_timestamp.equals(((UserCard)userCards.get(k)).timestamp)){   //if edge_user_id and checkin_timestamp are the same, i.e. it's the same checkin
                      //do nothing. or potentially update fields of locally stored userCard
                      edge_user_id_exists = true;  
                    
                    }
                    else{
                      //edge_user_id is the same, but checkin_timestamp is an old one.
                      //deleted locally stored userCard. new newUserCard is inserted in next if-clause with new timestamp and userinfos
                      userCards.remove(k);
                    }
                }
              }
              if (edge_user_id_exists == false){
                println("new userCard inserted");
                UserCard newUserCard = new UserCard(edge_user_id, firstname, lastname, occupation, statusmessage, checkin_timestamp, timepassed, sublocation, expertise_arr, interests_arr, questions_arr);
                userCards.add(newUserCard);  
              }
            } else{ //if current local usercard empty, create new usercard and store in array
                println("first userCard inserted");
                UserCard newUserCard = new UserCard(edge_user_id, firstname, lastname, occupation, statusmessage, checkin_timestamp, timepassed, sublocation, expertise_arr, interests_arr, questions_arr);
                userCards = new ArrayList();
                userCards.add(newUserCard);
            }
         }
      } catch (JSONException e) 
      {
        println ("There was an error parsing the JSONObject.");
      }

  }
}

class UserCard extends GUI {
  
  String edge_user_id;
  String firstname;
  String lastname;
  String occupation;
  String statusmessage;
  String timestamp;
  String timepassed;
  String sublocation;
  String[] expertise;
  String[] interests;
  String[] questions;
  
  int userCard_width = 380;
  int userCard_height = 400;
  float userCard_scale = 0.7;
  
    //setFont
  PFont font_username = loadFont("Serif-28.vlw");
  PFont font_usersubtitle = loadFont("Serif-20.vlw");
  PFont font_userdescription = loadFont("Serif-16.vlw");
  
  
  UserCard(String edge_user_id, String firstname, String lastname, String occupation, String statusmessage, String timestamp, String timepassed, String sublocation, String[] expertise, String[] interests, String[] questions) {
    //ProjectImage image = new ProjectImage(imageUrl); 
    setBoundaries(userCard_width, userCard_height); 
    //addWidget(image); 
    
    this.edge_user_id = (edge_user_id != null) ? edge_user_id : "";
    this.firstname = (firstname != null) ? firstname : "";
    this.lastname = (lastname != null) ? lastname : "";
    this.statusmessage = (statusmessage != null) ? statusmessage : "";
    this.occupation = (occupation != null) ? occupation : "";
    this.timestamp = (timestamp != null) ? timestamp : "";
    this.timepassed = (timepassed != null) ? timepassed : "";
    this.sublocation = (sublocation != null) ? sublocation : "";
    this.expertise = expertise;
    this.interests = interests;
    this.questions = questions;
    

    
        Label name_lb = new Label(firstname + " " + lastname, LEFT); 
        name_lb.setTranslation(0, 0);
        name_lb.setFont(font_username); 
        name_lb.textColor = color(0, 10, 20);  
        addWidget(name_lb);
        
        Label occupation_lb = new Label(occupation, LEFT);
        occupation_lb.setTranslation(0, 40);
        occupation_lb.setFont(font_usersubtitle); 
        occupation_lb.textColor = color(127, 127, 0);  
        addWidget(occupation_lb);
     
        Label statusmessage_lb = new Label(statusmessage, LEFT);
        statusmessage_lb.setTranslation(0, 70);
        statusmessage_lb.setFont(font_usersubtitle); 
        statusmessage_lb.textColor = color(127, 127, 0);  
        addWidget(statusmessage_lb);     
        
        Label timepassed_lb;
        if(sublocation.equals("null")){
          timepassed_lb = new Label("Checked in " + timepassed + " ago", LEFT);
        } else{
          timepassed_lb = new Label("Checked in " + timepassed + " ago at " + sublocation, LEFT);
        }
        
        timepassed_lb.setTranslation(0, 100);
        timepassed_lb.setFont(font_usersubtitle); 
        timepassed_lb.textColor = color(127, 127, 0);  
        addWidget(timepassed_lb);     
    

        int gap = 20;
        int vertical_offset = 160;
        Label expertise_headline_lb = new Label("Areas of expertise:", LEFT);
        expertise_headline_lb.setTranslation(0, vertical_offset - gap);
        expertise_headline_lb.setFont(font_userdescription); 
        expertise_headline_lb.textColor = color(127, 0, 0);
        addWidget(expertise_headline_lb);   
        for (int i = 0; i < expertise.length; i++) {       
//            Label expertise_lb = new Label(expertise[i], LEFT);
            Label expertise_lb = (expertise[i] != null) ? new Label(expertise[i], LEFT)  : new Label("none", LEFT) ;
            expertise_lb.setTranslation(0, vertical_offset + gap*i);
            expertise_lb.setFont(font_userdescription); 
            expertise_lb.textColor = color(127, 127, 127);  
            addWidget(expertise_lb);     
        }
        
        
        
          Label interests_headline_lb = new Label("wants to know more about:", RIGHT);
          interests_headline_lb.setTranslation(350, vertical_offset - gap);
          interests_headline_lb.setFont(font_userdescription); 
          interests_headline_lb.textColor = color(127, 0, 0);  
//        float int_angle = (PI/interests.length);
          addWidget(interests_headline_lb);  
        for (int i = 0; i < interests.length; i++) {       
//            Label interests_lb = new Label(interests[i], RIGHT);
            Label interests_lb = (interests[i] != null) ? new Label(interests[i], RIGHT)  : new Label("none", RIGHT) ;
            //interests_lb.setTranslation(cos(PI/4-int_angle*i)*100, sin(PI/4-int_angle*i)*100);
            interests_lb.setTranslation(350, vertical_offset + gap*i);
            interests_lb.setFont(font_userdescription); 
            interests_lb.textColor = color(127, 127, 127);
            //interests_lb.setRotation(-PI/2 + int_angle * i);  
            addWidget(interests_lb);     
        }
    
    //createManipulator(this);    
    //setTranslation(random(-width/2, width/2), random(-height/2, height/2)); 
//    setTranslation(-100, 100);
    setScale(userCard_scale); 
    setRotation(random(-PI/6, +PI/6)); 
  }
  
  String getFirstname(){
    return this.firstname;
  } 
  String getLastname(){
    return this.lastname;
  }
  String getTimestamp(){
    return this.timestamp;
  }
  String getOccupation(){
    return this.occupation;
  }  
  String getStatusmessage(){
    return this.statusmessage;
  }  
  String getSublocation(){
    return this.sublocation;
  }
  String[] getExpertise(){
    return this.expertise;
  }
  String[] getInterests(){
    return this.interests;
  }
  String[] getQuestions(){
    return this.questions;
  }  
  int getUserCard_width(){
    return this.userCard_width;
  }
  int getUserCard_height(){
    return this.userCard_height;
  }
  float getUserCard_scale(){
    return this.userCard_scale;
  }
  

 float shear = 0.0;
 
 void drawWidget() {
    fill(255);
    stroke(0);
    
    float width_temp = (float)w;
    float height_temp = (float)h;
//    println("read, width: " + this.getWidgetWidth());
//    println("read, height: " + this.getWidgetHeight());
//    rect(-10, -10, int(width_temp), int(height_temp));   // w and h are fields inherited from GUI
    rect(-10, -10, width_temp, height_temp);   // w and h are fields inherited from GUI
    
    //setTranslation(shear, shear); 
    //shear += PI / 1024;
    super.drawWidget();
 }


  
//  float shear = 0.0;
//  void drawWidget() {
//    setTranslation(shear, shear); 
//    shear += PI / 1024;
//    super.drawWidget();  
//  }

//  class ProjectImage extends ImageWidget {
//    ProjectImage(String file) {
//      super(file);
//    }
//
//    void addCursor(MTCursor c) {
//      c.setTarget(container);
//      container.addCursor(c);
//    }
//  }
  
}

class SimpleThread_checkinsOverviewApp extends Thread {
 
  boolean running;           // Is the thread running?  Yes or no?
  int wait;                  // How many milliseconds should we wait in between executions?
  String id;                 // Thread name
  int count;                 // counter
  CheckinsOverviewApp checkinsOverviewApp;
   
  // Constructor, create the thread
  // It is not running by default
  SimpleThread_checkinsOverviewApp (int w, String s, CheckinsOverviewApp checkinsOverviewApp) {
    wait = w;
    running = false;
    id = s;
    count = 0;
    this.checkinsOverviewApp = checkinsOverviewApp;
  }
 
  int getCount() {
    return count;
  }
 
  // Overriding "start()"
  void start () {
    // Set running equal to true
    running = true;
    // Print messages
    println("Starting thread (will execute every " + wait + " milliseconds.)"); 
    // Do whatever start does in Thread, don't forget this!
    super.start();
  }
 
 
  // We must implement run, this gets triggered by start()
  void run () {
    while (running) {
      println(id + ": " + count);
      
      
      if (count % 4 == 0){
        //count = 0;
        //refresh userCards ArrayList. this is necessary to delete all userCards from the local userCards ArrayList that not part of
        //of the returned JSON Arraylist from the API any more, e.g. because they have checked-our or their checkin timestamp was long time ago.
        checkinsOverviewApp.userCards = null;
      }
      checkinsOverviewApp.getUserData();
      count++;
      // Ok, let's wait for however long we should wait
      try {
        sleep((long)(wait));
      } catch (Exception e) {
      }
    }
    System.out.println(id + " thread is done!");  // The thread is done when we get to the end of run()
  }
 
 
  // Our method that quits the thread
  void quit() {
    System.out.println("Quitting."); 
    running = false;  // Setting running to false ends the loop in run()
    // IUn case the thread is waiting. . .
    interrupt();
  }
}

