PImage source_a;
PImage source_b;
PImage source;
PImage result;
PImage[] frames_a;
PImage[] frames_b;

float[] ylist;
float noise_scale;
float variation;

int count;
int state;
int max_frames;

void setup() {
  size(1600, 1175);
  frameRate(10);
  blendMode(ADD);
  fill(255, 5);
  noStroke();
  background(255);
  
  ylist = new float[width];
  count = 1;
  state = 0;
  max_frames = 30;
  noise_scale = 0.005;
  variation = 0.03;

  source_a = loadImage("data/img-a.png");
  source_b = loadImage("data/img-b.png");
  source_a.resize(width, height);
  source_b.resize(width, height);
  source = source_a;
  result = createImage(width, height, RGB);
  frames_a = new PImage[max_frames];
  frames_b = new PImage[max_frames];
}

void draw() {
  if (state == 0 || state == 1) {
    rect(0, 0, width, height);
    source.loadPixels();
    result.loadPixels();
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        ylist[x] -= noise(count * noise_scale, x * noise_scale) * variation;
        int n = ((int)ylist[x] + y) % height;
        if (n < 0) {
          n += height;
        }
        color c = source.pixels[x + (n * width)];
        result.pixels[x + y * width] = c;
      }
    }
    source.updatePixels();
    result.updatePixels();
    blend(result, 0, 0, width, height, 0, 0, width, height, DARKEST);

    if (state == 0) {
      frames_a[count] = get(0, 0, width, height);
    }
    if (state == 1) {
      frames_b[count] = get(0, 0, width, height);
    }
  }
  if (state == 2) {
    background(255);
    tint(255, map(-count, -max_frames, -1, 0, 255));
    image(frames_a[count], 0, 0);
    tint(255, map(count, 1, max_frames, 0, 255));
    image(frames_b[max_frames - count], 0, 0);
    saveFrame();
  }
  
  if (count >= max_frames - 1) {
    state += 1;
    background(255);
    source = source_b;
    ylist = new float[width];
    count = 1;
  }
  else {
    count += 1;
  }
}
