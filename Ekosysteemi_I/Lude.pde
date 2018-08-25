class Lude {
  
  color c1;
  color c2;
  color c3;
  color c4;
  color c5;
  
  float angle;
  float aVelocity;
  float aAcceleration;
  
  float cvRed;
  float cvGreen;
  float cvBlue;
  
  float lifespan;
  
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
  
  void ApplyForce (PVector force_) {
    acceleration.add (force_);
  }
  
  boolean isDead () {
    if (lifespan < 0) {
      return true;
    } else {
      return false;
    }
  }
  
  void Update () {
    velocity.add (acceleration);
    velocity.limit (maxSpeed);
    location.add (velocity);
    acceleration.mult (0);
  }
  
}
