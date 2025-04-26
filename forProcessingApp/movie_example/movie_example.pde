import processing.video.*;
Movie mov;

void setup() {
  size(600,600);
  mov = new Movie(this, "sampleMov.mov");
  mov.play();
}

void movieEvent(Movie m) {
  m.read();
}

void draw() {
  image(mov, 0,0);
}
