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

void setup() {
  size(1400, 1000);
  background(255);
  border = 100;
  imgx = border;
  imgy = border;
  imgw = width - 2 * border;
  imgh = height - 2 * border;
  img = loadImage("img/img001.png");
  img.resize(imgw, imgh);
  image(img, imgx, imgy);
  xres = 3;
  yres = 5;
  cellw = imgw / xres;
  cellh = imgh / yres;
}

int samplex;
int sampley;
int drawx;
int drawy;

void draw() {
  samplex = (int)random(imgw - cellw);
  sampley = (int)random(imgh - cellh);
  drawx = imgx + (int)random(xres) * cellw;
  drawy = imgy + (int)random(yres) * cellh;
  blend(img, samplex, sampley, cellw, cellh, drawx, drawy, cellw, cellh, DARKEST);
}
