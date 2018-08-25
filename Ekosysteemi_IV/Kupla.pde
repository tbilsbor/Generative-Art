class Kupla {
  
  float accelRange = 0.05;
  float lifespan;
  static final float lifespanDec = 5;
  static final int lifespanUB = 355;
  
  PVector acceleration;
  PVector location;
  PVector velocity;
  
  Kupla (PVector l_) {
    location = l_.copy();
    acceleration = new PVector (random (0, accelRange), random (0, accelRange));
    velocity = new PVector (random (-1, 1), random (-1, 1));
    lifespan = (int) random (255, lifespanUB);
  }
  
  void draw () {
    stroke (255, lifespan);
    strokeWeight (0);
    noFill ();
    ellipse (location.x, location.y, 8, 8);
  }
  
  boolean isDead () {
    if (lifespan < 0) {
      return true;
    } else {
      return false;
    }
  }
  
  void update () {
    velocity.add (acceleration);
    location.add (velocity);
    lifespan -= lifespanDec;
  }
  
}
