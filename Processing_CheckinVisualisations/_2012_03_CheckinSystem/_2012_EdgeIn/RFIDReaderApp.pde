import processing.serial.*;
Serial myPort;  
String inString;

class RFIDReaderApp {
  ContainerScreen containerScreen;
  FirstScreen firstScreen;
  SecondScreen secondScreen;
  PApplet applet;
  GUI activeScreen;
  
  boolean writingToDB;
  SimpleThread_RFIDReaderApp thread_readRFIDcard;
  int screenTime = 5000; //time after each checkin the welcome screen (secondscreen) should be up before returning to standbyscreen (firstscreen)

  
  RFIDReaderApp(PApplet applet) {
    this.applet = applet;
    setup(applet);
  }

  void setup(PApplet applet) {
    
    myPort = new Serial(applet, Serial.list()[0], 9600);
    myPort.bufferUntil('\n');
    
    writingToDB = false;
    
    containerScreen = new ContainerScreen();
    firstScreen = new FirstScreen();
    
    
    containerScreen.addWidget(firstScreen);
    activeScreen = firstScreen;
  }
  
  void draw() {
    containerScreen.draw();  
      
  }
  
  
  GUI getActiveScreen(){
    return this.activeScreen;
  }  
  boolean getWritingToDB(){
    return this.writingToDB;
  } 
  void setWritingToDB(boolean b){
    this.writingToDB = b;
  } 
  void setActiveScreen(GUI gui){
    this.activeScreen = gui;
  }  
  ContainerScreen getContainerScreen(){
    return this.containerScreen;
  }
  FirstScreen getFirstScreen(){
    return this.firstScreen;
  }
  SecondScreen getSecondScreen(){
    return this.secondScreen;
  }
  void setSecondScreen(SecondScreen ss){
    this.secondScreen = ss;
  }   
  int getScreenTime(){
    return this.screenTime;
  }
 SimpleThread_RFIDReaderApp getThread_readRFIDcard(){
   return this.thread_readRFIDcard;
 }
 void setThread_readRFIDcard(SimpleThread_RFIDReaderApp st){
   this.thread_readRFIDcard = st;
 }
 
}


//serialEvent is called everytime an RFID-card touches the Reader...
void serialEvent (Serial myPort) {
  inString = myPort.readStringUntil('\n');
    if (inString != null) {    
        inString = trim(inString); // trim off any whitespace:
        println("Reading RFID: " + inString);
        
        //Only allow checkin if DB is not busy writing previous Checkin...
        if (rfidReaderApp.getWritingToDB()){
          println("Checkin not possible at the moment, busy checking someone else in...");
          println("writing to DB:" +  rfidReaderApp.getWritingToDB());
        }
        else {
          rfidReaderApp.setWritingToDB(true);
   
          //PERFOM CHECKIN TO DB
          String checkin_url = "http://" + host_server + "/TheEdge_VisitorProfiles/checkin_submit_manual.php?thirdpartyid=" + inString;
          String checkin_result[] = loadStrings(checkin_url);
          
          
          //Debugging: print entire response from mysql/php request
//          for (int i=0; i < checkin_result.length; i++) {
//            println("php responseline " + i + ": " + checkin_result[i]);
//          }
          String[] failorsuccess_temp = split(checkin_result[0],"***"); //FAIL or SUCCESS indicates if mysql/php checkin was successful
          String failorsuccess = failorsuccess_temp[1];
          String[] response_parameters_temp = split(checkin_result[0],"+++"); //parameters
          String response_parameters = response_parameters_temp[1];
          
          

           
          //CONTROL SCREEN FLOW        
          //THREADS only used to control screen flow...
          //when user touches RFID card default "firstscreen" is replaced by a welcome screen (secondscreen)
          
          //in case a user touches the RFID reader and a previous users Welcome Screen (SecondScreen) is still on, first thread is quited and new thread to display secondscreen is created
          if(rfidReaderApp.getThread_readRFIDcard() != null){
            rfidReaderApp.getThread_readRFIDcard().quit();
            rfidReaderApp.setThread_readRFIDcard(null);
          }
         
         
          String[] parameters={failorsuccess, response_parameters};
          println("Parameters received from MySQL/PHP: ***" + parameters[0] + "*** / +++" + parameters[1] + "+++");
          
          rfidReaderApp.setThread_readRFIDcard(new SimpleThread_RFIDReaderApp(rfidReaderApp.getScreenTime(),"thread_readRFIDcard-" + inString, rfidReaderApp, parameters));
          rfidReaderApp.getThread_readRFIDcard().start();
            
          rfidReaderApp.setWritingToDB(false);
        }  
 }  
}

class ContainerScreen extends GUI{
  
}

class FirstScreen extends GUI{

