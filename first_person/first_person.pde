PVector cd; // Camera direction
PVector cp; // Camera position

void setup() {
  size(800, 600, P3D);
  smooth(8);
  fill(255);
  stroke(0);

  cd = new PVector();
  cp = new PVector();
}

void draw() {
  background(255);
  float yaw = map(mouseX, 0, width, 0, TWO_PI);
  float pitch = map(mouseY, 0, height, 0, PI);

  cd.x = cos(yaw) * sin(pitch);
  cd.y = -cos(pitch);
  cd.z = sin(yaw) * sin(pitch);

  camera(cp.x, cp.y, cp.z, cp.x + cd.x, cp.y + cd.y, cp.z + cd.z, 0, 1, 0);

  stroke(255, 0, 0);
  line(0, 0, 0, 100, 0, 0);
  stroke(0, 255, 0);
  line(0, 0, 0, 0, 100, 0);
  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, 100);
 
  if (keyPressed) {
    PVector p;
    float speed = 2.0;
    switch (key) {
    case 'w':
      // Move forward
      p = new PVector(cd.x, 0, cd.z);
      break;
    case 's':
      // Move backward
      p = new PVector(-cd.x, 0, -cd.z);
      break;
    case 'a':
      // Move left
      p = new PVector(cd.z, 0, -cd.x);
      break;
    case 'd':
      // Move right
      p = new PVector(-cd.z, 0, cd.x);
      break;
    case 'e':
      p = new PVector(0, 1, 0);
      break;
    case 'q':
      p = new PVector(0, -1, 0);
      break;
    default:
      p = new PVector();
      break;
    }
    cp.add(p.normalize().mult(speed));
  }
}
