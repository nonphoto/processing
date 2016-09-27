import java.util.LinkedList;

LinkedList<Cell> cells;
Cell structure;

PVector cd; // Camera direction
PVector cp; // Camera position

float yaw;
float pitch;

void setup() {
  size(800, 600, P3D);
  smooth(8);
  fill(255);
  stroke(200);

  cells = new LinkedList<Cell>();
  structure = new Cell();
  structure.r = new PVector();

  cd = new PVector();
  cp = new PVector(-150, -100, -170);

  yaw = 0.85;
  pitch = 2;
}

void draw() {
  background(255);
  yaw = yaw % TWO_PI;
  pitch = max(0, min(pitch, PI));

  cd.x = cos(yaw) * sin(pitch);
  cd.y = -cos(pitch);
  cd.z = sin(yaw) * sin(pitch);

  float fov = PI/3;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, width/height, cameraZ/100, cameraZ*10);
  camera(cp.x, cp.y, cp.z, cp.x + cd.x, cp.y + cd.y, cp.z + cd.z, 0, 1, 0);
  // directionalLight(255, 255, 255, 0.25, 1, 0.5);
  // ambientLight(150, 150, 150);

  structure.draw();

  if (keyPressed) {
    PVector p = new PVector();
    float speed = 3.0;
    if (key == 'w') {
      p = new PVector(cd.x, 0, cd.z);
    }
    if (key == 's') {
      p = new PVector(-cd.x, 0, -cd.z);
    }
    if (key == 'a') {
      p = new PVector(cd.z, 0, -cd.x);
    }
    if (key == 'd') {
      p = new PVector(-cd.z, 0, cd.x);
    }
    if (key == 'q') {
      p = new PVector(0, 1, 0);
    }
    if (key == 'e') {
      p = new PVector(0, -1, 0);
    }
    cp.add(p.normalize().mult(speed));
  }
}

void keyPressed() {
  switch(key) {
  case '1':
    if (random(1) < 0.2) {
      structure.grow();
    }
    else {
      structure.repeat();
    }
    break;
  case '2':
    reset();
    break;
  case '0':
    saveFrame();
    break;
  }
}

void mouseDragged() {
  float rate = 0.005;
  yaw += (mouseX - pmouseX) * rate;
  pitch -= (pmouseY - mouseY) * rate;
}

void reset() {
  cells = new LinkedList<Cell>();
  structure = new Cell();
  structure.r = new PVector();
}


//---------------------------

class Cell {
  PVector p;
  PVector r;
  PVector d;
  LinkedList<Cell> subcells;

  Cell() {
    float x = 2.0;
    float y = 50.0;
    p = new PVector(x + random(y), x + random(y), x + random(y));
    r = new PVector(random(TWO_PI), random(TWO_PI), random(TWO_PI));
    d = new PVector(x + random(y), x + random(y), x + random(y));
    subcells = new LinkedList<Cell>();
    cells.add(this);
  }

  Cell(Cell other) {
    p = other.p;
    r = other.r;
    d = other.d;
    subcells = new LinkedList<Cell>();
    for (Cell c : other.subcells) {
      subcells.add(new Cell(c));
    }
    cells.add(this);
  }

  void grow() {
    if (random(1) < 0.5) {
      Cell a = new Cell();
      subcells.add(a);
    }
    else {
      if (subcells.size() > 1) {
        subcells.get(int(random(subcells.size()))).grow();
      }
    }
  }

  void repeat() {
    if (random(1) < 0.5) {
      Cell b = new Cell(this);
      float x = 20.0;
      float y = 50.0;
      PVector v;
      switch (int(random(6))) {
      case 0:
        v = new PVector(x + random(y), 0, 0);
        break;
      case 1:
        v = new PVector(0, x + random(y), 0);
        break;
      case 2:
        v = new PVector(0, 0, x + random(y));
        break;
      case 3:
        v = new PVector(-x - random(y), 0, 0);
        break;
      case 4:
        v = new PVector(0, -x - random(y), 0);
        break;
      case 5:
        v = new PVector(0, 0, -x - random(y));
        break;
      default:
        v = new PVector();
      }
      b.p = v;
      b.r = new PVector(0, 0, 0);
      subcells.add(b);
    }
    else {
      if (subcells.size() > 1) {
        subcells.get(int(random(subcells.size()))).repeat();
      }
    }
  }

  void draw() {
    translate(p.x, p.y, p.z);
    rotateX(r.x);
    rotateY(r.y);
    rotateZ(r.z);
    box(d.x, d.y, d.z);

    pushMatrix();
    for (Cell c : subcells) {
      c.draw();
    }
    popMatrix();
  }
}
