Bluetooth bt;
ArrayList clients = new ArrayList();
ArrayList images = new ArrayList();
PApplet papplet;

// image display properties
final int IMAGE_HEIGHT = 200;
final int IMAGE_WIDTH = 200;
final int IMAGE_BORDER = 10;

class MTBluetooth extends Bluetooth {
  GUI container; 
  MTBluetooth(PApplet parent, String UUID, GUI container) {
    super(parent, UUID); 
    this.container = container;
  }

  void clientConnectEvent(bluetoothDesktop.Client c) {
    super.clientConnectEvent(c); 
    clients.add(new ImageClient(c, container));
    println("new client: " + c.device.name);
  }
}

class BluetoothServerGUI extends GUI {

  BluetoothServerGUI(PApplet parent) {

    try {
      bt = new MTBluetooth(parent, "57f1d57d4bf54ff8b25e70e60adf9fbc", this); 
      bt.start("imageServer");  // Start the service
    } 
    catch (RuntimeException e) {
      println("bluetooth device is not available. (or license problem if using avetana)"); 
      println(e);
    }
    papplet = parent;
  }

  void drawWidget() {

    // update all the clients
    for (int i=0; i< clients.size(); i++) {
      ((ImageClient) clients.get(i)).update();
    }

    // draw all the images
    for (int i=0; i< images.size(); i++) {
      ((ImageHandler) images.get(i)).draw();
    }

    super.drawWidget();
  }
}


/*****************************************************
 *
 * Class ImageClient
 * handles the connection to the bluetooth client
 *
 *****************************************************/

class ImageClient {

  bluetoothDesktop.Client bluetoothClient;         // the bluetooth client
  ImageHandler currentImage;      // holds the image that is currently being loaded
  boolean loadingImage = false;   // if we are currently loading an image
  GUI container; 

  ImageClient(bluetoothDesktop.Client bluetoothClient, GUI container) {
    this.bluetoothClient = bluetoothClient;
    this.container = container; 
  } 

  void update() {
    if (loadingImage) {
      // we are loading an image, so check for new bytes
      int nrBytes = bluetoothClient.available();
      if (nrBytes>0) {
        println("reading " + nrBytes + " bytes"); 
        byte[] inBytes = new byte[nrBytes];
        bluetoothClient.readBytes(inBytes);
        // send the new Bytes to the Image-object
        loadingImage = ! currentImage.addBytes(inBytes);
      }
    } 
    else {
      // we're not yet loading an image, so check for an int 
      // the mobile phone sends the nr of bytes of the new image, if there is one
      if (bluetoothClient.available() > 0) {
        int expected = bluetoothClient.readInt(); 
        println("Expect to read " + expected + " bytes"); 
        currentImage = new ImageHandler(expected, bluetoothClient.device.name);
        //images.add(currentImage);
        container.addWidget(currentImage);
        loadingImage = true;
      }
    }
  }
}

/*****************************************************
 *
 * Class ImageHAndler
 * stores & displays a received image
 *
 *****************************************************/

class ImageHandler extends Widget {

  private PGraphics myRenderer;
  private PImage myImage;
  private int byteSize;
  private int loadedBytes;
  private boolean loaded = false;
  private byte[] imageBytes;
  String name; 

  ImageHandler(int byteSize, String name) {
    super(0, 0); 
    this.byteSize = byteSize;
    this.name = name;
    myImage = createImage(100, 100, RGB);
    myRenderer = createGraphics(IMAGE_WIDTH, IMAGE_HEIGHT, JAVA2D);
    imageBytes = new byte[0];

    setBoundaries(IMAGE_WIDTH, IMAGE_HEIGHT); 
//    if (MULTITOUCH_MODE) {
//      new ManipulationAnimator(this);
//    } 
//    else {
//      new SingleTouchAnimator(this);
//    }
      createManipulator(this);
  } 

  void drawWidget() {
    translate(-myImage.width / 2.0, -myImage.height / 2.0); 
    image(myImage, 0, 0, myImage.width, myImage.height);
    noFill(); 
    rectMode(CORNERS); 
    stroke(0, 0, 255); 
    rect(0, 0, myImage.width, myImage.height); 
  }

  void onTouch() {
    super.onTouch();
  }

  // adds the new bytes to the byte-array
  // returns true if the image was loaded completely
  // returns false if the image is not yet loaded
  boolean addBytes(byte[] newBytes) {
    // add new bytes to our byte-array
    for (int i=0; i< newBytes.length; i++ ) {
      imageBytes = (byte[]) append(imageBytes, newBytes[i]);
    }

    // draw the loading progress in my renderer
    myRenderer.beginDraw();
    myRenderer.background(0);
    myRenderer.noFill();
    myRenderer.stroke(255);
    myRenderer.rect(0, 0, IMAGE_WIDTH, IMAGE_HEIGHT);
    myRenderer.rect(5, IMAGE_HEIGHT-10, IMAGE_WIDTH-10, 5);
    myRenderer.fill(255);
    myRenderer.rect(5, IMAGE_HEIGHT-10, map(imageBytes.length, 0, byteSize, 0, IMAGE_WIDTH), 5);
    myRenderer.endDraw();

    // get the image from the renderer
    myImage = myRenderer;

    // is the image loaded completely?
    if (imageBytes.length == byteSize) {
      myImage = bytesToPImage(imageBytes);
      loaded = true;
      setBoundaries(myImage.width, myImage.height); 
      println(name + " sent " + round(byteSize/1024.0) + " kB");
      return true;
    }
    return false;
  }

  // takes an array of bytes and creates a PImage from it.
  // seen here: http://processing.org/discourse/yabb_beta/YaBB.cgi?board=Integrate;action=display;num=1134385140
  PImage bytesToPImage(byte[] bytes) {
    Image awtImage = java.awt.Toolkit.getDefaultToolkit().createImage(bytes);
    java.awt.MediaTracker tracker = new java.awt.MediaTracker(papplet);
    tracker.addImage(awtImage, 0);
    try {
      tracker.waitForAll();
    } 
    catch (InterruptedException e) {
    }
    PImage newPImage = new PImage(awtImage);
    return newPImage;
  }
}

