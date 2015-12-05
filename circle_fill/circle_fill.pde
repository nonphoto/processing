PGraphics pg;
float r;
float s;

void setup() {
  size(512, 512);
  background(unhex("ECECF0"));
  fill(0);
  noStroke();
  ellipseMode(RADIUS);
  r = 2;
  s = 10;
  pg = createGraphics(width, height);
  pg.noSmooth();
  pg.beginDraw();
  pg.fill(0);
  pg.noStroke();
  pg.background(255);
  pg.endDraw();
}

void draw() {
  for (int i = 0; i < 1000; i++) {
    int x = (int)random(width);
    int y = (int)random(height);
    pg.beginDraw();
    color c = pg.get(x, y);
    pg.endDraw();
    if (c == color(255)) {
      ellipse(x, y, r, r);
      ellipse(x + width, y, r, r);
      ellipse(x - width, y, r, r);
      ellipse(x, y + height, r, r);
      ellipse(x, y - height, r, r);
      pg.beginDraw();
      pg.ellipse(x, y, r * s, r * s);
      pg.ellipse(x + width, y, r * s, r * s);
      pg.ellipse(x - width, y, r * s, r * s);
      pg.ellipse(x, y + height, r * s, r * s);
      pg.ellipse(x, y - height, r * s, r * s);
      pg.endDraw();
    }
  }
}

void keyPressed() {
  if (key == 's') {
    saveFrame();
  }
}
