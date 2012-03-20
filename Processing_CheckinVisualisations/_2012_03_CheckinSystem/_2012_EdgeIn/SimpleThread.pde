/*source code for threading from http://wiki.processing.org/w/Threading */

SimpleThread pollingThread;

class SimpleThread extends Thread {

  boolean running;           // Is the thread running?  Yes or no?
  boolean available;
  boolean received;
  int wait;                  // How many milliseconds should we wait in between executions?
  String id;                 // Thread name
  int count;                 // counter
  String checkinData[];
  processing.net.Client c;

  // Constructor, create the thread
  // It is not running by default
  SimpleThread (String s, processing.net.Client client) {
    //wait = w;
    running = false;
    received = false;
    id = s;
    count = 0;
    this.c = client;
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
    while (received == false) {
      print(id + ": " + count + " -- ");
      count++;
      // Ok, let's wait for however long we should wait

      if (c.available() > 0) { // If there's incoming data from the client...
        String data = c.readString(); // ...then grab it and print it
        received = true;
        println(data);
      }
    }
    System.out.println(id + " thread is done!");  // The thread is done when we get to the end of run()
    received = false;
  }


  // Our method that quits the thread
  void quit() {
    System.out.println("Quitting."); 
    running = false;  // Setting running to false ends the loop in run()
    // IUn case the thread is waiting. . .
    interrupt();
  }

  boolean available() {
    return available;
  }

  void setAvailable(boolean b) {
    this.available = b;
  }

  String[] getCheckinData() {
    return checkinData;
  }
}

