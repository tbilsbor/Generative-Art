class Atomi {
  
  PVector force;
  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector pulltowards;
  float maxSpeed;
  float mass;
  float xoff;
  float yoff;
  float noiseInc;
  PVector target;
  PVector steer;
  Elektroni [] elektronit;
  
  Atomi (float x_, float y_) {
    maxSpeed = 5;
    mass = 1000.0;
    location = new PVector (x_, y_);
    elektronit = new Elektroni [3];
    velocity = new PVector (0, 0);
    steer = new PVector (0, 0);
    acceleration = new PVector (0, 0);
    xoff = random (1000);
    yoff = random (1000);
    noiseInc = 0.005;
    for (int i = 0; i < 3; i++) {
      elektronit [i] = new Elektroni (location.x, location.y, i + 1, this);
    }
  }
  
  void ApplyForce (PVector force) {
    PVector f = PVector.div (force, mass);
    acceleration.add (f);
  }
  
  void CheckEdges () {
    
    float pushback;
    
    if (location.x > width - 100) {
      pushback = abs (width - location.x) * -5;
      ApplyForce (new PVector (pushback, 0));
    }
    if (location.x < 100) {
      pushback = abs (location.x) * 5;
      ApplyForce (new PVector (pushback, 0));
    }
    if (location.y > height - 100) {
      pushback = abs (height - location.y) * -5;
      ApplyForce (new PVector (0, pushback));
    }
    if (location.y < 100) {
      pushback = abs (location.y) * 5;
      ApplyForce (new PVector (0, pushback));
    }
  }
  
  void Draw () {
    noStroke ();
    fill (255);
    ellipse (location.x, location.y, 10, 10);
    for (int i = 0; i < 3; i++) {
      stroke (200, 80, 40, 255);
      noFill ();
      ellipse (location.x, location.y, 25 + (i * 15), 25 + (i * 15));
      elektronit [i].Draw ();
    }
  }
  
  void Update () {
    
    CheckEdges ();
    
    for (Atomi otherAtomi : atomit) {
      if (otherAtomi != this) {
        float distance = PVector.dist(location, otherAtomi.location);
        if (distance < 75) {
          PVector pushaway = PVector.sub(otherAtomi.location, location);
          pushaway.normalize();
          pushaway.mult(-500);
          ApplyForce (pushaway);
        } else if (distance >= 75 && distance < 300) {
          pulltowards = PVector.sub(otherAtomi.location, location);
          pulltowards.normalize ();
          pulltowards.mult ((distance * distance) / 500);
          ApplyForce (pulltowards);
        }
      }
    }
    
    xoff += noiseInc;
    yoff += noiseInc;
    float xNoise = noise (xoff);
    xNoise = map (xNoise, 0, 1, 0, width);
    float yNoise = noise (yoff);
    yNoise = map (yNoise, 0, 1, 0, height);
    
    target = new PVector (xNoise, yNoise);
    steer = PVector.sub(target, location);
    ApplyForce(steer);
    
    velocity.add (acceleration);
    velocity.limit (maxSpeed);
    location.add (velocity);
    acceleration.mult (0);
    
    for (Elektroni elektroni : elektronit) {
      elektroni.Update ();
    }
    
  }
  
}
