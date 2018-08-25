class Kirppu extends Lude {
  
  // Initial and max numbers and chance of generating new ones
  static final int chance = 20;
  static final int init = 10;
  static final int max = 50;
  
  // Boolean values for current activity
  boolean appearing = true;
  boolean DRIFT = true;
  boolean FLIT = false;
  
  // Variables for tracking "flitting" behavior
  int flitChance = 600;
  float flitCounter = 0;
  float flitSpeed = 10;
  float flitTime = 100;
  PVector flitDirection = new PVector (0, 0);
  
  // Motion and drawing variables
  float appearingRadius = 0;
  float appearingRadiusInc = 1;
  float appearanceAlpha = 75;
  float appearanceWeight = 4;
  PVector origin;
  float cycleInc;
  PVector direction;
  float maxForce = 0.5;
  float radius;
  float radiusInc = 0.003;
  float smallRadius;
  float theta = 0;
  int petals;
  
  // Constructor
  Kirppu (float x_, float y_) {
    super (x_, y_);
    origin = location.copy ();
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
  
  Kirppu (float x_, float y_, float maxSpeed_, float radius_, int petals_, color c1_, color c2_) {
    super (x_, y_);
    origin = location.copy ();
    maxSpeed = maxSpeed_ + map (random (1), 0, 1, -0.05, 0.05);
    radius = radius_ + map (random (1), 0, 1, -1, 1);
    smallRadius = radius / 1.618;
    direction = PVector.random2D ();
    
    petals = petals_;
    
    cvRed = map (random (1), 0, 1, -30, 30);
    cvGreen = map (random (1), 0, 1, -30, 30);
    cvBlue = map (random (1), 0, 1, -30, 30);
    
    c1 = color (red(c1_) + cvRed, green (c1_) + cvGreen, blue (c1_) + cvBlue);
    c2 = color (red(c2_) + cvRed, green (c2_) + cvGreen, blue (c2_) + cvBlue);
    
    cycleInc = map (random (1), 0, 1, -6, 6);
    lifespan = map (random (1), 0, 1, 300, 1000);
  }
  
  void act () {
    if (DRIFT) {
      drift ();
    }
    if (FLIT) {
      flit ();
    }
  }
  
  boolean isDead () {
    if (lifespan < 0) {
      return true;
    } else {
      return false;
    }
  }
  
  void decide () {
    if ((int) random (flitChance) == 1 && FLIT == false) {
      FLIT = true;
      DRIFT = false;
      flitDirection = PVector.random2D();
      flitCounter = millis ();
    }
    if (millis() - flitCounter > flitTime) {
      FLIT = false;
      DRIFT = true;
    }
  }
  
  void draw () {
    theta += cycleInc;
    lifespan -= 1;
    radius += radiusInc;
    
    if (appearing) {
      appearingRadius += appearingRadiusInc;
      appearanceAlpha -= 0.5;
      if (appearanceWeight > 0.1) {
        appearanceWeight -= .1;
      }
      stroke (255, appearanceAlpha);
      strokeWeight (appearanceWeight);
      ellipse (origin.x, origin.y, abs (appearingRadius + 10), abs (appearingRadius + 10));
      ellipse (origin.x, origin.y, abs (appearingRadius), abs (appearingRadius));
      if (appearingRadius > 100) {
        appearing = false;
      }
    }
    
    pushMatrix ();
    translate (location.x, location.y);
    
    // Body
    stroke (c1, lifespan);
    strokeWeight (2);
    fill (c2, lifespan);
    ellipse (0, 0, radius, radius);
    noFill ();
    stroke (c2, lifespan);
    strokeWeight (1);
    ellipse (0, 0, radius * 1.618, radius * 1.618);
    
    // Petals
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
  
  void drift () {
    direction.mult(maxForce);
    applyForce (direction);
    velocity.add (acceleration);
    velocity.limit (maxSpeed);
    location.add (velocity);
    acceleration.mult (0);
  }
  
  void flit () {
    flitDirection.mult (flitSpeed);
    applyForce (flitDirection);
    velocity.add (acceleration);
    velocity.limit (flitSpeed);
    location.add (velocity);
  }
}
