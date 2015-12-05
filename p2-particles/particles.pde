System s;
PVector down;

void start() {
  size(640, 480);
  s = new System();
  
  int res = 25;
  int h = 10;
  int w = 10;
  
  for (int j = 0; j < h; j += 1) {
    for (int i = 0; i < w; i += 1) {
      int x = (i - w/2) * res + width/2;
      int y = (j - h/2) * res + height/2;
      s.spawn(x, y);
    }
  }
}

void draw() {
  background(0);
  noFill();
  stroke(#f1b974);
  strokeWeight(5);
  s.update();
}



void mouseDragged() {
  s.spawn(mouseX, mouseY);
}

////////////////////////////////////////////////////////////////////

class Particle {
  PVector p;
  PVector v;
  PVector a;
  float m;
  
  Particle(int x, int y) {
    p = new PVector(x, y);
    v = new PVector(0, 0);
    a = new PVector(0, 0);
    m = 1.0;
  }
  
  void update() {
    v.add(a);
    p.add(v);
    a.mult(0);
    
    v.mult(0.99);
    ellipse(p.x, p.y, m*15, m*15);
  }
  
  void nudge(PVector f) {
    // f = m*a
    a.add(PVector.div(f, m));
  }
  
  void repel(ArrayList<Particle> particles) {
    for (int i = 0; i < particles.size(); i++) {
      Particle that = particles.get(i);
      PVector separation = PVector.sub(this.p, that.p);
      float d = separation.magSq();
      if (d > 0) {
        separation.normalize();
        separation.div(d);
        separation.limit(1);
        this.nudge(separation);
        that.nudge(PVector.mult(separation, -1));
      }
    }
  }
}

class System {
  ArrayList<Particle> particles;
  
  System() {
    particles = new ArrayList<Particle>();
  }
  
  void spawn(int x, int y) {
    particles.add(new Particle(x, y));
  }
  
  void update() {
    for (int i = 0; i < particles.size(); i++) {
      Particle p = particles.get(i);
      p.repel(particles);
      p.update();
    }
  }
}

PVector wrap(PVector v) {
  if (v.x < 0) {
    v.x = width;
  }
  if (v.x > width) {
    v.x = 0;
  }
  if (v.y < 0) {
    v.y = height;
  }
  if (v.y > height) {
    v.y = 0;
  }
  return v;
}
