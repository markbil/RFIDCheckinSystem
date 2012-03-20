class ProjectExplorerApp {

  PersonCard[] persons; 

  ProjectExplorerApp(PApplet applet) {
    setup(applet);
  }

  void setup(PApplet applet) {
    XMLElement xml = new XMLElement(applet, "http://edgeqld.org.au/feed/");
//    XMLElement xml = new XMLElement(applet, "rss_in.xml");
    XMLElement[] items = xml.getChildren("channel/item");

    persons = new PersonCard[items.length]; 

    for (int i = 0; i < items.length; i++) {
      String title = items[i].getChild("title").getContent(); 
      println(title);
      XMLElement[] keywordsElems = items[i].getChildren("category");
      String[] keywords = new String[keywordsElems.length]; 
      for (int j = 0; j < keywordsElems.length; j++) {
        println("  - " + keywordsElems[j].getContent());
        keywords[j] = keywordsElems[j].getContent();
      }
      String content = items[i].getChild("content:encoded").getContent();
      String regexp = "<img.*(http.*[^\"]*jpg)";
      String imageUrl = "theedge.jpg";  
      String[] images = match(content, regexp); 
      if (images != null) {
        imageUrl = images[1];
      }

      persons[i] = new PersonCard(title, keywords, imageUrl);
    }
  }

  void draw() {
    for (int i = 0; i < persons.length; i++) {
      persons[i].draw();
    }
  }
}

class PersonCard extends GUI {
  PersonCard(String title, String[] keywords, String imageUrl) {
    ProjectImage image = new ProjectImage(imageUrl); 
    setBoundaries(image.img.width, image.img.height); 
    addWidget(image); 
    
    Label label = new Label(title); 
    label.setTranslation(0, image.img.height / 2.0 + 25);
    label.setFont(createFont("Arial", 28)); 
    label.textColor = color(0, 10, 20);  
    addWidget(label);     
    createManipulator(this);
    
    setTranslation(random(-width/2, width/2), random(-height/2, height/2)); 
    setScale(0.4); 
    setRotation(random(-PI/4, +PI/4)); 
  }

  float shear = 0.0;
   
  
  void drawWidget() {
    rotateX(shear); 
    shear += PI / 1024;
    super.drawWidget();  
  }

  class ProjectImage extends ImageWidget {
    ProjectImage(String file) {
      super(file);
    }

    void addCursor(MTCursor c) {
      c.setTarget(container);
      container.addCursor(c);
    }
  }
}

