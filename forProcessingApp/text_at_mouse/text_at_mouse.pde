PFont ariel;

void setup() {
  size(300, 300);
  ariel = createFont("Ariel", 32);
  textFont(ariel, 15);
}

void draw() {
  background(0);
  text(" position is "+mouseX+" "+mouseY, mouseX, mouseY);
}
