class Lepettaja {
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector target;
  PVector desired;
  PVector steer;
  float maxSpeed = .2;
  float maxForce = 1;
  float radius = height * (phi/50);
  float brightness = 0;
  
  Lepettaja (float x_, float y_) {
    location = new PVector (x_, y_);
    velocity = new PVector (0, 0);
    acceleration = new PVector (0, 0);
  }
  
   void ApplyForce(PVector force) {
    acceleration.add(force);
  }
  
  void Draw (float pulseSync_) {
    
    fill (255);
    stroke (255, 255, 255, 127);
    ellipse (location.x, location.y, radius, radius);
    noFill ();
    float pulse = pulseSync_;
    for (int e = 0; e < 6; e++) {
      strokeWeight (2);
      stroke (120 - (10 * e) + pulse + brightness, 40 + pulse, 20 + pulse, 255 - (40 * e));
      ellipse (location.x, location.y, radius + 10 * e + 10, radius + 10 * e + 10);
    }
    
  }
  
  void Drift () {
    
    if (target == null) {
      target = new PVector (random (width / 2), random (height / 2));
    }
    
    if (frameCount % 60 == 0) {
      target.x += random (60) - 30;
      target.y += random (60) - 30;
    }
    
    if (target.x > (width)) {
      target.x = 0 - radius;
    }
    if (target.x < (0)) {
      target.x = width + radius;
    }
    if (target.y > (height)) {
      target.y = 0 - radius;
    }
    if (target.y < (0)) {
      target.y = height + radius;
    }
    
    desired = PVector.sub(target, location);
    
    float d = desired.mag();
    desired.normalize();
    if (d < 100) {
      float m = map (d, 0, 100, 0, maxSpeed);
      desired.mult (m);
    } else {
      desired.mult (maxSpeed);
    }
    
    steer = PVector.sub(desired, velocity);
    steer.limit (maxForce);
    boolean close = false;
    boolean closer = false;
    Lepettaja closest = null;
    for (Lepettaja otherLepettaja : lepettajat) {
      if (otherLepettaja != this) {
        float dist = PVector.dist(location, otherLepettaja.location);
        if (dist < 60) {
          close = true;
          closer = true;
          closest = otherLepettaja;
        }
        if (dist < 180) {
          close = true;
          closest = otherLepettaja;
        }
      }
    }
    if (close) {
      steer = steer.mult(-2);
      ApplyForce (steer);
    } else {
      ApplyForce (steer);
    }
    if (close || closer) {
      if (closest != null) {
        brightness = (180 - PVector.dist(location, closest.location)) * 2;
      }
    }
    if (!close && !closer) {
      maxSpeed = .2;
      brightness = 0;
    }
    
    velocity.add (acceleration);
    velocity.limit (maxSpeed);
    location.add(velocity);
    
    // wrap
    
    if (location.x > (width + radius)) {
      location.x = 0 - radius;
    }
    if (location.x < (0 - radius)) {
      location.x = width + radius;
    }
    if (location.y > (height + radius)) {
      location.y = 0 - radius;
    }
    if (location.y < (0 - radius)) {
      location.y = height + radius;
    }
    
  }
  
}
