import java.util.Iterator;

float centX;
float centY;

// Arrays for the bugs (luteet)
ArrayList<Kieppuja> kieppujat; // Oscillating cross bugs; eat the kirput
ArrayList<Kirppu> kirput; // Drifting krill
ArrayList<KuplaSysteemi> kuplaSysteemit; // Particle system for death
ArrayList<Lude> luteet; // Tracking all the lude
ArrayList<Raindrop> raindrops;
ArrayList<Tappaja> tappajat; // Competitive hunters

void setup () {
  //size (1600, 900);
  fullScreen ();
  background (0);
  frameRate (60);
  smooth ();
  
  centX = width / 2;
  centY = height / 2;
  
  // Initialize kieppujat
  kieppujat = new ArrayList<Kieppuja> ();
  float xPos = 1;
  float yPos = 1;
  while (xPos > 0 && xPos < width) {
    xPos = map (random (1), 0, 1, -width, width * 2);
  }
  while (yPos > 0 && yPos < height) {
    yPos = map (random (1), 0, 1, -height, height * 2);
  }
  for (int i = 1; i < Kieppuja.init; i++) {
    kieppujat.add(new Kieppuja (xPos, yPos));
  }
  
  // Initialize kirput
  kirput = new ArrayList<Kirppu> ();
  for (int i = 0; i <= Kirppu.init; i++) {
    xPos = map (random (1), 0, 1, 0, width);
    yPos = map (random (1), 0, 1, 0, height);
    kirput.add(new Kirppu (xPos, yPos));
  }
  
  // Initialize tappajat
  tappajat = new ArrayList<Tappaja> ();
  
  // Initialize kuplaSysteemit
  kuplaSysteemit = new ArrayList<KuplaSysteemi> ();
  
  // Initialize ludeet
  luteet = new ArrayList<Lude>();
  
  // Initialize raindrops
  raindrops = new ArrayList<Raindrop> ();
  
}

void draw () {
  
  background (0);
  
  // Chance to generate new kieppuja (offscreen)
  if ((int) random (Kieppuja.chance) == 1 && kieppujat.size() < Kieppuja.max) {
    float xPos = 1;
    float yPos = 1;
    while (xPos > 0 && xPos < width) {
      xPos = map (random (1), 0, 1, -width, width * 2);
    }
    while (yPos > 0 && yPos < height) {
      yPos = map (random (1), 0, 1, -height, height * 2);
    }
    kieppujat.add(new Kieppuja (xPos, yPos));
  }
  
  // Chance to generate new tappaja (offscreen)
  if ((int) random (Tappaja.chance) == 1 && tappajat.size() < Tappaja.max) {
    float xPos = 1;
    float yPos = 1;
    while (xPos > 0 && xPos < width) {
      xPos = map (random (1), 0, 1, -width, width * 2);
    }
    while (yPos > 0 && yPos < height) {
      yPos = map (random (1), 0, 1, -height, height * 2);
    }
    tappajat.add(new Tappaja (xPos, yPos));
  }
  
  // Chance to generate new kirppu
  if ((int) random (Kirppu.chance) == 1 && kirput.size() < Kirppu.max) {
    float xPos = map (random (1), 0, 1, 0, width);
    float yPos = map (random (1), 0, 1, 0, height);
    kirput.add(new Kirppu (xPos, yPos));
  }
  
  // Chance for a raindrop
  if ((int) random (Raindrop.chance) == 1) {
    raindrops.add(new Raindrop (random (width * 1.5), random (height * 1.5)));
  }
  
  // Run the kirput
  Iterator<Kirppu> iKirput = kirput.iterator ();
  while (iKirput.hasNext ()) {
    Kirppu kirppu = iKirput.next ();
    if (kirppu.isDead ()) {
      iKirput.remove();
    }
    kirppu.decide ();
    kirppu.act ();
    kirppu.draw ();
  }
  
  // Run the kieppujat
  Iterator<Kieppuja> iKieppujat = kieppujat.iterator ();
  while (iKieppujat.hasNext ()) {
    Kieppuja kieppuja = iKieppujat.next ();
    if (kieppuja.isDead ()) {
      iKieppujat.remove();
    }
    kieppuja.decide ();
    kieppuja.act ();
    kieppuja.draw ();
  }
  
  // Run the tappajat
  Iterator<Tappaja> iTappajat = tappajat.iterator ();
  while (iTappajat.hasNext ()) {
    Tappaja tappaja = iTappajat.next ();
    if (tappaja.isDead ()) {
      iTappajat.remove ();
    }
    tappaja.decide ();
    tappaja.act ();
    tappaja.draw ();
  }
  
  // Run the kupla systems
  Iterator<KuplaSysteemi> ksIter = kuplaSysteemit.iterator ();
  while (ksIter.hasNext ()) {
    KuplaSysteemi ks = ksIter.next ();
    if (ks.isDead ()) {
      ksIter.remove ();
    }
    ks.update ();
  }
  
  // Run the raindrops
  Iterator<Raindrop> raindropIter = raindrops.iterator ();
  while (raindropIter.hasNext ()) {
    Raindrop rd = raindropIter.next ();
    if (rd.isDone ()) {
      raindropIter.remove ();
    }
    rd.update ();
    rd.draw ();
  }
  
}