  FirstScreen(){
    

    PFont welcome1_font = loadFont("HelveticaNeue-Bold-48.vlw");
    PFont welcome2_font = loadFont("HelveticaNeue-24.vlw");
    

    Label edgein_lg = new Label("EdgeIn!"); 
    edgein_lg.setTranslation(0, -(height/4));
    edgein_lg.setFont(welcome1_font); 
    edgein_lg.textColor = color(0, 10, 20);  
    addWidget(edgein_lg);
    
    
    Label msg1 = new Label("Please touch the red dot with your Edge card!"); 
    msg1.setTranslation(0, 0);
    msg1.setFont(welcome2_font); 
    msg1.textColor = color(0, 10, 20);  
    addWidget(msg1);
    
    setTranslation(-width/2, -height/2);
    
  }

}

class SecondScreen extends GUI{
   
  SecondScreen(String[] parameters){
    PFont welcome1_font = loadFont("HelveticaNeue-Bold-48.vlw");
    PFont welcome2_font = loadFont("HelveticaNeue-24.vlw");    
    PFont name_font = loadFont("BrushScriptStd-100.vlw");

    if(parameters[0].equals("SUCCESS")){ //Checkin successful, i.e. SecondScreen to display welcoming message with user's name 
      Label edgein_lg = new Label("Welcome to The Edge, ");
      edgein_lg.setTranslation(0, -(height/4));
      edgein_lg.setFont(welcome1_font);    
      edgein_lg.textColor = color(0, 10, 20);  
      addWidget(edgein_lg);
     
      Label name_lg = new Label(parameters[1] + "!");
      name_lg.setTranslation(0, -(height/4)+100);
      name_lg.setFont(name_font);    
      name_lg.textColor = color(0, 10, 20);  
      addWidget(name_lg);
      
      Label text_lb = new Label("You're checked in at The Edge");
      text_lb.setTranslation(0, 0+50);
      text_lb.setFont(welcome2_font); 
      text_lb.textColor = color(0, 10, 20);  
      addWidget(text_lb);
      
    }
    else if(parameters[0].equals("FAIL")){ //Checkin not successful, i.e. SecondScreen to display error message 
  
      Label headline_lg = new Label("Warning!");
      headline_lg.setTranslation(0, -(height/4));
      headline_lg.setFont(welcome1_font); 
      headline_lg.textColor = color(0, 10, 20);  
      addWidget(headline_lg);
      
      Label text_lb = new Label(parameters[1]);
      text_lb.setTranslation(0, 0);
      text_lb.setFont(welcome2_font); 
      text_lb.textColor = color(0, 10, 20);  
      addWidget(text_lb);
    }
    
    
    setTranslation(-width/2, -height/2);
  }
}

class SimpleThread_RFIDReaderApp extends Thread {
 
  boolean running;           // Is the thread running?  Yes or no?
  int wait;                  // How many milliseconds should we wait in between executions?
  String id;                 // Thread name
  int count;                 // counter
  RFIDReaderApp rfidReaderApp;
  
  String[] parameters;
   
  // Constructor, create the thread
  // It is not running by default
  SimpleThread_RFIDReaderApp (int w, String s, RFIDReaderApp rfidReaderApp, String[] parameters) {
    wait = w;
    running = false;
    id = s;
    count = 0;
    this.rfidReaderApp = rfidReaderApp;
    
    this.parameters = parameters;
  }
 
  int getCount() {
    return count;
  }
 
  // Overriding "start()"
  void start () {
    // Set running equal to true
    running = true;
    // Print messages
    println("STARTING THREAD: " + id); 
    // Do whatever start does in Thread, don't forget this!
    super.start();
  }
 
 
  // We must implement run, this gets triggered by start()
  void run () {
    while (running) {
      println("running thread: " + id + " / count: " + count);
      
        //THREADS only used to control screenflow
        //each new thread removes the firstscreen and adds the secondscreen (welcoming the checked-in user)
        //when the thread is quited (after wait-time seconds or if quited manually), secondscreen is removed and firstscreen added
        if(rfidReaderApp.getActiveScreen() == rfidReaderApp.getFirstScreen()){
          rfidReaderApp.getContainerScreen().removeWidget(rfidReaderApp.getFirstScreen());
          rfidReaderApp.setSecondScreen(new SecondScreen(parameters));
          rfidReaderApp.getContainerScreen().addWidget(rfidReaderApp.getSecondScreen());
          
          rfidReaderApp.setActiveScreen(rfidReaderApp.getSecondScreen()); //update active Screen
        }
        
      count++;
      
      // Ok, let's wait for however long we should wait
      try {
        sleep((long)(wait));
        quit();

        
      } catch (Exception e) {
      }
    }
    System.out.println("QUITTED THREAD: " + id);  // The thread is done when we get to the end of run()
  }
 
 
  // Our method that quits the thread
  void quit() {
    System.out.println("Quitting " + id);
   
    rfidReaderApp.getContainerScreen().removeWidget(rfidReaderApp.getSecondScreen());
    rfidReaderApp.getContainerScreen().addWidget(rfidReaderApp.getFirstScreen());
    rfidReaderApp.setActiveScreen(rfidReaderApp.getFirstScreen()); //update active Screen
    rfidReaderApp.setThread_readRFIDcard(null);
    
    running = false;  // Setting running to false ends the loop in run()
    // IUn case the thread is waiting. . .
    interrupt();
    

  }
}

