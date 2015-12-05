import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class circle_fill extends PApplet {

PGraphics pg;
float r;
float s;

public void setup() {
  
  background(unhex("ECECF0"));
  fill(0);
  noStroke();
  ellipseMode(RADIUS);
  r = 2;
  s = 10;
  pg = createGraphics(width, height);
  pg.noSmooth();
  pg.beginDraw();
  pg.fill(0);
  pg.noStroke();
  pg.background(255);
  pg.endDraw();
}

public void draw() {
  for (int i = 0; i < 1000; i++) {
    int x = (int)random(width);
    int y = (int)random(height);
    pg.beginDraw();
    int c = pg.get(x, y);
    pg.endDraw();
    if (c == color(255)) {
      ellipse(x, y, r, r);
      ellipse(x + width, y, r, r);
      ellipse(x - width, y, r, r);
      ellipse(x, y + height, r, r);
      ellipse(x, y - height, r, r);
      pg.beginDraw();
      pg.ellipse(x, y, r * s, r * s);
      pg.ellipse(x + width, y, r * s, r * s);
      pg.ellipse(x - width, y, r * s, r * s);
      pg.ellipse(x, y + height, r * s, r * s);
      pg.ellipse(x, y - height, r * s, r * s);
      pg.endDraw();
    }
  }
}

public void keyPressed() {
  if (key == 's') {
    saveFrame();
  }
}
  public void settings() {  size(512, 512); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "circle_fill" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
