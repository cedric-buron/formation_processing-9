import oscP5.*;
import netP5.*;
Boolean switchOsc = false;
OscP5 oscP5;
OscMessage myMessage;
OscMessage msgBoum = new OscMessage("/boum");
OscMessage msgtchack = new OscMessage("/tchack");
OscMessage mousePos = new OscMessage("/varisound");
NetAddress myRemoteLocation;

void setup() {
  size(400,400);
  frameRate(60);
  oscP5 = new OscP5(this,12000);
  myRemoteLocation = new NetAddress("127.0.0.1",8000);
}


void draw() {
  background(0);  
}

void mousePressed() {
  if(switchOsc) {
   myMessage = msgBoum;
  } else {
   myMessage = msgtchack; 
  }
  myMessage.add("bang");
  oscP5.send(myMessage, myRemoteLocation); 
  switchOsc = !switchOsc;
}

void mouseMoved() {
  mousePos = new OscMessage("/varisound");
  mousePos.add(mouseX/400.00);
  mousePos.add(mouseY/400.00);
  oscP5.send(mousePos,myRemoteLocation);
}
