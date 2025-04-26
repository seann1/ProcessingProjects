// initialize color variables
color pixelColor;
color c1 = #edd38a;
color c2 = #40c2d6;
color c3 = #e82e60;
color c4 = #2024e8;
// set size and color mode
void setup () {
  size(400,400);
  colorMode(RGB);
}

void draw () {
  // load pixels of current display window
  loadPixels();
  // for loop that iterates over each pixel in display window
  for (int i = 0; i < width * height; i++){
    //if (i % (width/6) == 0) {
    //  pixelColor = color(random(255), random(255), random(255));
    //}
    // calculate the color between c1 and c2 at the value of (i/width)/height
    println("i/width", (i / width) / float(height));
    println("i%width", (i % width) / float(width));
    
    color v =  lerpColor(c1, c2, (i / width) / float(height));
    // calculate the color between c3 and c4 at the value of (i%width)/width
    color h =  lerpColor(c3, c4, (i % width) / float(width));
    // set value of current pixel to average of v and h for r g and b
    pixels[i] = color(red(v) + red(h) * 0.5,
                      green(v) + green(h) * 0.5,
                      blue(v) + blue(h) * 0.5);
  }
  // call update pixels to set the current pixels[] to the display window
  updatePixels();
}
