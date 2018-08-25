class Elektroni {
  
  Atomi parent;
  int tier;
  PVector primary;
  PVector location;
  
  Elektroni (float x_, float y_, int tier_, Atomi p_) {
    primary = new PVector (x_, y_);
    location = new PVector (x_, y_ - 5 - (7.5 * tier_));
    tier = tier_;
    parent = p_;
  }
  
  void Draw() {
    noStroke ();
    fill (255);
    ellipse (location.x, location.y, 3, 3); 
  }
  
  void Update () {
    primary.x = parent.location.x;
    primary.y = parent.location.y;
    if (tier == 1 && parent.pulltowards != null) {
      PVector dir = parent.pulltowards.copy();
      float angle = dir.heading();
      location.x = primary.x + cos(angle) * (7.5 * tier + 5);
      location.y = primary.y + sin(angle) * (7.5 * tier + 5);
    }
    if (tier == 2 && wind != null) {
      PVector dir = wind.copy();
      float angle = dir.heading();
      location.x = primary.x + cos(angle) * (7.5 * tier + 5);
      location.y = primary.y + sin(angle) * (7.5 * tier + 5);
    }
    if (tier == 3 && parent.target != null) {
      PVector dir = parent.steer.copy ();
      float angle = dir.heading();
      location.x = primary.x + cos(angle) * (7.5 * tier + 5);
      location.y = primary.y + sin(angle) * (7.5 * tier + 5);
    } else if (parent.target == null) {
      location.x = primary.x + (5 * tier + 4);
      location.y = primary.y + (5 * tier + 4);
    }
  }
  
}
