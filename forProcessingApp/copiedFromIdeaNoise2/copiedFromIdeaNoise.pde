import processing.core.PApplet;
import processing.video.*;

Capture webcam;
PImage webcamScaled; // This will hold the scaled version of the webcam

    float hue = 0;
    public void settings() {
        size(600, 600);
    }

    public void setup ()
    {
        background(0);
        frameRate(10);
        colorMode(HSB);
        
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

    void drawCircle(int xPosition, int yPosition, float radius, float noise, color webcamColor) {
      println(webcamColor);
        float amplitude = (255 - 100) / 2.0F; // Half the range (107.5)
        float center = 150 + amplitude;      // Midpoint (147.5)
        float oscillation = center + amplitude * sin(frameCount * 0.07F); // Adjust speed with 0.05
        float oscillation2 = center + amplitude * sin(frameCount * 0.1F); // Adjust speed with 0.05
        println(oscillation);
        // Oscillate between 2 and 400 using a sine wave
        float sizeAmplitude = (radius - 2) / 2.0F; // Half the range (199)
        float sizeCenter = 2 + sizeAmplitude;      // Midpoint (201)
        float sizeOscillation = sizeCenter + (sizeAmplitude+15) * sin(frameCount * 0.2F); // Speed controlled by 0.02

        float hueAmplitude = (255-40) / 2.0F;
        float hueOscillation = hueAmplitude+40 * sin(frameCount * 0.05F);
        //fill(webcamColor);
        //(oscillation * (noise*2.0F))
        //255 - (oscillation2 *  (noise*2.0F))
        // hueOscillation * 
        // (noise * 255+100)* 
        fill(constrain((noise * (hue(webcamColor)* (hueOscillation/100))), 0, 255),
        constrain((saturation(webcamColor)*noise+150), 0, 255),
        brightness(webcamColor));
        noStroke();
        ellipse(xPosition, yPosition, sizeOscillation, sizeOscillation);
    }
    
    void drawCircle(int xPosition, int yPosition, float radius, float noise) {
        float amplitude = (255 - 100) / 2.0F; // Half the range (107.5)
        float center = 150 + amplitude;      // Midpoint (147.5)
        float oscillation = center + amplitude * sin(frameCount * 0.07F); // Adjust speed with 0.05
        float oscillation2 = center + amplitude * sin(frameCount * 0.1F); // Adjust speed with 0.05
        
        // Oscillate between 2 and 400 using a sine wave
        float sizeAmplitude = (radius - 2) / 2.0F; // Half the range (199)
        float sizeCenter = 2 + sizeAmplitude;      // Midpoint (201)
        float sizeOscillation = sizeCenter + (sizeAmplitude+15) * sin(frameCount * 0.2F); // Speed controlled by 0.02

        float hueAmplitude = (255-40) / 2.0F;
        float hueOscillation = hueAmplitude+40 * sin(frameCount * 0.05F);

        fill((hueOscillation * noise), (oscillation * (noise*2.0F)), 255 - (oscillation2 *  (noise*2.0F)));
        noStroke();
        ellipse(xPosition, yPosition, sizeOscillation, sizeOscillation);
    }

    void drawCircles() {
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
            
            drawCircle((i*30+15), (j*30+15), m, n, webcamColor);
        }
    }
    
      
        float xoff = 0.0F;
        float yoff = 0.0F;
        for (int i = 0; i < 60; i++) {
            xoff = xoff + 0.03F;
            for (int j = 0; j < 60; j++) {
                yoff = yoff + 0.03F;
                float n = noise(((float)i/10), ((float)j/10));
                float m = n * (width/20.0F);
                //drawCircle((i*30+15), (j*30+15), m, n);
            }
        }
        hue = (hue + 4) % 256;
    }

    void draw () {
        drawCircles();
        
        if(webcam.available()) {
          webcam.read();
        }
        //image(webcam, random(width), random(height));
  
        hue = (hue + 1) % 256;
    }
