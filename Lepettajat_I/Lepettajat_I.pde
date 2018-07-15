Mover [] movers;
Bloomer [] bloomers;
float centX;
float centY;
float easing = 0.005;
int moversQ;
float timeSinceAdd = 0;

void setup () {
  fullScreen ();
  //size (1600, 900);
  background (0);
  frameRate (24);
  smooth ();
  
  centX = width / 2;
  centY = height / 2;
  
  moversQ = 10;
  int variance = 300;
  float moverRad = 10;
  
  movers = new Mover [moversQ];
  bloomers = new Bloomer [0];
  
  int i = 0;
  for (int ang = 0; i < movers.length; ang += 360 / moversQ) {
    float rad = radians (ang);
    float xPos = centX + (cos(rad)) * variance;
    float yPos = centY + (sin(rad)) * variance;
    movers [i] = new Mover (xPos, yPos, moverRad);
    i++;
  }
}

void draw () {
  background (0);
  for (int i = 0; i < movers.length; i++) {
    movers[i].Update ();   
  }
  for (int i = 0; i < bloomers.length; i++) {
    bloomers [i].Update ();
  }
}
