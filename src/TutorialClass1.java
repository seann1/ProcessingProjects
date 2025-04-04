import processing.core.PApplet;

public class TutorialClass1 extends PApplet {
    public static void main(String[] args) {
        PApplet.main("TutorialClass1", args);
    }
    public void settings() {
        size(400, 400); // Set the size of the window
    }
    public void setup() {
    }

//    void image() {
//        background(50, 168, 82);
//        rectMode(CENTER);
//        fill(242, 200, 5);
//        rect(100,100,20,100);
//        fill(242, 228, 5);
//        ellipse(100,70,60,60);
//        fill(191, 242, 5);
//        ellipse(81,70,16,32);
//        ellipse(119,70,16,32);
//        line(90,150,80,160);
//        line(110,150,120,160);
//    };

//    public void draw() {
//    }
public void draw() {
    background(50, 168, 82);

    // Center of the canvas
    float centerX = width/2;
    float centerY = height/2;
    float radius = 200; // Distance from center
    int pink = color(255, 153, 204); // Pink color for the background
    // Draw 5 rotated versions
    for (int i = 0; i < 5; i++) {
        pushMatrix();
        // Position each image in a circle
        translate(centerX, centerY);
        float angle = TWO_PI * i / 5;
        rotate(angle); // Rotate around center

        // Move out from center and rotate to point upwards
        translate(0, -radius);
        rotate(-angle); // Counter-rotate to keep top vertical

        drawImage(); // Draw your image
        popMatrix();
    }
}

    // Your image function (renamed to avoid confusion with Processing's image())
    void drawImage() {
        rectMode(CENTER);
        fill(242, 200, 5);
        rect(0, 0, 20, 100); // Changed coordinates to be relative
        fill(242, 228, 5);
        ellipse(0, -30, 60, 60); // Adjusted y-coordinate
        fill(191, 242, 5);
        ellipse(-19, -30, 16, 32);
        ellipse(19, -30, 16, 32);
        line(-10, 50, -20, 60);
        line(10, 50, 20, 60);
    }
}
