/* 
Généralité :
OSC permet de communiquer via protocole UDP entre plusieurs applications sur le reseau local ou plus si affinité.
Vous pouvez appareiller votre mobile ou votre tablette à votre ordinateur (certaines app permettent de creer des interfaces graphiques pour piloter une application via OSC ( cf lemur, TouchOSC)
OSC fonctionne via un mécanisme d'enveloppe, vous spécifier une adresse comme /france/paris/rue_des_martyrs puis le ou les valeurs associés à cette adresse. vous pouvez placer plusieurs objets dans la boite aux lettres (entier, chaine de caractere float), 
une fois que vous considerez que l'enveloppe est pleine, vous envoyez l'enveloppe.
puis vous creez une "boite aux lettres" avec la même adresse, la boite au lettre vous notifie de la récéption ( execution d'un callback ) et vous pouvez récuperer ces données.

OSC necessite une adresse ip + un port d'écoute ou d'envoi, il suffit de spécifier le meme sur deux device pour que la communication se fasse
le 127.0.0.1 correspond a l'adresse de la machine en locale 
ce programme attends un click sur la fenetre de rendu pour envoyer alternativement à l'adresse boum puis à l'adresse tchack une chaine de caractere bang.
qui va etre ensuite récupéré par un programme pure data pour generer les deux sons correspondants.
*/

//les librairies gérant OSC 
import oscP5.*;
import netP5.*;

Boolean switchOsc = false;
//L'objet "facteur" (il s'occupe de l'envoi du message)
OscP5 oscP5;

//definition des "enveloppes"
//Une "enveloppe vide"
OscMessage myMessage;
//une enveloppe a l'adresse boum 
OscMessage msgBoum = new OscMessage("/boum");

//une enveloppe à l'adresse tchack
OscMessage msgtchack = new OscMessage("/tchack");

//le tuyau par laquelle va passer l'enveloppe 
NetAddress myRemoteLocation;

void setup() {
  size(400,400);
  frameRate(25);
  //on definit le facteur
  //8001 est le port de récéption des messages.
  oscP5 = new OscP5(this,8001);
  //on definit le tuyau
  //8000 est le port d'emission des messages
  //127.0.0.1 est l'adresse locale de la machine sur lequel le script tourne 
  //si l'on veut envoyer les messages sur une machine distante il faut recuperer l'adresse ip de la machine 
  myRemoteLocation = new NetAddress("127.0.0.1",8000);
}


void draw() {
  background(0);  
}

void mousePressed() {
  //a chaque click on envoie alternativement l'une ou l'autre enveloppe 
  if(switchOsc) {
     myMessage = msgBoum;
  } else {
     myMessage = msgtchack; 
  }
  //on place un message dans l'enveloppe
  myMessage.add("bang");
  //et on envoie l'enveloppe 
  oscP5.send(myMessage, myRemoteLocation); 
  switchOsc = !switchOsc;
}
