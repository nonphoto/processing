// This code is so bad its unbelievable. Check out the cube_system project
// for a sketch that does a similar thing way better.

float[] plan;
float x, y, z;
float rotate_x, rotate_y;

int max_count;

void setup() {
  size(600, 600, P3D);
  smooth(8);
  fill(255);
  stroke(0);

  max_count = 10;
  genPlan();

  x = width / 2;
  y = height / 2;
  z = 0;

}

void draw() {
  background(255);
  translate(x, y, z);
  rotateX(rotate_x);
  rotateY(rotate_y);
  genNext(max_count - 2, plan[max_count - 1]);
}

void mouseDragged() {
  float rate = 0.01;
  rotate_x += (pmouseY - mouseY) * rate;
  rotate_y += (mouseX - pmouseX) * rate;
}

void keyPressed() {
  if (key == 'r') {
    genPlan();
  }
  if (key == 's') {
    saveFrame();
  }
}

void genPlan() {
  plan = new float[max_count];
  print("plan");
  for (int i = 0; i < max_count; i++) {
    float x = random(1);
    print(", " + x);
    plan[i] = x;
  }
  print("\n");
}

void genRotate(int count) {
  float x = plan[count + 1];
  float y = plan[count];

  rotateY(x * 360);
  translate(0, 0, (y + 1) * 100);
  box((x + 1) * 100, 50, (y + 1) * 100);
  genNext(count - 1, y);
}

void genRepeat(int count) {
  float x = plan[count + 1];
  float y = plan[count];

  int repeats = (int)(x * 10);
  for (int i = 0; i < repeats; i++) {
    translate(0, 0, (y + 1) * 20);
    box((y + 1) * 5, (x + 1) * 100, (y + 1) * 5);
  }
  genNext(count - 1, y);
}

void genNext(int count, float chance) {
  if (count > 0) {
    if (chance > 0.5) {
      genRotate(count - 1);
    }
    else {
      genRepeat(count - 1);
    }
  }
}
