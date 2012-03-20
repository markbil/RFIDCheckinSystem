class ImageWidget extends Widget {
  PImage img;
  ImageWidget(String file) {
    super(0,0);
    img = loadImage(file);
    setBoundaries(img.width, img.height); 
//    if (MULTITOUCH_MODE) {
//      new ManipulationAnimator(this); 
//    } else {
//      new SingleTouchAnimator(this);
//    }
    createManipulator(this);
  }
  
  
  void drawWidget() {
    image(img, -img.width/2, -img.height/2);
    rectMode(CENTER); 
    noFill(); 
    stroke(0);
    rect(0, 0, img.width, img.height); 
  }
  
}
