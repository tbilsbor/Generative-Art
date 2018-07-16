class Lepettaja {
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector steer;
  PVector target;
  PVector desired;
  PVector flitTarget;
  boolean flit = false;
  boolean hasFlit = false;
  int flitCounter = millis ();
  int timeSinceLastFlit = millis ();
  float flitSpeed = 10;
  float flitForce = 10;
  float maxSpeed = 0.2;
  float maxForce = 1;
  float radius = height * (phi / 50);
  float brightness = 0;
  
  Lepettaja (float x_, float y_) {
    location = new PVector (x_, y_);
    velocity = new PVector (0, 0);
    acceleration = new PVector (0,0);
  }
  
  void ApplyForce(PVector force) {
    acceleration.add(force);
  }
  
  void Drift () {
       
    if (target == null) {
      target = new PVector (random (width), random (height));
    }
    
    if (PVector.dist(location, target) < 20 || random (6000) == 1) {
      target = new PVector (random (width), random (height));
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
    ApplyForce (steer);
    if (close || closer) {
      if (closest != null) {
        brightness = (180 - PVector.dist(location, closest.location)) * 2;
      }
    }
    if (!close && !closer) {
      brightness = 0;
    }
    
    velocity.add (acceleration);
    velocity.limit (maxSpeed);
    location.add(velocity);
    
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
  
  void Flit () {

    desired = PVector.mult(PVector.sub(flitTarget, location), -1);
    
    float d = desired.mag();
    desired.normalize();
    if (d < 100) {
      float m = map (d, 0, 100, 0, maxSpeed);
      desired.mult (m);
    } else {
      desired.mult (flitSpeed);
    }
    
    steer = PVector.sub(desired, velocity);
    steer.limit (flitForce);
    ApplyForce (steer);
    velocity.add (acceleration);
    velocity.limit (flitSpeed);
    location.add(velocity);
    
    if (millis() - flitCounter > 100) {
      flit = false;
    }
  
  }
  
}
