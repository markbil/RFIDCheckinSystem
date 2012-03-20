String[] image_urls = {};


void setup() {
  size(1500,1000);
  background(102);
  smooth();
  
  XMLElement xml = new XMLElement(this, "http://www.goodreads.com/review/list.xml?v=2&per_page=200&key=1UlRnp4r9AT6HZh4oW4KAQ&id=7731700");
  XMLElement [] images = xml.getChildren("reviews/review/book/image_url");
  
  

  for (int i = 0; i < images.length; i++) {
    String image_url = images[i].getContent();
    image_urls = append(image_urls, image_url);
  }
  println(image_urls);
  noLoop();

  
}


void draw() 
{
  
  PImage firstpic = loadImage(image_urls[1]);
  int x_nr = screen.width / (firstpic.width + 20);
  println("Number of columns: " + x_nr);
  int y_nr = (image_urls.length / x_nr);
  println("Number of rows: " + y_nr);
  
  for (int j = 0; j < y_nr; j++){
      for (int i = 0; i < x_nr; i++) {
         PImage image_pic = loadImage(image_urls[i+j*i]);
         image(image_pic, i*image_pic.width, j*image_pic.height);
    }
  }
  
}



