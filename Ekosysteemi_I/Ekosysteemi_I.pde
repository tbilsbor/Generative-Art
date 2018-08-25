import java.util.Iterator;

float centX;
float centY;
ArrayList<Kieppuja> kieppujat;
ArrayList<Kirppu> kirput;

int kieppujaChance = 750;
int kirppuChance = 30;
int kieppujaInit = 1;
int kirppuInit = 6;
int kieppujaMax = 6;
int kirppuMax = 30;

void setup () {
  //size (1600, 900);
  fullScreen ();
  background (0);
  frameRate (60);
  smooth ();
  
  centX = width / 2;
  centY = height / 2;
  
  kieppujat = new ArrayList<Kieppuja> ();
  float xPos = 1;
  float yPos = 1;
  while (xPos > 0 && xPos < width) {
    xPos = map (random (1), 0, 1, -width, width * 2);
  }
  while (yPos > 0 && yPos < height) {
    yPos = map (random (1), 0, 1, -height, height * 2);
  }
  for (int i = 1; i < kieppujaInit; i++) {
    kieppujat.add(new Kieppuja (xPos, yPos));
  }
  
  kirput = new ArrayList<Kirppu> ();
  for (int i = 0; i <= kirppuInit; i++) {
    xPos = map (random (1), 0, 1, 0, width);
    yPos = map (random (1), 0, 1, 0, height);
    kirput.add(new Kirppu (xPos, yPos));
  }
  
}

void draw () {
  
  background (0);
  
  if ((int) random (kieppujaChance) == 1 && kieppujat.size() < kieppujaMax) {
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
  
  if ((int) random (kirppuChance) == 1 && kirput.size() < kirppuMax) {
    float xPos = map (random (1), 0, 1, 0, width);
    float yPos = map (random (1), 0, 1, 0, height);
    kirput.add(new Kirppu (xPos, yPos));
  }
  
  Iterator<Kirppu> iKirput = kirput.iterator ();
  while (iKirput.hasNext ()) {
    Kirppu kirppu = iKirput.next ();
    if (kirppu.isDead ()) {
      iKirput.remove();
    }
    if ((int) random (kirppu.flitChance) == 1 && kirppu.flit == false) {
      kirppu.flit = true;
      kirppu.flitDirection = PVector.random2D();
      kirppu.flitCounter = millis ();
    }
    if (kirppu.flit) {
      kirppu.Flit ();
    }
    kirppu.Drift ();
    kirppu.Draw ();
  }
  
  Iterator<Kieppuja> iKieppujat = kieppujat.iterator ();
  while (iKieppujat.hasNext ()) {
    Kieppuja k = iKieppujat.next ();
    if (k.isDead ()) {
      iKieppujat.remove();
    }
    k.Seek ();
    k.Draw ();
  }
  
}
