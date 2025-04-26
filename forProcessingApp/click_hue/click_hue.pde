int alphaValue = 0;

void setup() {
  size(350, 300);
  background(0xFFFFFFFF);
  colorMode(HSB);
}

void draw() {
  background(0xFFFFFFFF);
  fill(alphaValue, 255, 255);
  rect(100, 100, 100, 100);
}

void mousePressed() {
  alphaValue = mouseX;
}
