/* 
OSC permet de communiquer via protocole UDP entre plusieurs applications sur le reseau local ou plus si affinité.
OSC fonctionne via un mécanisme de boite à lettre, vous spécifier une adresse comme /france/paris/rue_des_martyrs puis le ou les valeurs associés à cette adresse.
OSC necessite une adresse ip + un port d'écoute ou d'envoi, il suffit de spécifier le meme sur deux device pour que la communication se fasse
le 127.0.0.1 correspond a l'adresse de la machine en locale 
ce programme attends un click sur la fenetre de rendu pour envoyer alternativement à l'adresse boum puis à l'adresse tchack une chaine de caractere bang.
qui va etre ensuite récupéré par un programme pure data pour generer les deux sons correspondants.
*/


import oscP5.*;
import netP5.*;
Boolean switchOsc = false;
OscP5 oscP5;
OscMessage myMessage;
OscMessage msgBoum = new OscMessage("/boum");
OscMessage msgtchack = new OscMessage("/tchack");
NetAddress myRemoteLocation;

void setup() {
  size(400,400);
  frameRate(25);
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
