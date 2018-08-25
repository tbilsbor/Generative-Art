class Kieppuja extends Lude {
  
  // Initial and max numbers and chance of generating new ones
  static final int chance = 750;
  static final int init = 3;
  static final int max = 5;
  
  // Boolean values for current activity
  boolean REST = false;
  boolean SEEK = true;
  
  // Motion and drawing variables
  float angle = 0;
  float aVelocity = 0;
  float aAcceleration = 0;
  float cycle = 0; // pulse cycle variables
  float cycleInc;
  float maxForce = 0.1;
  float radius;
  float restFactor = 10;
  float restForce;
  float restSpeed;
  float smallRadius = 7;
  float tinyRadius = 5;
  PVector restDirection;
  PVector steer = new PVector (0, 0);
  
  // How many luteet has it eaten
  int eatCount = 0;
  int full;
  
  // Constructor
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
    
    lifespan = map (random (1), 0, 1, 2000, 10000);
    
    restDirection = PVector.random2D();
    restForce = maxForce / restFactor;
    restSpeed = maxSpeed / restFactor;
    
    full = (int) random (10) + 5;
  }
  
  void act () {
    sense ();
    if (REST) {
      rest ();
    }
    if (SEEK) {
      seek ();
    }
  }
  
  void decide () {
    if (SEEK) {
      if (eatCount > full) {
        if ((int) random (10) == 1) {
          SEEK = false;
          REST = true;
          PVector brake = velocity.copy ();
          brake.normalize ();
          brake.rotate(radians (180));
          brake.mult (maxForce);
          applyForce (brake);
        }
      }
    }
    
    if (REST) {
      if (frameCount % 60 == 0 && eatCount > 0) {
        eatCount -= 1;
        if ((int) random (eatCount + 1) == 1) {
          SEEK = true;
          REST = false;
        }
      }
    }
  }
  
  void draw () {
    
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
  
  void rest () {
    restDirection.mult(restForce);
    applyForce (restDirection);
    velocity.add (acceleration);
    velocity.limit (maxSpeed);
    location.add (velocity);
    aAcceleration = acceleration.x / 100;
    aVelocity += aAcceleration;
    aVelocity = constrain (aVelocity, -0.05, 0.05);
    angle += aVelocity;
    acceleration.mult (0);
  }
  
  void seek () {
    
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
    applyForce (steer);
    
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
      eatCount += 1;
    }
    
  }
  
  void sense () {
    for (Kieppuja kieppuja : kieppujat) {
      if (kieppuja != this) {
        float distance = PVector.dist (kieppuja.location, location);
        if (distance < (radius * 2)) {
          PVector repel = PVector.sub(kieppuja.location, location);
          repel.normalize ();
          repel.rotate (radians (180));
          repel.mult (maxSpeed);
          repel.limit (maxForce);
          applyForce (repel);
        }
      }
    }
  }
  
}
