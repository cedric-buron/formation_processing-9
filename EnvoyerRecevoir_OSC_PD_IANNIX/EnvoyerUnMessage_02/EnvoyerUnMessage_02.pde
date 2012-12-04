/* 
cette application envoie les coordonnées de la souris normalisé x entre 0 et 1 et y entre 0 et 1 et envoie ces deux messages dans l'enveloppe à l'adresse varisound
*/

//Import librairie
import oscP5.*;
import netP5.*;

Boolean switchOsc = false;

OscP5 oscP5;
OscMessage myMessage;
OscMessage msgBoum = new OscMessage("/boum");
OscMessage msgtchack = new OscMessage("/tchack");
//enveloppe pour les coordonnées de la souris
OscMessage mousePos = new OscMessage("/varisound");
NetAddress myRemoteLocation;

void setup() {
  size(400,400);
  frameRate(60);
  oscP5 = new OscP5(this,8001);
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
/*
on recupere la position X/Y de la souris et on l'envoie 
*/
void mouseMoved() {
  mousePos = new OscMessage("/varisound");
  //on place les deux messages dans la meme enveloppe
  mousePos.add(mouseX/400.00);
  mousePos.add(mouseY/400.00);
  // et on envoie 
  oscP5.send(mousePos,myRemoteLocation);
}
