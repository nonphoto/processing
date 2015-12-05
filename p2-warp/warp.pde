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
 PImage result = new PImage(w,h);
 source.loadPixels();
 result.loadPixels();

 for(int x = 0; x < w; x++) {
   float n = 0;
   boolean noiseOn = false;
   for(int y = 0; y < h; y++)
   {
//     double d = Math.sqrt(x*x + y*y);
//     double t = 1-(200/(d+1));
//     int newX = (int) lerp(0, x, (float) (t));
//     int newY = (int) lerp(0, y, (float) (t));
    if (noise(y / 20) >= 0.75) {
      noiseOn = true;
    }
    if (noiseOn) {
      n += noise(y / 20);
   }
   else {
       n += 1;
   }
    int newX = x;
    int newY = floor(n);

     color c;
     if(newX >= w || newX < 0 || newY >= h || newY < 0) {
       c = color(0,0,0);
     }
     else {
       c = source.pixels[newY*w + newX];
     }
     result.pixels[y*w+x] = c;
   }
 }
 return result;
}
