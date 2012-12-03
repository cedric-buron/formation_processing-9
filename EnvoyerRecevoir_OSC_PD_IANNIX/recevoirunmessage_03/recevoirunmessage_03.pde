import oscP5.*;
import netP5.*;
Boolean switchOsc = false;
OscP5 oscP5;
NetAddress myRemoteLocation;

void setup() {
  size(400,400);
  frameRate(25);
  oscP5 = new OscP5(this,8000);
  myRemoteLocation = new NetAddress("127.0.0.1",8000);
  oscP5.plug(this,"boum","/boum");
  oscP5.plug(this,"tchack","/tchack");
}


void draw() {
  background(0);  
}

public void boum(String what) {
  println("Boum :"+what);
}
public void tchack(String what) {
  println("Tchack :"+what);
}


