// Sketch for Multiples project

PImage img;
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

void setup() {
  size(1600, 1200);
  background(255);
  border = 50;
  imgx = border;
  imgy = border;
  imgw = width - 2 * border;
  imgh = height - 2 * border;
  img = loadImage("img/img108.jpg");
  img.resize(imgw, imgh);
  image(img, imgx, imgy);
  xres = 20;
  yres = 4;
  cellw = imgw / xres;
  cellh = imgh / yres;
  count = 0;
  frame = 0;
}

int samplex;
int sampley;
int drawx;
int drawy;

void draw() {
  count += 1;
  if (count >= frame) {
    saveFrame();
    frame = count * 2;
  }
  samplex = (int)random(imgw - cellw);
  sampley = (int)random(imgh - cellh);
  drawx = imgx + (int)random(xres) * cellw;
  drawy = imgy + (int)random(yres) * cellh;
  blend(img, samplex, sampley, cellw, cellh, drawx, drawy, cellw, cellh, DARKEST);
}
