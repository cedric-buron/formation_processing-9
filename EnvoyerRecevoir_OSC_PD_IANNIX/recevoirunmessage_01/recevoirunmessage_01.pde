import oscP5.*;
import netP5.*;

static int NUM_BUG = 10;
JitterBug bug[]= new JitterBug[NUM_BUG]; // Declare object
JitterBug bug1; // Declare object
color c1 = color(0, 0, 0);
color c2;
float spd,angl;

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
      println("slider 1");
      println("value : "+theOscMessage.get(0).intValue());
      spd = float(theOscMessage.get(0).intValue())/127.0*10;
      println(spd);
  } else if(adress.equals("/slider2")) {
      println("slider 2");
      println("value : "+theOscMessage.get(0).intValue());
      angl = float(theOscMessage.get(0).intValue())/127.0*PI*2;
  } else {
      println("slider inconnu");
  };
  
}

void draw() {

  noStroke();
  
  fill(c1,5);

    rect(0, 0, width, height);
    translate(width/2,height/2); 
    pushMatrix();
    
    rotate(angl);
  for(int i=0;i<NUM_BUG;i++) {
    bug[i].move(spd);
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
  float speed = 1;
  
  JitterBug(float tempX, float tempY, int tempDiameter, color col) {
    x = tempX;
    y = tempY;
    c = col;
    diameter = tempDiameter;
  }
  
  void move(float newSpeed) {
    speed = newSpeed;
    x += random(-speed, speed);
    y += random(-speed, speed);
  }
  
  void display() {
    
    fill(c);
    ellipse(x, y, diameter, diameter);
  }
}


