// One electron points toward target
// One electron points toward/away wind
// Electrons represent direction of forces

// depth

Atomi [] atomit;
float centX;
float centY;
PVector wind;

void setup () {
  fullScreen ();
  //size (1600, 900);
  background (0);
  frameRate (60);
  smooth ();
  
  centX = width / 2;
  centY = height / 2;
  
  atomit = new Atomi [6];
  
  wind = new PVector (0, 0);
  
  int i = 0;
  for (int ang = 0; i < atomit.length; ang += 60) {
    float rad = radians (ang);
    float xPos = centX + cos(rad) * (height * (1.618/4));
    float yPos = centY + sin(rad) * (height * (1.618/4));
    atomit [i] = new Atomi (xPos, yPos);
    i++;
  }
}

void draw () {
  background (0);
  
  if (frameCount % 360 == 0) {
    wind = PVector.random2D();
    wind.mult(random (-500, 500));
  }
  
  for (Atomi atomi : atomit) {
    atomi.ApplyForce(wind);
    atomi.Update ();
    atomi.Draw ();
  }
}
