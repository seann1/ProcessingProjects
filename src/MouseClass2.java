import processing.core.PApplet;

public class MouseClass2 extends PApplet {
    public static void main(String[] args) {
        PApplet.main("MouseClass2", args);
    }
    float hue = 0;
//    float xoff = 0.0F;
    public void settings() {
        size(600, 600);
    }

    public void setup ()
    {
        background(0);
        frameRate(10);
        colorMode(HSB);
    }

    void drawCircle(int xPosition, int yPosition, float radius, float noise) {
        float amplitude = (255 - 60) / 2.0F; // Half the range (107.5)
        float center = 40 + amplitude;      // Midpoint (147.5)
        float oscillation = center + amplitude * sin(frameCount * 0.05F); // Adjust speed with 0.05
        float oscillation2 = center + amplitude * sin(frameCount * 0.07F); // Adjust speed with 0.05
        println(noise);
        // Oscillate between 2 and 400 using a sine wave
        float sizeAmplitude = (radius - 2) / 2.0F; // Half the range (199)
        float sizeCenter = 2 + sizeAmplitude;      // Midpoint (201)
        float sizeOscillation = sizeCenter + (sizeAmplitude+30) * sin(frameCount * 0.02F); // Speed controlled by 0.02
        fill((hue * noise), (oscillation * (noise+.2F)), 255 - (oscillation2 *  (noise+.5F)));
        noStroke();
        ellipse(xPosition, yPosition, sizeOscillation, sizeOscillation);
    }

    void drawCircles() {
        float xoff = 0.0F;
        float yoff = 0.0F;
        for (int i = 15; i < 600; i+=30) {
            xoff = xoff + 0.03F;
            for (int j = 15; j < 600; j += 30) {
                yoff = yoff + 0.03F;
                float n = noise(i, j);
                float m = n * (width/20.0F);
                drawCircle(i, j, m, n);
            }
        }
        hue = (hue + 4) % 256;
    }

    public void draw () {
        drawCircles();
        hue = (hue + 1) % 256;
    }
}
