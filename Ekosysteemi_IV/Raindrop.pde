class Raindrop {
  
  static final int chance = 400;
  
  boolean active = true;
  float alph = 255;
  float pushForce = 100;
  float radius = 0;
  float weight = 8;
  PVector location;
  
  Raindrop (float x_, float y_) {
    location = new PVector (x_, y_);
  }
  
  void draw () {
    noFill ();
    stroke (210, 210, 255, alph);
    strokeWeight (weight);
    ellipse (location.x, location.y, radius, radius); 
    strokeWeight (abs (weight - 2));
    ellipse (location.x, location.y, abs (radius - 20), abs (radius - 20));
    strokeWeight (abs (weight - 4));
    ellipse (location.x, location.y, abs (radius - 40), abs (radius - 40));
  }
  
  boolean isDone () {
    if (radius > width) {
      return true;
    } else {
      return false;
    }
  }
  
  void update () {
    radius += 5;
    alph -= 1;
    if (weight > 1) {
      weight -= .1;
    }
    
    ArrayList<Lude> luteet = new ArrayList<Lude> ();
    luteet.addAll (kirput);
    luteet.addAll (kieppujat);
    luteet.addAll (tappajat);
    for (Lude lude : luteet) {
      float d = PVector.dist (location, lude.location);
      if ((radius / 2) >= d) {
        PVector away = PVector.sub (lude.location, location);
        away.normalize ();
        away.mult (pushForce);
        lude.applyForce(away);
      }
    }
  }
}
