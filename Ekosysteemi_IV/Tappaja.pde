class Tappaja extends Lude {
  
  static final int chance = 1000;
  static final int init = 0;
  static final int max = 2;
  
  boolean arrived = false;
  boolean ATTACK = false;
  boolean HUNT = true;
  
  float angle = 0;
  float aVelocity = 0;
  float aAcceleration = 0;
  float maxForce = 1;
  float huntDistance = 300;
  float huntForce = 0.3;
  float huntRadius = 100;
  float huntTheta = 0;
  float huntThetaInc = 0.7;
  float senseDistance;
  Lude attackTarget;
  PVector steer = new PVector (0, 0);
  PVector target;
  
  float scaleFactor;
  float wingCycle = 0;
  float wingInc;
  
  Tappaja (float x_, float y_) {
    super (x_, y_);
    
    cvRed = map (random (1), 0, 1, -30, 30);
    cvGreen = map (random (1), 0, 1, -30, 30);
    cvBlue = map (random (1), 0, 1, -30, 30);
    c1 = color (red(Colors.c6) + cvRed, green (Colors.c6) + cvGreen, blue (Colors.c6) + cvBlue);
    c2 = color (red(Colors.c7) + cvRed, green (Colors.c7) + cvGreen, blue (Colors.c7) + cvBlue);
    c3 = color (red(Colors.c8) + cvRed, green (Colors.c8) + cvGreen, blue (Colors.c8) + cvBlue);
    
    maxSpeed = map (random (1), 0, 1, 3, 8);
    scaleFactor = map (random (1), 0, 1, 0.7, 1);
    senseDistance = map (random (1), 0, 1, 100, 300);
    wingInc = map (random (1), 0, 1, 10, 30);
    
    lifespan = map (random (1), 0, 1, 2000, 5000);
  }
  
  void act () {
    if (ATTACK) {
      attack ();
    }
    if (HUNT) {
      sense ();
      hunt ();
    }
  }
  
  void attack () {
    PVector desired = PVector.sub (attackTarget.location, location);
    desired.normalize ();
    desired.mult (maxSpeed);
    steer = PVector.sub (desired, velocity);
    steer.limit (maxForce);
    applyForce (steer);
    
    velocity.add (acceleration);
    velocity.limit (maxSpeed);
    location.add (velocity);
    acceleration.mult (0);
    
    if (attackTarget != null && PVector.dist (attackTarget.location, location) < 3) {
      attackTarget.lifespan = -1;
      lifespan += 1000;
      ATTACK = false;
      HUNT = true;
      velocity.mult (0);
    }
  }
  
  void decide () {
    HUNT = true;
  }
  
  void draw () {
    
    lifespan -= 1;
    
    pushMatrix ();
    translate (location.x, location.y);
    angle = velocity.heading ();
    rotate (angle + PI/2);
    scale (scaleFactor);
    
    // Wings
    noFill ();
    stroke (c3, lifespan);
    pushMatrix ();
    wingCycle += PI/wingInc;
    rotate (wingCycle);
    ellipse (0, 0, 75, 20);
    ellipse (-30, 0, 5, 5);
    ellipse (30, 0, 5, 5);
    popMatrix ();
    pushMatrix ();
    rotate (-wingCycle);
    ellipse (0, 0, 75, 20);
    ellipse (-30, 0, 5, 5);
    ellipse (30, 0, 5, 5);
    popMatrix ();
    
    // Body
    stroke (c2, lifespan);
    strokeWeight (2);
    noFill ();
    ellipse (0, 0, 30, 90);
    ellipse (0, 0, 30, 30);
    ellipse (0, -25, 20, 20);
    ellipse (0, 25, 20, 20);
    strokeWeight (1);
    fill (c1, lifespan);
    ellipse (0, 0, 20, 20);
    ellipse (0, -25, 10, 10);
    ellipse (0, 25, 10, 10);
    
    popMatrix ();
  }
  
  void hunt () {
    
    if (target == null) {
      target = new PVector (centX, centY);
    }
    
    PVector desired = PVector.sub (target, location);
    float d = desired.mag ();
    desired.normalize ();
    if (d < (width / 3) && arrived == false) {
      target = huntTarget ();
      arrived = true;
    } else if (arrived == true) {
      target = huntTarget ();
    }
    desired.mult (maxSpeed);
    steer = PVector.sub (desired, velocity);
    steer.limit (huntForce);
    applyForce (steer);
    
    velocity.add (acceleration);
    velocity.limit (maxSpeed);
    location.add (velocity);
    acceleration.mult (0);
  }
  
  PVector huntTarget () {
    PVector circlePos = velocity.copy ();
    circlePos.normalize ();
    circlePos.mult (huntDistance);
    circlePos.add (location);
    float h = velocity.heading();
    huntTheta += random (-huntThetaInc, huntThetaInc);
    PVector circleOffset = new PVector (huntRadius * cos (huntTheta + h), huntRadius * sin(huntTheta + h));
    PVector hTarget = PVector.add (circlePos, circleOffset);
    stroke (255);
    return hTarget;
  }
  
  void sense () {
    ArrayList<Lude> luteet = new ArrayList<Lude> ();
    luteet.addAll(kieppujat);
    luteet.addAll (tappajat);
    for (Lude lude : luteet) {
      if (lude != this) {
        float d = PVector.dist (location, lude.location);
        if (d < senseDistance ) {
          float h = PVector.angleBetween(PVector.fromAngle (velocity.heading ()), PVector.fromAngle (lude.location.heading ()));
          if (degrees (h) > -60 && degrees (h) < 60) {
            HUNT = false;
            ATTACK = true;
            attackTarget = lude;
            break;
          }
        }
      }
    }
  }
}
