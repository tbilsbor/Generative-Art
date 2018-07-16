int [] recaman = {}; 
float centX;
float centY;
int UPPER_BOUND = 2500;

void setup () {
  
  background (0);
  //size (1600, 900);
  fullScreen ();
  smooth ();
  frameRate (60);
  
  centX = width / 2;
  centY = height / 2;
  
  RecamanGen ();
  
  strokeWeight (.5);
  noFill ();
  float mid;
  float arcWidth;
  float strokeVal = 255;
  for (int i = 0; i < UPPER_BOUND - 1; i++) {
    stroke (strokeVal);
    mid = ((recaman [i + 1] - recaman [i]) / 2) + recaman [i];
    arcWidth = (recaman [i + 1] - recaman [i]) / 2;
    arc(mid, centY, arcWidth, arcWidth, 0, 180);
    strokeVal -= .12;
  }
  
}

void draw () {
  
}

void RecamanGen () {
  
  int stepSize = 1;
  int value = 0;
  int minusVal = 0;
  int plusVal = 0;
  
  while (stepSize <= UPPER_BOUND) {
    minusVal = value - stepSize;
    plusVal = value + stepSize;
    if (minusVal < 0 || Contains (recaman, minusVal)) {
      value = plusVal;
    } else {
      value = minusVal;
    }
    recaman = append (recaman, value);
    stepSize++;
  }
  
}

boolean Contains (int [] array_, int value) {
  
  boolean result = false;
  
  for (int item : array_) {
    if (item == value) {
      result = true;
      break;
    }
  }
  
  return result;
  
}
