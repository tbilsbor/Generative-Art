// FIX: brightness not always reciprocal

// Add randomness to raindrops (size and interval)
// Slight push away when radius crosses lepettaja

Lepettaja [] lepettajat;
Raindrop [] raindrops;
float centX;
float centY;
float phi = 0.618;
float pulseNoise = 0;
float dropNoise = 0;

void setup () {
  //size (800, 600);
  //size (1600, 900);  
  fullScreen ();
  background (0);
  frameRate (60);
  smooth ();
  
  centX = width / 2;
  centY = height /2;
  
  lepettajat = new Lepettaja [6];
  raindrops = new Raindrop [0];
  
  int i = 0;
  for (int ang = 0; i < lepettajat.length; ang += 60) {
    float rad = radians (ang);
    float xPos = centX + cos(rad) * (height * (phi/3));
    float yPos = centY + sin(rad) * (height * (phi/3));
    lepettajat [i] = new Lepettaja (xPos, yPos);
    i++;
  }
}

void draw () {
  background (0);
  
  pulseNoise = sin (frameCount / 6);
  float pulse = sin ((float) frameCount / (6 + pulseNoise)) * 8;
  
  if (frameCount % (600 + dropNoise) == 0) {
    raindrops = (Raindrop []) append (raindrops, new Raindrop (random (width * 1.5), random (height * 1.5)));
    for (Lepettaja lepettaja : lepettajat) {
      if (PVector.dist(lepettaja.location, raindrops [raindrops.length - 1].location) < 100) {
        lepettaja.flit = true;
        lepettaja.flitTarget = raindrops [raindrops.length - 1].location;
        lepettaja.flitCounter = millis();
      }
    }
    dropNoise = (int) random (200) - 100;
  }
  
  for (Lepettaja lepettaja : lepettajat) {
    if ((int) random (600) == 1) {
      lepettaja.flit = true;
      lepettaja.flitTarget = new PVector (random (width), random (height));
      lepettaja.flitCounter = millis();
    }
    if (lepettaja.flit == true) {
      lepettaja.Flit();
    } else {
      lepettaja.Drift();
    }
    lepettaja.Draw (pulse);
  }
  
  for (Raindrop raindrop : raindrops) {
    if (raindrop.active == true) {
      raindrop.Update();
      raindrop.Draw();
    }
  }
}
