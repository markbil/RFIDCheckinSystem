import org.json.*;
PFont f;

String baseURL = "http://meetmee.javaprovider.net/php/TheEdge_VisitorProfiles/API/view_list_distinctusercheckins_all_2.php";
int checkinsCount; 
JSONArray checkins;


void setup(){

 size(500, 500);
 f = createFont("Arial",20);

}


void draw()
{
 background(211,211,211);
 smooth();
 fill (227,227,227);

 rectMode(CORNER);
 
 //outer rectangle - represents "total capacity" of the space
 rect (50, 50, 400, 10);

  String result = join( loadStrings( baseURL ), "");

    try {
      checkins = new JSONArray(result);
      checkinsCount = checkins.length(); //number of total checkins
      println("checkin_lengths: " + checkinsCount); //print number of total checkins to console
  
  
      //inner rectangle - represents number of people who have checked-in to the space
      fill(255, 0, 0);
      float checkinMeter_height = map(checkinsCount,0,20,0,400);
      rect(50, 50, checkinMeter_height, 10);
      
      
      

      for (int i = 0; i < checkinsCount; i++){
        JSONObject checkinObject = checkins.getJSONObject(checkinsCount-i-1);
        String checkinObject_firstname = checkinObject.getString("firstname");
        String checkinObject_lastname = checkinObject.getString("lastname");
        String checkinObject_timestamp = checkinObject.getString("checkin_timestamp");

        
        //define stroke
         stroke (0,0,0);
         strokeWeight(2);
         textAlign(LEFT);
        
         textFont(f,12);
          pushMatrix(); 
            translate(50,100); //set starting position for name labels
            translate(i*20,0); //offset each text label 20 pixels
            line(0,-40,0,-10); //draw marking lines
            rotate(PI/3);      //rotate text
            translate(5,0);    //set text labels in between marking lines
            text (checkinObject_firstname + " " + checkinObject_lastname + " (" + checkinObject_timestamp + ")", 0, 0); //draw text labels
          popMatrix();
      }

     }
      catch (JSONException e) {
      println ("There was an error parsing the JSONObject.");
    };


    //CAPTION
    fill (100,100,100);
    textFont(f,40);
    textAlign(CENTER);
    text ("Who is here right now?",width/2, height/2+200); 





}

