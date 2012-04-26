import org.json.*;
String[] thumbnail_urls = {};


void setup() {
  size(1500,1000);
  background(102);
  smooth();
  
  XMLElement xml = new XMLElement(this, "http://www.goodreads.com/review/list.xml?v=2&per_page=200&key=1UlRnp4r9AT6HZh4oW4KAQ&id=7731700");
  XMLElement [] isbn = xml.getChildren("reviews/review/book/isbn13");
  
  

  for (int i = 0; i < isbn.length; i++) {
//      for (int i = 0; i < 1; i++) {
    String var = isbn[i].getContent();
    println(var);
    
    String URL = "https://www.googleapis.com/books/v1/volumes?q=ISBN:" + var + "&fields=items(id%2CvolumeInfo(authors%2CaverageRating%2Cdescription%2CimageLinks%2Ctitle))&pp=1&key=AIzaSyAit8lEBzxtGGlBpKaG2lziCZd3LSspjeU";
    try {
      JSONObject nytData = new JSONObject(join(loadStrings(URL), ""));
      JSONArray items = nytData.getJSONArray("items");
      JSONObject item = items.getJSONObject(0);
      //String id = item.getString("id");
      String title = item.getJSONObject("volumeInfo").getString("title");
      //String authors = item.getJSONObject("volumeInfo").getJSONArray("authors").getString(0); //gets only the first author
      //String description = item.getJSONObject("volumeInfo").getString("description");
      String thumbnail_url = item.getJSONObject("volumeInfo").getJSONObject("imageLinks").getString("thumbnail");
      //println ("id: " + id);
      println ("title: " + title);
      //println ("authors:" + authors);
      //println ("description:" + description);
      println ("thumbnail_url:" + thumbnail_url);
      
      thumbnail_urls = append(thumbnail_urls, thumbnail_url);

    }
    catch (JSONException e) {
      println ("There was an error parsing the JSONObject.");
    };
    
  }
  println(thumbnail_urls);


  
}


void draw() 
{
  PImage firstpic = loadImage(thumbnail_urls[1]);
  int x_nr = screen.width / (firstpic.width);
  println("Number of columns: " + x_nr);
  int y_nr = (thumbnail_urls.length / x_nr);
  println("Number of rows: " + y_nr);
  
  for (int j = 0; j < y_nr; j++){
      for (int i = 0; i < x_nr; i++) {
         PImage image_pic = loadImage(thumbnail_urls[i+j*i]);
         image(image_pic, i*image_pic.width, j*image_pic.height);
    }
  }
}



