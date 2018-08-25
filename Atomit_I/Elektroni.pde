class Elektroni {
  
  Atomi parent;
  int tier;
  PVector primary;
  PVector location;
  float rateVar;
  
  Elektroni (float x_, float y_, int tier_, Atomi p_) {
    primary = new PVector (x_, y_);
    location = new PVector (x_, y_ - 5 - (7.5 * tier_));
    tier = tier_;
    parent = p_;
    rateVar = random (-2, 2);
  }
  
  void Draw() {
    noStroke ();
    fill (255);
    ellipse (location.x, location.y, 3, 3); 
  }
  
  void Update () {
    primary.x = parent.location.x;
    primary.y = parent.location.y;
    float rad = radians ((frameCount / tier) * (5 + rateVar));
    location.x = primary.x + cos(rad) * (7.5 * tier + 5);
    location.y = primary.y + sin(rad) * (7.5 * tier + 5);
  }
  
}
