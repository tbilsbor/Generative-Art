class Lude {
  
  // Colors
  color c1;
  color c2;
  color c3;
  color c4;
  color c5;
  float cvRed;
  float cvGreen;
  float cvBlue;
  
  // Rotation
  float angle;
  float aVelocity;
  float aAcceleration;
  
  float lifespan;
  
  // Motion
  float maxForce;
  float maxSpeed;
  PVector acceleration;
  PVector location;
  PVector velocity;
  
  Lude (float x_, float y_) {
    location = new PVector (x_, y_);
    acceleration = new PVector (0, 0);
    velocity = new PVector (0, 0);
  }
  
  void applyForce (PVector force_) {
    acceleration.add (force_);
  }
  
  boolean isDead () {
    if (lifespan < 0) {
      kuplaSysteemit.add (new KuplaSysteemi (location.x, location.y));
      return true;
    } else {
      return false;
    }
  }
  
}
