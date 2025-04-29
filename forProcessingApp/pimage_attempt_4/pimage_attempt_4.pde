PImage photo;
int max;
color original;
color currentPixel;

void setup () {
  size(800, 800);
  photo = loadImage("example.png");
  photo.resize(width, height); // Match canvas size
  max = width * height;
}

color chooseColor(int inputColor, int inputDecider, color output1, color output2, color output3) {
  if (blue(inputColor) > inputDecider) {
    return output1;
  } else if (green(inputColor) > inputDecider) {
    return output2;
  } else if (red(inputColor) > inputDecider) {
    return output3;
  } else {
  return color(red(output1), green(output2), blue(output3));
  }
}

void draw() {
  float t = frameCount * 0.00005; // Slows down oscillation (adjust 0.05 for speed)
  int iterator = (int)(abs(sin(t)) * 500) + 1;
  int iterator2 = (int)(48.5 * sin(t) + 51.5);
  // .005
  int oscillator = (int)map(sin(frameCount * .005)* 500, -500, 500, 1, 500);
  int oscillator2 = (int)map(sin(frameCount * .7)* 255, -255, 255, 1, 255);
  int oscillator3 = (int)map(sin(frameCount * .8)* 255, -255, 255, 1, 255);
  //println(oscillator);
  loadPixels();
   arrayCopy(photo.pixels, pixels);
  for (int i = 0; i < max; i++) {
    pixels[i] = color(0);
    original = pixels[i];
    color inverted = color(255-red(original), 255-green(original), 255-blue(original));
    color pinkGreen = lerpColor(
    color(
    constrain(red(oscillator2) + red(inverted) / 2, 1, 255), 
    constrain(blue(oscillator2) + blue(inverted) / 2, 1, 255), 
    constrain(green(oscillator2) + green(inverted) / 2, 1, 255)), 
     photo.pixels[i],
    map(sin(frameCount * .05*(i*.1000)), -1, 1, 0.0, 1.0)
    );

    if ((blue(photo.pixels[i]) > map(oscillator, 1, 500, 0, 255) && (green(photo.pixels[i])- 100) < map(oscillator, 1, 500, 0, 255))) {

      for(int j = 1; j < (oscillator/random(0,10)); j++) {
        //pixels[constrain(i - (800 * j), 0, max)] = blue(pixels[i]) > oscillator3 ? inverted : pixels[i];
        pixels[constrain(i - (800 * j), 0, max)] = chooseColor(photo.pixels[1], oscillator3, inverted, pinkGreen, photo.pixels[i]);
        //pixels[constrain(i % (800 * j), 0, max)] = green(pixels[i]) > oscillator2 ? inverted : pixels[i];
        pixels[constrain(i % (800 * j), 0, max)] = chooseColor(photo.pixels[1], oscillator2, color(red(photo.pixels[i]), blue(inverted), green(pinkGreen)), inverted, pinkGreen);
        //pixels[constrain(i - (800 % j), 0, max)] = red(pixels[i]) > oscillator3 ? pinkGreen : pixels[i];
        pixels[constrain(i - (800 % j), 0, max)] = chooseColor(photo.pixels[1], oscillator3, inverted, pinkGreen, color(red(photo.pixels[i]), blue(inverted), green(pinkGreen)));
      }
    }
  }
  println(millis());
  updatePixels();
}
