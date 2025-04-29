PImage photo;

int halfImage;
int max;
color currentPixel;
color original;

void setup () {
  size(1250, 833);
  photo = loadImage("example.png");
  //size(photo.width, photo.height);
  max = photo.width * photo.height;
}

void draw() {
  float t = frameCount * 0.00005; // Slows down oscillation (adjust 0.05 for speed)
  int iterator = (int)(abs(sin(t)) * 500) + 1;
  int iterator2 = (int)(48.5 * sin(t) + 51.5);
  image(photo,0,0);
  
  loadPixels();
  for (int i = 0; i < max; i+=iterator) {
    original = pixels[i];
    color inverted = color(255-red(original), 255-green(original), 255-blue(original));
    for(int j = 1; j < iterator; j++) {
      if (i % iterator2 == 0 && blue(pixels[i]) < 100) {
        currentPixel = inverted;
      } else if (i % 30 == 0 && green(pixels[i]) < 100) {
        //currentPixel = lerpColor(#FA03FF, inverted, map(i, 0, max, 0, 1));
        color pinkGreen = lerpColor(#FA03FF, #AEFF03, map(sin(frameCount * .05*(i*.1000)), -1, 1, 0.0, 1.0));
        currentPixel = pinkGreen;
      } else {
        currentPixel = original;
      }
      pixels[constrain(i-j,0,max)] = currentPixel;
    }


  }
  updatePixels();
}
