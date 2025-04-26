
// set number of rows and columns in sketch
int cols = 10;
int rows = 10;
int col_width;
int row_height;


float n;
float r;
float nmax;

// array of PVector arrays. Each PVector contains an x and y location
PVector locations[][] = new PVector[rows][cols];
// array of PVector arrays. Each PVector contains an x and y speed.
PVector speeds[][] = new PVector[rows][cols];

void setup () {
  size(600, 600);
  // get width and height of rows/columns by dividing the width/height by rows/cols
  col_width = width/ cols;
  row_height = height / rows;
  // nested for loops that loop through columns and rows. Loop through every row for each column.
  for(int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // set current cell's x and y location to PVector in locations array of arrays
      locations[i][j] = new PVector(
      // current iteration * col/row width + offset
        i * (col_width) + col_width/2,
        j * (row_height)+ row_height/2
      );
      // set a random speed for the current cell
      speeds[i][j] = PVector.random2D();
    }
  }
}

void draw () {
  // redraw black background on each frame
  background(0);
  // nested for loops for each cell again
  for(int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      
      stroke(#FF0000);
      fill(255);
      // update location of current cell with speed of current cell
      locations[i][j].add(speeds[i][j]);
      // move xOffset of perlin noise function with the current frame count and i and j to give each cell
      // a different value smoothly interpolated from the last one
      n = noise(frameCount / 100.0 + i*10 + j); // 0.008
      // radius = noise value * 100
      r = 100 * n;
      // flip sign of speed if location is greater than width/height to make the bouncing ball effect and 
      // keep the circles in the frame
      if(locations[i][j].x > width - r/2 || locations[i][j].x < 0 + r * 2) {
        speeds[i][j].x *= -1.0;
      }
      if (locations[i][j].y > height - r/2 || locations[i][j].y < 0 + r * 2) {
        speeds[i][j].y *= -1.0;
      }
      // draw circle
      circle(locations[i][j].x, locations[i][j].y, r);
      //stroke(#FF0000);
      //line(locations[i][j].x,
      //locations[i][j].y,
      //locations[i][j + 1 % rows].x,
      //locations[i][j + 1 % rows].y);
    }
  }
  //drawLines();
}
// unused draw lines function to draw grid
void drawLines () {
  for (int x = col_width/2; x < width; x += col_width) {
    line(x, 0, x, height);
  }
  for (int y = row_height/2; y < height; y += row_height) {
    line(0, y, width, y);
  }
}
