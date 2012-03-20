import processing.net.*;


class Connection{

    PApplet p;
    processing.net.Client c;
    String data;
    String domain; 
    
    String rfid;
    Boolean dontdisturb;
//    String statusmessage;
//    String sublocation;
    SimpleThread sendThread;
    
    String addr; 
    
    Connection(PApplet p, String domain, String addr) {
            this.p = p;
            this.domain = domain;
            this.addr = addr;
            this.rfid = "222";
            //this.dontdisturb = true; 
	}


    void sendCheckin(String sublocation, String statusmessage) {
     
      String tail = "?statusmessage=" + URLEncode(statusmessage) + "&sublocation=" + sublocation + "&rfid=" + rfid; // + "&dontdisturb=" + dontdisturb;
      
      c = new processing.net.Client(p, domain, 80); // Connect to server on port 80 
      c.write("GET " + addr + tail + " HTTP/1.1\r\n"); // Can replace / with, eg., /reference/ or similar path
      c.write("Host: "+domain+"\r\n"); // Which server is asked
      c.write("User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Ubuntu/10.04 Chromium/10.0.648.205 Chrome/10.0.648.205 Safari/534.16\r\n");
      c.write("Accept: application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5\r\n");
      c.write("Accept-Language: en-us,en;q=0.5\r\n");
      c.write("Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7\r\n");
      c.write("\r\n");
      
      sendThread = new SimpleThread("sendThread", c);
      sendThread.start();
    
    } 
    
    
    String URLEncode(String string){
     String output = new String();
     try{
       byte[] input = string.getBytes("UTF-8");
       for(int i=0; i<input.length; i++){
         if(input[i]<0)
           output += '%' + hex(input[i]);
         else if(input[i]==32)
           output += '+';
         else
           output += char(input[i]);
       }
     }
     catch(UnsupportedEncodingException e){
       e.printStackTrace();
     }
    
     return output;
    }


}
