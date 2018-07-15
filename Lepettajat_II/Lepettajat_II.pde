Lepettaja [] lepettajat;
float centX;
float centY;
float phi = 0.618;
float pulseNoise = 0;

void setup () {
  //size (1600, 900);
  fullScreen ();
  background (0);
  frameRate (60);
  smooth ();
  
  centX = width / 2;
  centY = height / 2;
  
  lepettajat = new Lepettaja [6];
  
  int i = 0;
  for (int ang = 0; i < lepettajat.length; ang += 60) {
    float rad = radians (ang);
    float xPos = centX + cos(rad) * (height * phi/3);
    float yPos = centY + sin(rad) * (height * phi/3);
    lepettajat [i] = new Lepettaja (xPos, yPos);
    i++;
  }
}

void draw () {
  
  background (0);
  
  pulseNoise = sin (frameCount / 6);
  
  for (Lepettaja lepettaja : lepettajat) {
    float pulse = sin ((float) frameCount / (6 + pulseNoise)) * 8;
    lepettaja.Drift();
    lepettaja.Draw(pulse);
  }  
}
