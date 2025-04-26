//float lastX;
//float lastY;
//float newX;
//float newY;
//float angle;
//int r = 0;
//int g = 0;
//int b = 0;
//int rectWidth = 0;
//int rectHeight = 0;
//float rotation = 0.0;

//void setup () {
//  size(600, 600);
//}

//void draw () {
//  newX = (lastX += 1) % width;
//  newY = (lastY += angle) % height;
//  stroke(b,g,r);
//  fill(r, g, b);
//  rotate(PI*rotation);
//  rect(newX, newY, rectWidth, rectHeight);
//  lastX = newX;
//  lastY = newY;
//  angle = (angle + 0.1) % 10;
//  r = (r + (int)random(10)) % 255;
//  g = (g + (int)random(10)) % 255;
//  b = (b + (int)random(10)) % 255;
//  rectWidth = (rectWidth + 1) % 150;
//  rectHeight = (rectHeight + 1) % 150;
//  rotation = (rotation + 0.1) % 1;

//}

float lastX;
float lastY;
float newX;
float newY;
float angle;
int r = 0;
int g = 0;
int b = 0;
float rectWidth = 150;
float rectHeight = 150;
float rotation = 0.0;
PGraphics spotlight1;
PGraphics spotlight2;

void setup() {
  // set image size
  size(600, 600);
  // set origin of rectangles to center
  rectMode(CENTER); // This makes rect() use center coordinates
  //blendMode(DARKEST);
  lastX = width/2;  // Start in center
  lastY = height/2;
  // create graphic in PGraphics spotlight 1
  spotlight1 = createGraphics(100,100);
  spotlight1.beginDraw();
  spotlight1.fill(255,0,0, 50);
  spotlight1.ellipse(50,50,100,100);
  spotlight1.endDraw();
  // create graphic in PGraphic spotlight 2
  spotlight2 = createGraphics(100,100);
  spotlight2.beginDraw();
  spotlight2.fill(0, 255,0, 50);
  spotlight2.ellipse(50,50,100,100);
  spotlight2.endDraw();
  // set origin of images to center
  imageMode(CENTER);
  // set color mode to HSB
  colorMode(HSB);
}

void draw() {
  //background(255); // Clear previous frames
  
  // Update position and properties
  // make the new x and y variables the last x and y plus 1 and 10, and if they are over the width or height, set them to zero
  newX = (lastX += 1) % width;
  newY = (lastY += 10) % height;
  //newX = (lastX + (sin(0.2)*3)) % width;
  // Update colors and size
  // iterate through colors on each frame. set value to zero if it is over 255
  r = (r + (int)random(10)) % 255;
  g = (g + (int)random(10)) % 255;
  b = (b + (int)random(10)) % 255;
  // attempted to make rectangle width and height oscillate, but didn't turn out the way I wanted it to
  rectWidth = sin(rectWidth - 0.2) * 100.0;
  println(rectWidth);
  rectHeight = sin(rectHeight - 0.3) * 100.0;
  rotation = (rotation + 0.01) % TWO_PI;
  
  // Draw the rotated rectangle
  pushMatrix(); // Save current transformation state
  translate(newX, newY); // Move origin to rectangle center
  rotate(rotation); // Rotate around new origin
  // this is actually HSB and alpha
  fill(r, g, b, 70);
  noStroke();
  rect(0, 0, rectWidth, rectHeight); // Draw at (0,0) relative to new origin
  popMatrix(); // Restore original transformation state
  image(spotlight1, 40, 40);
  image(spotlight2, 50, 50);
  // set last x and y values to current ones
  lastX = newX;
  lastY = newY;
}
