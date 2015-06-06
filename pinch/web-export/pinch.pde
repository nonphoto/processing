int segLength = 15;
int res = 30;
int weight = 5;
int w = 5;
int h = 10;

int gridHalfWidth, gridHalfHeight;
int halfWidth, halfHeight;
void setup() {
   size(640, 480);
   strokeWeight(weight);
   stroke(#7ad896);
   fill(0);
   gridHalfWidth = res * w / 2;
   gridHalfHeight = res * h / 2;
   halfWidth = width / 2;
   halfHeight = height / 2;
}

void draw() {
   background(0);
   float angle;
   int x, y;
   for (int j = 0; j < h; j += 1) {
      for (int i = 0; i < w; i += 1) {
        x = i * res + halfWidth - gridHalfWidth;
        y = j * res + halfHeight - gridHalfHeight;
        angle = atan2(mouseY - y, mouseX - x);
        segment(x, y, angle);
      }
   }
}

void segment(float x, float y, float a) {
  pushMatrix();
  translate(x, y);
  rotate(a);
  //line(0, 0, segLength, 0 );
  ellipse(-segLength, 0, segLength, segLength);
  popMatrix();
}

