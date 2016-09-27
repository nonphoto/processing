PGraphics buffer;
PImage source1;
PImage source2;
int xres;
int yres;
int imgw;
int imgh;
int imgx;
int imgy;
int border;
int cellw;
int cellh;
int speed;
int count;
int frame;
float weights[];

void setup() {
  size(4000, 400);
  background(255);
  
  border = 100;
  
  imgx = border;
  imgy = border;
  imgw = width - (2 * border);
  imgh = height - (2 * border);

  source1 = loadImage("img/img104.jpg");
  source2 = loadImage("img/img105.jpg");
  float aspect = source1.width / source1.height;
  source1.resize((int)(imgh * aspect), imgh);
  source2.resize((int)(imgh * aspect), imgh);

  xres = 200;
  yres = 1;

  cellw = imgw / xres;
  cellh = imgh / yres;

  weights = new float[xres];
  for (int i = 0; i < xres; i++) {
    float n = noise(i * 0.1);
    weights[i] = n * n * n * n;
  }
  for (int i = 1; i < xres; i++) {
    weights[i] += weights[i - 1];
  }
}

int samplex;
int sampley;
int drawx;
int drawy;

void draw() {
  float r = random(weights[xres-1]);
  int i;
  for (i = 0; i < xres; i++) {
    if (r < weights[i]) {
      break;
    }
  }

  PImage source;
  if (i < random(xres)) {
    source = source1;
  }
  else {
    source = source2;
  }

  samplex = (int)random(source.width - cellw);
  sampley = (int)random(source.height - cellh);


  drawx = imgx + i * cellw;
  drawy = imgy + (int)random(-border / 2, border / 2);

  blend(source, samplex, sampley, cellw, cellh, drawx, drawy, cellw, cellh, DARKEST);
}

void keyPressed() {
  saveFrame();
}
