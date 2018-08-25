class Kieppuja extends Lude {
  
  float angle = 0;
  float aVelocity = 0;
  float aAcceleration = 0;
  float cycle = 0; // pulse cycle variables
  float cycleInc;
  float maxForce = 0.1;
  float radius;
  float smallRadius = 7;
  float tinyRadius = 5;
  
  PVector steer = new PVector (0, 0);
  
  Kieppuja (float x_, float y_) {
    super (x_, y_);
    cycleInc = map (random (1), 0, 1, 0.01, 0.04);
    maxSpeed = map (random (1), 0, 1, 1, 5);
    radius = map (random (1), 0, 1, 10, 30);
    location = new PVector (x_, y_);
    
    cvRed = map (random (1), 0, 1, -30, 30);
    cvGreen = map (random (1), 0, 1, -30, 30);
    cvBlue = map (random (1), 0, 1, -30, 30);
    
    c1 = color (red(Colors.c1) + cvRed, green (Colors.c1) + cvGreen, blue (Colors.c1) + cvBlue);
    c2 = color (red(Colors.c2) + cvRed, green (Colors.c2) + cvGreen, blue (Colors.c2) + cvBlue);
    c3 = color (red(Colors.c3) + cvRed, green (Colors.c3) + cvGreen, blue (Colors.c3) + cvBlue);
    c4 = color (red(Colors.c4) + cvRed, green (Colors.c4) + cvGreen, blue (Colors.c4) + cvBlue);
    c5 = color (red(Colors.c5) + cvRed, green (Colors.c5) + cvGreen, blue (Colors.c5) + cvBlue);
    
    lifespan = map (random (1), 0, 1, 1000, 5000);
  }
  
  void Draw () {
    
    lifespan -= 1;
    
    pushMatrix ();
    translate (location.x, location.y);
    rotate (angle);
    
    // Inner circle
    strokeWeight (2);
    stroke (c3, lifespan);
    fill (c4, lifespan);
    ellipse (0, 0, radius, radius);
    
    // Secondary spokes
    strokeWeight (1);
    stroke (c5, lifespan);
    for (int a = 0; a < 360; a += 360 / 4) {
      float rad = radians (a);
      pushMatrix ();
      rotate (rad);
      line (0, radius, 0, radius * 3);
      popMatrix ();
    }
    
    // Secondary spoke ends
    strokeWeight (1);
    stroke (c1, lifespan);
    noFill ();
    for (int a = 0; a < 360; a += 360 / 4) {
      float rad = radians (a);
      pushMatrix ();
      rotate (rad);
      ellipse (0, radius, smallRadius, smallRadius);
      ellipse (0, radius * 3, smallRadius, smallRadius);
      popMatrix ();
    }

    // Primary spokes
    rotate (PI/4);
    strokeWeight (1);
    stroke (c1, lifespan);
    for (int a = 0; a < 360; a += 360 / 4) {
      float rad = radians (a);
      pushMatrix ();
      rotate (rad);
      line (0, radius, 0, radius * 2);
      popMatrix ();
    }

    // Primary spoke ends
    strokeWeight (1);
    stroke (c3, lifespan);
    noFill ();
    for (int a = 0; a < 360; a += 360 / 4) {
      float rad = radians (a);
      pushMatrix ();
      rotate (rad);
      ellipse (0, radius, smallRadius, smallRadius);
      ellipse (0, radius * 2, smallRadius, smallRadius);
      popMatrix ();
    }

    // Pulsing circle
    cycle += velocity.mag() / 50;
    cycle += cycleInc;
    float c = map (sin(cycle), -1, 1, 1, 3);
    for (float a = 0; a < 360; a += 360 / 8) {
      float rad = radians (a);
      float xPos = radius * cos(rad) * c;
      float yPos = radius * sin(rad) * c;
      strokeWeight (2);
      stroke (c2, lifespan);
      noFill ();
      ellipse (xPos, yPos, tinyRadius, tinyRadius);
    }
    
    popMatrix ();
  }
  
  void Seek () {
    
    // Find the closest kirppu
    float distance = 0;
    Kirppu closest = null;
    for (Kirppu kirppu : kirput) {
      if (closest == null) {
        distance = PVector.dist (kirppu.location, location);
        closest = kirppu;
      } else if (PVector.dist (kirppu.location, location) < distance) {
        distance = PVector.dist (location, kirppu.location);
        closest = kirppu;
      }
    }
    
    // Steer
    PVector desired = null;
    if (kirput.size() > 0 && closest != null) {
      desired = PVector.sub(closest.location, location);
    } else {
      desired = new PVector (random (width), random (height));
    }
    distance = desired.mag ();
    desired.normalize ();
    desired.mult (maxSpeed);
    steer = PVector.sub (desired, velocity);
    steer.limit (maxForce);
    ApplyForce (steer);
    
    // Move
    velocity.add (acceleration);
    velocity.limit (maxSpeed);
    location.add (velocity);
    aAcceleration = acceleration.x / 100;
    aVelocity += aAcceleration;
    aVelocity = constrain (aVelocity, -0.05, 0.05);
    angle += aVelocity;
    acceleration.mult (0);
    
    //Eat!
    if (closest != null && PVector.dist (closest.location, location) < 3) {
      closest.lifespan = -1;
      lifespan += closest.radius;
    }
    
  }
  
}
