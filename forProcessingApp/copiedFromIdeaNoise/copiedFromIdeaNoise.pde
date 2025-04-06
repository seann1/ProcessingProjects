import processing.core.PApplet;
import processing.video.*;

Capture webcam;


    float hue = 0;
    public void settings() {
        size(600, 600);
    }

    public void setup ()
    {
        background(0);
        frameRate(10);
        colorMode(HSB);
        
        webcam = new Capture(this, 320, 240, 30);
        webcam.start();
    }

    void drawCircle(int xPosition, int yPosition, float radius, float noise) {
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

        fill((hueOscillation * noise), (oscillation * (noise*2.0F)), 255 - (oscillation2 *  (noise*2.0F)));
        noStroke();
        ellipse(xPosition, yPosition, sizeOscillation, sizeOscillation);
    }

    void drawCircles() {
        float xoff = 0.0F;
        float yoff = 0.0F;
        for (int i = 0; i < 60; i++) {
            xoff = xoff + 0.03F;
            for (int j = 0; j < 60; j++) {
                yoff = yoff + 0.03F;
                float n = noise(((float)i/10), ((float)j/10));
                float m = n * (width/20.0F);
                drawCircle((i*30+15), (j*30+15), m, n);
            }
        }
        hue = (hue + 4) % 256;
    }

    void draw () {
        drawCircles();
        
        if(webcam.available()) {
          webcam.read();
        }
        image(webcam, random(width), random(height));
  
        hue = (hue + 1) % 256;
    }
