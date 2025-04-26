int lastX = 0;
int lastY = 0;

void setup() {
  size(400, 400);
}

void draw() {
  
  lastX = mouseX;
  lastY = mouseY;
  lastX = (int)random(0, 400);
  lastY = (int)random(0, 400);
  
}

void mouseDragged() {
  line(lastX, lastY, mouseX, mouseY);
}
