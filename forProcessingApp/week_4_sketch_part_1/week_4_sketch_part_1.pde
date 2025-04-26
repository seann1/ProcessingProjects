// set number of rows and columns in sketch and initialize variables
int cols = 10;
int rows = 10;
int col_width;
int row_width;
int y;
int x;
float offset = 0;
// 1d array big enough to hold a value for each cell
float offsets[] = new float[rows * cols];
// arrays of arrays for x and y locations
float xloc[][] = new float[rows][cols];
float yloc[][] = new float[rows][cols];
// array of PVector arrays. Each PVector contains an x and y location
PVector locations[][] = new PVector[rows][cols];
// array of PVector arrays. Each PVector contains an x and y speed.
PVector speeds[][] = new PVector[rows][cols];



void setup () {
  size(600, 600);
    // get width and height of rows/columns by dividing the width/height by rows/cols
  col_width = width / cols;
  row_width = height / rows;
  print(offsets.length);
   // put a random float bewteen 1.0 and 5.0 in each place of the offsets array
  for (int i = 0; i < offsets.length; i++){
    offsets[i] = random(0.1, 0.5);
  }
  // nested for loops that loop through columns and rows. Loop through every row for each column.
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // set x and y location to column/row width * iterator + offset
      xloc[i][j] = i*(col_width) + col_width/2;
      yloc[i][j] = j*(row_width) + row_width/2;
      // set x and y location to PVector
      locations[i][j] = new PVector(
        i*(col_width) + col_width/2,
        j*(row_width) + row_width/2
      );
      // set a random speed for the current cell
      speeds[i][j] = PVector.random2D();
    }
  }
}

void draw () {
  // redraw black background on each frame
  background(0);
  offset += 0.1;
  // nested for loops for each cell again
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      noStroke();
      fill(255);
      //offsets[i*10 + j] += offsets[i*10 + j] / frameCount;
      //y = j*(row_width) + row_width/2;
      //locations[i][j].add(locations[j][i]);
      // update locations with speed values
      locations[i][j].add(speeds[i][j]);
      // move through perlin noise xoffset with frameCount and iterators to get a different value for each cell on each frame
      float n = noise(frameCount / 100.0 + i*10 + j); // 0.008
      // draw a circle at the x and y location with a size of 100* the current perlin noise value
      circle(locations[i][j].x, locations[i][j].y, 100 * n);
    }
  }
  // draw grid lines
  drawLines();
  //println(millis());
}
// code for drawing grid lines
void drawLines () {
  stroke(#FF0000);
  // start x as half o col width, loop until x is greater than width
  for(int x = col_width/2; x < width; x += col_width){
    // draw a vertical line across the screen at x value
       line(x, 0, x, height);
  }
  // start y as half of row width, loop until y  is greater than height
  for(int y = row_width/2; y < height; y += row_width){
    // draw horizontal line across the screen from 0 to width
       line(0, y, width, y);
  }
}
