/*
Reception de message et utilisation 
*/

import oscP5.*;
import netP5.*;
//nombre d'insectes
static int NUM_BUG = 10;
//declaration du tableau d'insecte
JitterBug bug[]= new JitterBug[NUM_BUG]; // Declare object
//background color
color background_color = color(0, 0, 0);
//Bugs Color
color bug_color;
float speed,angle;

OscP5 oscP5;
NetAddress myRemoteLocation;




void setup() {
  
  oscP5 = new OscP5(this,8000);
  myRemoteLocation = new NetAddress("127.0.0.1",8000);
  
  size(400, 400);
  smooth();
  //on cree les insectes avec une couleur differente par insecte
  for(int i=0;i<NUM_BUG;i++) {
    bug[i] = new JitterBug(0,0 , 20,color(random(255),random(255),random(255),random(255)));
  }
}
// pour chaque message recu on recupere l'enveloppe theOscMessage
void oscEvent(OscMessage theOscMessage) {
  //on lit l'adresse 
  String adress = theOscMessage.addrPattern();
  //en fonction de l'adresse on assigne le contenu de l'enveloppe � differente variables
  if (adress.equals("/speed")) {
    //eOscMessage.get(0).intValue() => premiere valeur (0) dans l'enveloppe et l'on specifie que c'est un entier
      speed = float(theOscMessage.get(0).intValue())/127.0*10;
  } else if(adress.equals("/angle")) 
      angle = float(theOscMessage.get(0).intValue())/127.0*PI*2;
  } else {
      println("adresse inconnu");
  };
  
}

void draw() {
  //on dessine le fond avec un alpha pour obtenir un "motion blur" 
  //dessin du fond
    noStroke();
    fill(background_color,5);
    rect(0, 0, width, height);
	//centrage des insectes
    translate(width/2,height/2); 
    pushMatrix();
	//on fait une rotation des insectes de angl
    rotate(angle);
   //Pour chaque insecte mise a jour et affichage 
    for(int i=0;i<NUM_BUG;i++) {
		bug[i].move(speed);
		bug[i].display();
  }
  popMatrix();
  translate(-width/2,-height/2);
  //on replace le contexte de dessin a sa place 
}
 // classe Insecte  
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
    x += random(-bugSpeed, bugSpeed);
    y += random(-bugSpeed, bugSpeed);
  }
  
  void display() {
    
    fill(c);
    ellipse(x, y, diameter, diameter);
  }
}


