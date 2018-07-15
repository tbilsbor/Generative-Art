float centX;
float centY;

void setup () {
  size (1600, 900);
  background (180);
  frameRate (12);
  smooth ();
  noFill ();
  centX = width / 2;
  centY = height /2;
}

void innerSpiral (float radius) {
  strokeWeight (1);
  stroke (0, 0, 0, 127);
  for (int i = 0; i <= 4; i++) {
    float r = radius;
    float x, y;
    float lastx = -999;
    float lasty = -999;
    float radiusNoise = random(10);
    for (float ang = 0; ang <= 1440; ang += 5) {
      radiusNoise += 0.05;
      r += 0.5;
      float thisRadius = r + (noise (radiusNoise) * 50) - 25;
      float rad = radians (ang);
      x = centX + (thisRadius * cos (rad));
      y = centY + (thisRadius * sin (rad));
      if (lastx > -999) {
        line (x, y, lastx, lasty);
      }
      lastx = x;
      lasty = y;
    }
  }
}

void innerCircle (float radius) {
  strokeWeight (1);
  stroke (0, 0, 0);
  float radiusNoise = random (20);
  float thisRadius = radius + (noise (radiusNoise) * 75) - 30;
  ellipse (centX, centY, thisRadius, thisRadius);
}

void draw () {
  background (127);
  
  for (int r = 300; r > 50; r -= 25) {
    float radius = r;
    float x, y;
    float radiusNoise = random (10);
    beginShape ();
    for (float ang = 0; ang <= 1440; ang += 1) {
      radiusNoise += 0.05;
      float thisRadius = radius + (noise(radiusNoise) * 20) - 10;
      float rad = radians (ang);
      x = centX + (thisRadius * cos(rad));
      y = centY + (thisRadius * sin(rad));
      strokeWeight (1);
      stroke (0, 0, 0);
      curveVertex (x, y);
    }
    endShape ();
  }

  for (int i = 0; i < 4; i++) {
    innerCircle (75);
    innerCircle (700);
  }
}
