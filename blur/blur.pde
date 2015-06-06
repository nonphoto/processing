PImage img;
PImage hand;

int exposures = 0;
int step = 1;
int frame = 0;

float factor = 0.0001;

void setup() {
    img = loadImage("img8.jpg");
    img.resize(1440, 900);
    
    hand = loadImage("hand.png");
    
    size(img.width, img.height);
    image(img, 0, 0);
    
    noStroke();
    noSmooth();  
}


void draw() {
  frame += 1;
  loadPixels();  
  for (int i = 0; i < pixels.length; i++) {
    color c = pixels[i];
    if (frame % 300 > 150) {
      pixels[i] += c * factor + 1;
    }
    else {
      pixels[i] -= c * factor + 1;
    }
  }
  updatePixels();
  
  blendMode(MULTIPLY);
  image(hand, 0, 0);
}

boolean sketchFullScreen() {
  return true;
}
