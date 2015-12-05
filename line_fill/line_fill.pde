import java.util.Queue;
import java.util.LinkedList;

PGraphics pg;
float l;
float a_spread;
float a_variation;

Queue<Integer> points_x;
Queue<Integer> points_y;
Queue<Float> points_a;

void setup() {
  size(800, 600);
  background(255);
  fill(0);
  stroke(0);

  l = 20;
  a_spread = 0.5;
  a_variation = 0.0;

  pg = createGraphics(width, height);
  pg.beginDraw();
  pg.noSmooth();
  pg.fill(0, 0, 255);
  pg.noStroke();
  pg.background(255);
  pg.endDraw();

  points_x = new LinkedList<Integer>();
  points_y = new LinkedList<Integer>();
  points_a = new LinkedList<Float>();
  
  points_x.add(width / 2);
  points_y.add(height / 2);
  points_a.add(0.0);
}

void draw() {
  int x = points_x.remove();
  int y = points_y.remove();
  float a = points_a.remove();
  
  boolean left = random(1) < 0.5;
  if (left) {
    a += a_variation;
  }
  else {
    a -= a_variation;
  }
  
  float a1 = a + a_spread;
  int x1 = x + (int)(cos(a1) * l);
  int y1 = y + (int)(sin(a1) * l);
  line(x, y, x1, y1);
  points_x.add(x1);
  points_y.add(y1);
  points_a.add(a1);
  
  float a2 = a - a_spread;
  int x2 = x + (int)(cos(a2) * l);
  int y2 = y + (int)(sin(a2) * l);
  line(x, y, x2, y2);
  points_x.add(x2);
  points_y.add(y2);
  points_a.add(a2);
}