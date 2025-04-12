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
  size(600, 600);
  rectMode(CENTER); // This makes rect() use center coordinates
  //blendMode(DARKEST);
  lastX = width/2;  // Start in center
  lastY = height/2;
  spotlight1 = createGraphics(100,100);
  spotlight1.beginDraw();
  spotlight1.fill(255,0,0, 50);
  spotlight1.ellipse(50,50,100,100);
  spotlight1.endDraw();
  
  spotlight2 = createGraphics(100,100);
  spotlight2.beginDraw();
  spotlight2.fill(0, 255,0, 50);
  spotlight2.ellipse(50,50,100,100);
  spotlight2.endDraw();
  imageMode(CENTER);
  colorMode(HSB);
}

void draw() {
  //background(255); // Clear previous frames
  
  // Update position and properties
  newX = (lastX += 1) % width;
  newY = (lastY += 10) % height;
  //newX = (lastX + (sin(0.2)*3)) % width;
  // Update colors and size
  r = (r + (int)random(10)) % 255;
  g = (g + (int)random(10)) % 255;
  b = (b + (int)random(10)) % 255;
  rectWidth = sin(rectWidth - 0.2) * 100.0;
  println(rectWidth);
  rectHeight = sin(rectHeight - 0.3) * 100.0;
  rotation = (rotation + 0.01) % TWO_PI;
  
  // Draw the rotated rectangle
  pushMatrix(); // Save current transformation state
  translate(newX, newY); // Move origin to rectangle center
  rotate(rotation); // Rotate around new origin
  fill(r, g, b, 70);
  noStroke();
  rect(0, 0, rectWidth, rectHeight); // Draw at (0,0) relative to new origin
  popMatrix(); // Restore original transformation state
  image(spotlight1, 40, 40);
  image(spotlight2, 50, 50);
  lastX = newX;
  lastY = newY;
}
