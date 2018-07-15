class Bloomer {
  
  float xPos;
  float yPos;
  float radius = 0;
  float alph = 255;
  float weight = 8;
  boolean active = true;
  
  Bloomer (float x, float y) {
    xPos = x;
    yPos = y;
  }
  
  void Update () {
    if (active) {
      radius += 10;
      alph -= 1;
      if (weight > 1) {
        weight -= .1;
      }
      Draw ();
    }
    if (radius > width) {
      active = false;
    }
  }
  
  void Draw () {
    stroke (70, 40, 20, alph);
    strokeWeight (weight);
    ellipse (xPos, yPos, radius, radius); 
  }
}
