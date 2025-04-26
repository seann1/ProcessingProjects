color pixelColor;
color red = #FFFFFF00;
color ored = #FFFF0084;
color colors[] = new color[400*400];
//color c1 = #eba134;
//color c2 = #d0eb34;
//color c3 = #34eb68;
//color c4 = #34b7eb;

color c1 = #edd38a;
color c2 = #40c2d6;
color c3 = #e82e60;
color c4 = #2024e8;

void setup () {
  size(400, 400);
  //colorMode(HSB);
    //for(int i = 0; i < width * height; i++) {
    //  if (i % 100 == 0) {
    //    colors[i] = color(random(255), random(255), random(255));
    //  }
    //}
}

void draw () {
  //background(255);
  loadPixels();
  for(int i = 0; i < width * height; i++) {
    //if (i % 100 == 0) {
    //  pixelColor = color(random(255), random(255), random(255));
    //}
    color v = lerpColor(c1, c2, (i / width) / float(height));
    color h = lerpColor(c3, c4, (i % width) / float(width));
    pixels[i] = color(red(v) + red(h)*0.5, green(v) + green(h)*0.5, blue(v) +blue(h)*0.5);
    //pixels[i] = lerpColor(red, colors[i], (float)(i % width)/float(height));
    //pixels[i] = pixelColor;
    //if (i %2 == 0) {
    //  pixels[i] = color(i%255,i%100,i%205);
    //} else {
    //  pixels[i] = pixelColor;
    //}
  }
  updatePixels();
}
