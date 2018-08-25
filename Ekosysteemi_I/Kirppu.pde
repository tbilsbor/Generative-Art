class Kirppu extends Lude {
  
  boolean flit = false;
  int flitChance = 600;
  float flitCounter = 0;
  float flitSpeed = 10;
  float flitTime = 100;
  PVector flitDirection = new PVector (0, 0);
  
  float cycleInc;
  float maxForce = 0.5;
  float radius;
  float radiusInc = 0.0025;
  float smallRadius;
  float theta = 0;
  
  float senseDistance = 100;
  boolean spin = false;
  float spinIncrement = 0.002;
  float spinRadius;
  
  int petals;
  
  PVector direction;
  
  Kirppu (float x_, float y_) {
    super (x_, y_);
    maxSpeed = map (random (1), 0, 1, .1, 1);
    radius = map (random (1), 0, 1, 6, 12);
    smallRadius = radius / 1.618;
    direction = PVector.random2D();
    
    petals = (int) random (4) + 5;
    
    cvRed = map (random (1), 0, 1, -30, 30);
    cvGreen = map (random (1), 0, 1, -30, 30);
    cvBlue = map (random (1), 0, 1, -30, 30);
    
    c1 = color (red(Colors.c9) + cvRed, green (Colors.c9) + cvGreen, blue (Colors.c9) + cvBlue);
    c2 = color (red(Colors.c10) + cvRed, green (Colors.c10) + cvGreen, blue (Colors.c10) + cvBlue);
    
    cycleInc = map (random (1), 0, 1, -6, 6);
    lifespan = map (random (1), 0, 1, 300, 1000);
  }
  
  void Draw () {
    theta += cycleInc;
    lifespan -= 1;
    radius += radiusInc;
    
    pushMatrix ();
    translate (location.x, location.y);
    
    stroke (c1, lifespan);
    strokeWeight (2);
    fill (c2, lifespan);
    ellipse (0, 0, radius, radius);
    noFill ();
    stroke (c2, lifespan);
    strokeWeight (1);
    ellipse (0, 0, radius * 1.618, radius * 1.618);
    
    rotate (radians (theta));
    for (float a = 0; a < 360; a += 360 / petals) {
      pushMatrix ();
      rotate (radians (a));
      stroke (c1, lifespan);
      strokeWeight (1);
      noFill ();
      ellipse (0, radius, smallRadius, smallRadius);
      popMatrix ();
    }
    
    popMatrix ();
  }
  
  void Drift () {
    direction.mult(maxForce);
    ApplyForce (direction);
    velocity.add (acceleration);
    velocity.limit (maxSpeed);
    location.add (velocity);
    acceleration.mult (0);
  }
  
  void Flit () {
    flitDirection.mult (flitSpeed);
    ApplyForce (flitDirection);
    velocity.add (acceleration);
    velocity.limit (flitSpeed);
    location.add (velocity);
    
    if (millis() - flitCounter > flitTime) {
      flit = false;
    }
  }
  
}
