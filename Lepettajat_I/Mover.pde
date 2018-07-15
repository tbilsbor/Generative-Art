class Mover {
  
  float xPos;
  float yPos;
  float radius;
  float xDest; 
  float yDest;
  int encounters;
  
  int interval = (int) random (10) + 1;
  
  Mover (float x, float y, float rad) {
    xPos = x;
    yPos = y;
    radius = rad;
    float xd = random (width);
    float yd = random (height); 
    setDest (xd, yd);
  }
  
  void setDest (float xd, float yd) {
    xDest = xd;
    yDest = yd;
  }
  
  void Draw () {
    fill (255);
    stroke (255, 255, 255, 127);
    ellipse (xPos, yPos, radius, radius);
    noFill ();
    for (int e = 0; e < encounters; e++) {
      strokeWeight (2);
      stroke (120 - (10 * e), 40, 20, 255 - (20 * e));
      ellipse (xPos, yPos, radius + 10 * e + 10, radius + 10 * e + 10);
    }
  }
  
  void Update () {
    
    float dx = xDest - xPos;
    float dy = yDest - yPos;
    
    xPos += dx * easing;
    yPos += dy * easing;
    
    if (frameCount % (interval * 10) == 0) {
      float xd = random (width);
      float yd = random (height); 
      setDest (xd, yd);
      if (encounters > 0 && random (4) > 2) {
        encounters--;
      }
    }
    
    if (xPos > (width + radius)) {xPos = 0 - radius;}
    if (xPos < (0 - radius)) {xPos = width + radius;}
    if (yPos > (height + radius)) {yPos = 0 - radius;}
    if (yPos < (0 - radius)) {yPos = height + radius;}
    
    boolean touching = false;
    for (int i = 0; i < movers.length; i++) {
      Mover otherMover = movers [i];
      if (otherMover != this) {
        float dis = dist (xPos, yPos, otherMover.xPos, otherMover.yPos);
        if ((dis - radius - otherMover.radius) < 0) {
          touching = true;
        }
      }
    }
    if (touching) {
      if (movers.length < 100 && frameCount - timeSinceAdd > 100) {
        movers = (Mover []) append (movers, new Mover (width, height, radius));
        timeSinceAdd = frameCount;
        bloomers = (Bloomer []) append (bloomers, new Bloomer (xPos, yPos));
      }
      if (encounters < 10) {
        encounters++;
      }
      setDest (random (height), random (width));
    }
    
    Draw ();
  }
  
}
