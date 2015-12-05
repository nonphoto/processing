import java.util.LinkedList;

LinkedList<Cell> cells;
Cell structure;

float rx, ry;
int unit;

void setup() {
  size(800, 600, P3D);
  smooth(8);
  fill(255);
  stroke(0);
  unit = 50;

  cells = new LinkedList<Cell>();
  structure = new Cell();
  structure.r = new PVector();

  rx = 0;
  ry = 0;
}

void draw() {
  background(255);
  translate(width / 2, height / 2, 0);
  rotateX(rx);
  rotateY(ry);
  structure.draw();
}

void keyPressed() {
  switch(key) {
  case '1':
    grow();
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
  float rate = 0.01;
  rx += (pmouseY - mouseY) * rate;
  ry += (mouseX - pmouseX) * rate;
}

void reset() {
  cells = new LinkedList<Cell>();
  structure = new Cell();
  structure.r = new PVector();
}

void grow() {
  Cell c = cells.get(int(random(cells.size())));
  c.grow();
}


//---------------------------

class Cell {
  PVector p;
  PVector r;
  PVector d;
  LinkedList<Cell> subcells;

  Cell() {
    p = new PVector(random(unit), random(unit), random(unit));
    r = new PVector(random(TWO_PI), random(TWO_PI), random(TWO_PI));
    d = new PVector(random(unit), random(unit), random(unit));
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
    switch(int(random(2))) {
    case 0:
      // New subcell
      println("New subcell");
      Cell a = new Cell();
      subcells.add(a);
      break;
    case 1:
      // Clone
      println("Clone");
      Cell b = new Cell(this);
      PVector v;
      switch (int(random(3))) {
      case 0:
        v = new PVector(random(unit), 0, 0);
        break;
      case 1:
        v = new PVector(0, random(unit), 0);
        break;
      case 2:
        v = new PVector(0, random(unit), 0);
        break;
      default:
        v = new PVector();
      }
      b.p = v;
      b.r = new PVector(0, 0, 0);
      subcells.add(b);
      break;
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
