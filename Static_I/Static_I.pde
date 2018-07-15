void setup () {
  size (1280, 800);
  strokeWeight (2);
  stroke (20, 50, 70);
  frameRate (24);
}

void draw () {
  background (127);
  float xstep = 10;
  float ystep = 10;
  float lastx = 20;
  float lasty = 50;
  int steps = 4;
  for (int i = 0; i < steps; i++) {
    for (int ybase = 50; ybase <= height - 50; ybase += 20) {
      lasty = ybase;
      float variance = random (5) * 2;
      for (int x = 20; x <= width - 20; x += xstep) {
        ystep = random (variance) - (variance / 2);
        float y = ybase + ystep;
        stroke (20 + variance, 50 + variance, 70 + variance);
        line (x, y, lastx, lasty);
        lastx = x;
        lasty = y;
      }
      lastx = 20;
    }
  }
}
