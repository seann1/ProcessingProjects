PImage photo;

int halfImage;

void setup () {
  size(800, 800);
  halfImage = width*height/2;
  photo = loadImage("example.png");
}

void draw() {
  image(photo,0,0);
  loadPixels();
  for (int i = 0; i < halfImage; i++) {
    if (i % 7 == 0) {
      color original = pixels[i];
      color inverted = color(255-red(original), 255-green(original), 255-blue(original));
      pixels[(i+frameCount)%(width*height)] = inverted;
    } else if (i % 3 == 0) {
      color original = pixels[i];
      color inverted = color(red(original), green(original)*0.5, blue(original)*0.5);
      pixels[i+halfImage - (frameCount % halfImage)] = inverted;
    }
  }
  updatePixels();
}
