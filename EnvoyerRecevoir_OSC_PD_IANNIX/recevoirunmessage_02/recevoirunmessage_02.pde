import oscP5.*;
import netP5.*;

static int NUM_BUG = 10;
JitterBug bug[]= new JitterBug[NUM_BUG]; // Declare object
JitterBug bug1; // Declare object
color c1 = color(0, 0, 0);
color c2;
float speed,angle,decalageX,decalageY;

OscP5 oscP5;
NetAddress myRemoteLocation;




void setup() {
  
  oscP5 = new OscP5(this,8000);
  myRemoteLocation = new NetAddress("127.0.0.1",8000);
  
  size(400, 400);
  smooth();
 
  for(int i=0;i<NUM_BUG;i++) {
    bug[i] = new JitterBug(0,0 , 20,c2);
    bug[i].c = color(random(255),random(255),random(255),random(255));
  }
}

void oscEvent(OscMessage theOscMessage) {
  
  String adress = theOscMessage.addrPattern();
  
  if (adress.equals("/slider1")) {
      speed = float(theOscMessage.get(0).intValue())/127.0*10;
  } else if(adress.equals("/slider2")) {
      angle = float(theOscMessage.get(0).intValue())/127.0*PI*2;
  } else if (adress.equals("/trigger")) {
      decalageX = theOscMessage.get(0).floatValue();
      decalageY = theOscMessage.get(1).floatValue();
      speed=1;      
  };
  
}

void draw() {

  noStroke();
  
  fill(c1,5);

    rect(0, 0, width, height);
    translate(width/2,height/2); 
    pushMatrix();
    
    rotate(angle);
  for(int i=0;i<NUM_BUG;i++) {
    bug[i].move(speed);
    bug[i].display();
  }
  
  popMatrix();
  translate(-width/2,-height/2);
}
  
  class JitterBug {
  float x;
  float y;
  int diameter;
  color c;
  float bugSpeed = 1;
  
  JitterBug(float tempX, float tempY, int tempDiameter, color col) {
    x = tempX;
    y = tempY;
    c = col;
    diameter = tempDiameter;
  }
  
  void move(float newSpeed) {
    bugSpeed = newSpeed;
    x += random(-bugSpeed, bugSpeed)+decalageX/2;
    y += random(-bugSpeed, bugSpeed)+decalageY/2;
  }
  
  void display() {
    
    fill(c);
    ellipse(x, y, diameter, diameter);
  }
}


