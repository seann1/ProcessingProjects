import processing.core.PApplet;
import processing.video.*;
// webcam input
Capture webcam;
PImage webcamScaled; // This will hold the scaled version of the webcam

    public void settings() {
        size(600, 600);
    }

    public void setup ()
    {
      //setup code to set background, frameRate, and color mode for sketch
        background(0);
        frameRate(20);
        colorMode(HSB);
        // look for a webcam
       String[] cameras = Capture.list();
      if (cameras.length == 0) {
          println("No cameras available!");
          exit();
      } else {
          println("Available cameras:");
          for (int i = 0; i < cameras.length; i++) {
              println(cameras[i]);
          }
          
          // Try to create capture at 600x600
          webcam = new Capture(this, 600, 600);
          webcam.start();
      }
    
      // Create a PImage to hold the scaled version
      webcamScaled = createImage(600, 600, HSB);
    }
// function for drawing an individual circle
    void drawCircle(int xPosition, int yPosition, float radius, float noise, color webcamColor) {
      //create values that oscillate

        // Oscillate between 2 and 400 using a sine wave for the diameter of the circle
        float sizeAmplitude = (radius - 2) / 2.0F; // Half the range (199)
        float sizeCenter = 2 + sizeAmplitude;      // Midpoint (201)
        float sizeOscillation = sizeCenter + (sizeAmplitude+15) * sin(frameCount * 0.2F); // Speed controlled by 0.02
        
        // create value that oscillates between 40 and 255 for the hue of the circle
        float hueAmplitude = (255-40) / 2.0F;
        float hueOscillation = hueAmplitude+40 * sin(frameCount * 0.05F);
        // create fill for the circle combining the current perlin noise value, the webcam pixel's hue, the hueOscillation value, and the position of mouseX
        fill(constrain((noise * (hue(webcamColor) * (hueOscillation/100) * map(mouseX, 0, 600, 0., 20.))), 0, 255),
        // create the saturations value for the circle using the saturation of the webcam pixel and the perlin noise value. This value is alway very high, it might always be 255. I thought it looked better with high saturation
        constrain((saturation(webcamColor)*noise+150), 0, 255),
        // create  the brightness value from the webcam pixel's brightness
        brightness(webcamColor));
        // remote the stroke from the ellipse
        noStroke();
        // draw one circle at the current x and y position at the size of the sizeOscillation
        ellipse(xPosition, yPosition, sizeOscillation, sizeOscillation);
    }
    // function for drawing all circles on the screen using the drawCircle function to draw each circle
    void drawCircles() {
      // if webcam doesn't contain any pixels, do nothing
      if (webcam.width <= 0 || webcam.height <= 0) return;
      
      // Scale the webcam image to match our grid
      webcamScaled.copy(webcam, 0, 0, webcam.width, webcam.height, 0, 0, 600, 600);
      webcamScaled.loadPixels();
      
        for (int i = 0; i < 20; i++) { // Reduced from 60 to 20 for better performance
          for (int j = 0; j < 20; j++) {
              float n = noise(i*0.1f, j*0.1f);
              float m = n * (width/20.0F);
              
              // Get color from corresponding pixel in webcam image
              int px = constrain((int)(i * 30), 0, 599);
              int py = constrain((int)(j * 30), 0, 599);
              color webcamColor = webcamScaled.pixels[py * webcamScaled.width + px];
              //draw circle at x and y value. Each circle is 30px by 30px, the 15 is added to move the edge of the first circles to the edge of the screen
              // m and n are coming from the perlin noise function, and the HSB values of the current webcam pixel are sent in
              drawCircle((i*30+15), (j*30+15), m, n, webcamColor);
          }
        }
    
    }

    void draw () {
      // run drawCircles function on each frame
        drawCircles();
        // read webcam input on each frame
        if(webcam.available()) {
          webcam.read();
        }
    }
