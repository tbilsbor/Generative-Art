int [] recaman = {}; 
float centX;
float centY;
int UPPER_BOUND = 2500;
int i;
float strokeVal = 255;

void setup () {
  
  background (0);
  //size (1600, 900);
  fullScreen ();
  smooth ();
  frameRate (60);
  
  centX = width / 2;
  centY = height / 2;
  
  RecamanGen ();
  
  i = 0;
  strokeVal = 255;
  
}

void draw () {
  
  strokeWeight (.5);
  noFill ();
  float mid;
  float arcWidth;
  
  stroke (strokeVal);
  mid = ((recaman [i + 1] - recaman [i]) / 2) + recaman [i];
  arcWidth = (recaman [i + 1] - recaman [i]) / 2;
  arc(mid, centY, arcWidth, arcWidth, 0, 180);
  strokeVal -= .12;

  i++;
  if (i >= UPPER_BOUND - 1) {
    noLoop();
  }
  
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
