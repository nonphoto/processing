float res = 5;
float speed = 0.01;
float xscale = 200;
float yscale = 200;

float z;
void setup() {
  size(640, 480);
  z = 0;
}

void draw() {
  noStroke();
  noSmooth();
  background(0);
  z += speed;
  
  float s;
  for (int x = 0; x <= width; x += res) {
    for (int y = 0; y <= height; y += res) {
      s = noise(x / xscale, y / yscale, z);
      s = (s * 2 * res) - res;
      rect(x, y, s, s);
    }
  }
}

