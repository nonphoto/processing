PImage source, destination;

void setup()
{
 source = loadImage("img.jpg");  // fill in your own image here
 size(source.width, source.height);
 noLoop();
 destination = warp(source);
}

void draw()
{
 image(destination, 0, 0);
}

// implement a simple vertical wave warp.
PImage warp(PImage source)
{
 int w = source.width;
 int h = source.height;
 PImage destination = new PImage(w,h);
 source.loadPixels();
 destination.loadPixels();

 for(int x = 0; x < w; x++) {
   for(int y = 0; y < h; y++)
   {
     double d = Math.sqrt(x*x + y*y);
     double t = 1-(200/(d+1));
     int newX = (int) lerp(0, x, (float) (t));
     int newY = (int) lerp(0, y, (float) (t));
     color c;
     if(newX >= w || newX < 0 || newY >= h || newY < 0) {
       c = color(0,0,0);
     }
     else {
       c = source.pixels[newY*w + newX];
     }
     destination.pixels[y*w+x] = c;
   }
 }
 return destination;
}
