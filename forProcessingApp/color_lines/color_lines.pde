float x1 = random(width);
float y1 = random(height);
float noiseX;
float noiseY;

void setup () {
  size(600,600);
  frameRate(10);
}

void draw () {
  //translate(width/2,height/2);
  float newX = noise(noiseX += 0.5) * width;
  float newY = noise(noiseY += 0.3) * height;
  //color(random(255), random(255), random(255));
  noFill();
  stroke(random(255), random(255), random(255));
  strokeWeight(random(1,10));
  //curve(random(600), random(600), x1,y1,newX, newY, random(600), random(600));
  line(x1,y1,newX,newY);
  x1 = newX;
  y1 = newY;
}
