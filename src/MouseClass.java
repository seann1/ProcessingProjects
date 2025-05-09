import processing.core.PApplet;

public class MouseClass extends PApplet {
    public static void main(String[] args) {
        PApplet.main("MouseClass", args);
    }
    String sentence = "Hello World!";
    int red = color(255, 0, 0);
    int blue = color(0, 0, 255);
    public void settings() {
        size(600, 600);
    }

    public void setup ()
    {
        println("Red: " + binary(red));
        println("Blue: " + binary(blue));
        background(100,0,100);
        frameRate(5);
//        colorMode(HSB);
    }

    public void draw () {
        float centerX = width / 2;
        float centerY = height / 2;

        fill(random(0, 255), random(0, 255), random(0, 255));
        float circleSize = random(20, 200);
        ellipse(centerX, centerY, circleSize, circleSize);
        fill(random(0, 255), random(0, 255), random(0, 255));
        ellipse(mouseX, mouseY, random(20, 100), random(20, 100));
    }
}
