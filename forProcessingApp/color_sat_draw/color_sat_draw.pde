//int delta = 0;
PImage balloon;
int lastX = 0;
int lastY = 0;
int currentX = 0;
int currentY = 0;
PVector GhostMouse;
void setup(){
  size(600, 600);
  colorMode(HSB);
  balloon = loadImage("red-balloon.png");
  balloon.resize(balloon.width/10, balloon.height/10);
  imageMode(CENTER);
  GhostMouse = new PVector(width/2, height/2);
}

void draw() {
// map(delta, 0, 40, 0, 255)
  currentX = lastX + (int)random(-30,30);
  currentY = lastY + (int)random(-30,30);
  
  //PVector newGhostMouse = GhostMouse.add(PVector.random2D().mult(random(10)));
  float random10 = random(10.0);
  PVector randomVector = PVector.random2D();
  PVector newGhostMouse = new PVector(GhostMouse.x + (randomVector.x * random10), GhostMouse.y +
  (randomVector.y * random10));
  PVector delta = new PVector(newGhostMouse.x - GhostMouse.x, newGhostMouse.y - GhostMouse.y);
  //println("ddd", delta);
  if (currentX > 600) {
    currentX = 0;
  }
  if (currentY > 600) {
    currentY = 0;
  }
  
  fill(map(delta.x, -3, 3, 0, 100), 255, 255);
  noStroke();
  println("delta", map(delta.x, -10, 10, 0, 255));
  //println("ngm", newGhostMouse);
  ellipse(GhostMouse.x + delta.x, 
  GhostMouse.y + delta.y, 
  map(delta.x, -10, 10, 0, 20), 
  map(delta.x, -10, 10, 0, 20));

   GhostMouse = newGhostMouse;
  //if (delta > 0) {
  //  delta -= 1;
  //}
}

void keyPressed() {
  if (keyCode  == 37) {
    println("left arrow");
  }
}

void mousePressed() {
  println("mousePressed");
}

void mouseDragged() {
  println("mouseDragged");
}

//void mouseMoved() {
//  if (delta < 30) {
//    delta += abs(mouseX - pmouseX);
//    if (delta > 255) {
//      delta = 255;
//    }
//  }
//}

void myFunction() {
  println("key is pressed");
}
