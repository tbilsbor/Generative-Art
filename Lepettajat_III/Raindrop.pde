class Raindrop {
  
  PVector location;
  float radius = 0;
  float alph = 255;
  float weight = 8;
  boolean active = true;
  
  Raindrop (float x_, float y_) {
    location = new PVector (x_, y_);
  }
  
  void Draw () {
    noFill ();
    stroke (210, 210, 255, alph);
    strokeWeight (weight);
    ellipse (location.x, location.y, radius, radius); 
    strokeWeight (abs (weight - 2));
    ellipse (location.x, location.y, abs (radius - 20), abs (radius - 20));
    strokeWeight (abs (weight - 4));
    ellipse (location.x, location.y, abs (radius - 40), abs (radius - 40));
  }
  
  void Update () {
    if (active) {
      radius += 5;
      alph -= 1;
      if (weight > 1) {
        weight -= .1;
      }
      for (Lepettaja lepettaja : lepettajat) {
        if ((radius / 2) >= PVector.dist(location, lepettaja.location)) {
          if (lepettaja.hasFlit == false) {
            lepettaja.hasFlit = true;
            lepettaja.flit = true;
            lepettaja.flitTarget = location;
            lepettaja.flitCounter = millis();
          }
        }
      }
    }
    if (radius > width) {
      if (active == true) {
        for (Lepettaja lepettaja : lepettajat) {
          lepettaja.hasFlit = false;
        }
      }
      active = false;
      alph = 0;
    }
  }
}
