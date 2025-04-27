PImage photo;
int max;

void setup () {
  size(800, 800);
  photo = loadImage("example.png");
  photo.resize(width, height); // Match canvas size
  max = width * height;
}

void draw() {
  //image(photo,0,0);
  photo.loadPixels();
  loadPixels();
   arrayCopy(photo.pixels, pixels);
  for (int i = 0; i < max; i++) {
      //for(int j = 1; j < 100; j++) {
      //  pixels[constrain(i - (800 * j), 0, max)] = pixels[i];
      //}
    if (blue(pixels[i]) > 100) {
      for(int j = 1; j < 100; j++) {
        pixels[constrain(i - (800 * j), 0, max)] = pixels[i];
      }
    }
    //if (green(pixels[i]) > 100) {
    //  for(int j = 1; j < 100; j++) {
    //    pixels[constrain(i - ((800+800) * j), 0, max)] = pixels[i];
    //  }
    //}
    updatePixels();
  }
}
