import oscP5.*;
import netP5.*;
Boolean switchOsc = false;
OscP5 oscP5;
NetAddress myRemoteLocation;
int val = 0;

void setup() {
  size(400,400);
  frameRate(25);
  oscP5 = new OscP5(this,8000);
  myRemoteLocation = new NetAddress("127.0.0.1",8000);
  oscP5.plug(this,"ctlin","/ctlin");
}


void draw() {
  background(0);  
  fill(color(255,255,255));
  translate(val,0);
  rect(0,0,10,10);
}

public void ctlin(int value, int controler_number, int channel) {
  println("channel : "+channel+":: controler number : "+controler_number+":: value : "+value);
  val = value;
}



