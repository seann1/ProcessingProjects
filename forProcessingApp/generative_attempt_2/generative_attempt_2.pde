int cols = 60;
int rows = 60;
float xoff = 0.0;
float yoff = 0.0;
int colWidth;
int rowHeight;
color[][] noiseColors = new color[cols][rows];
color otherColor = #3B4C4F;
color yellow = #EAC448;
color lightBlue = #AED1D6;
color red = #F43A15;
color black = #141414;
color pickColor(float noiseValue) {
  if (noiseValue < 0.25) {
    return yellow;
  } else if (noiseValue < 0.5) {
    return lightBlue;
  } else if (noiseValue < 0.75) {
    return red;
  } else {
    return black;
  }
}

void setup() {
  size(600,600, P2D);
  colWidth = width/cols;
  rowHeight = height/rows;
    for (int x = 0; x < cols; x++) {
      for (int y = 0; y < rows; y++) {
        float currentNoise = noise(x*0.1F, y*0.1F);
        color currentColor = color(pickColor(currentNoise));
        noiseColors[x][y] = currentColor;

        yoff += 0.01;
      }
    xoff += 0.01;
  }
}

void draw() {
  if (frameCount % 20 == 0) {
    updateColors();
  }
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      noStroke();
      fill(noiseColors[x][y]);
      square(colWidth*x, rowHeight*y, colWidth);
      yoff += 0.01;
    }
    xoff += 0.01;
  }
  
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      color c = noiseColors[x][y];
      float cx = colWidth * x + colWidth / 2;
      float cy = rowHeight * y + rowHeight / 2;
      float r = colWidth * 0.4;
      //if (c == red) { // If square is red
  
      //  drawCrescent(cx, cy, r);
      //}
      //if (c == lightBlue) {
      //  drawTriangle(x, y);
      //}
    }
  }

}

void updateColors() {
  color[][] nextColors = new color[cols][rows];

  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      int currentColor = noiseColors[x][y];

      // Gather neighbors: list of [nx, ny]
      ArrayList<int[]> neighbors = new ArrayList<int[]>();
      for (int dx = -1; dx <= 1; dx++) {
        for (int dy = -1; dy <= 1; dy++) {
          if (dx == 0 && dy == 0) continue;
          int nx = x + dx;
          int ny = y + dy;

          if (nx >= 0 && nx < cols && ny >= 0 && ny < rows) {
            neighbors.add(new int[]{nx, ny});
          }
        }
      }

      boolean changed = false;

      // Check all combinations of 3 neighbors
      for (int i = 0; i < neighbors.size(); i++) {
        for (int j = i + 1; j < neighbors.size(); j++) {
          for (int k = j + 1; k < neighbors.size(); k++) {
            int[] a = neighbors.get(i);
            int[] b = neighbors.get(j);
            int[] c = neighbors.get(k);

            int ca = noiseColors[a[0]][a[1]];
            int cb = noiseColors[b[0]][b[1]];
            int cc = noiseColors[c[0]][c[1]];

            // Check color match
            if (ca == cb && cb == cc) {
              // Check adjacency between all three
              boolean abAdj = isAdjacent(a, b);
              boolean bcAdj = isAdjacent(b, c);
              boolean acAdj = isAdjacent(a, c);

              int connectionCount = 0;
              if (abAdj) connectionCount++;
              if (bcAdj) connectionCount++;
              if (acAdj) connectionCount++;
              
              if (connectionCount >= 2) {
                // They're all connected in a group
                nextColors[x][y] = ca;
                changed = true;
                break;
              } else {
                nextColors[x][y] = otherColor;
                changed = true;
              }
            }
          }
          if (changed) break;
        }
        if (changed) break;
      }

      if (!changed) {
        nextColors[x][y] = currentColor;
      }
      if (nextColors[x][y] == yellow) {
      
      }
    }
  }

  noiseColors = nextColors;

  if (allSameColor(noiseColors)) {
    println("Grid unified — resetting...");
    regenerateGrid();
  }
}

boolean isAdjacent(int[] a, int[] b) {
  return abs(a[0] - b[0]) <= 1 && abs(a[1] - b[1]) <= 1;
}



boolean allSameColor(color[][] grid) {
  color reference = grid[0][0];
  int diffCount = 0;
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      if (grid[x][y] != reference && grid[x][y] != otherColor) {
        diffCount +=1;
      }
    }
  }
  if (diffCount < 40) {
    return true;
  }
    return false;
}

void regenerateGrid() {
  noiseSeed((int)random(10000));
  float xoff = 0.0;
  float yoff = 0.0;
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      float currentNoise = noise(x * 0.1F, y * 0.1F);
      color currentColor = pickColor(currentNoise);
      noiseColors[x][y] = currentColor;
      yoff += 0.01;
    }
    xoff += 0.01;
  }
}

void drawCrescent(float x, float y, float radius) {
  noStroke();
  
  // Main circle (moon body)
  fill(red(yellow), green(yellow), blue(yellow), 200); // Slightly transparent white
  ellipse(x, y, radius * 2, radius * 2);
  
  // Cutout circle (shadow)
  fill(0, 0, 0, 0); // Fully transparent
  blendMode(ADD);
  ellipse(x + radius * 0.4, y, radius * 2, radius * 2);
  blendMode(BLEND);
//  beginShape();
//vertex(288.0, 149.0);
//bezierVertex(288.0, 149.0, 288.0, 149.0, 288.0, 149.0);
//bezierVertex(288.0, 149.0, 215.0, 114.0, 197.0, 171.0);
//bezierVertex(179.0, 228.0, 245.0, 254.0, 245.0, 254.0);
//bezierVertex(245.0, 254.0, 208.0, 207.0, 231.0, 176.0);
//bezierVertex(254.0, 145.0, 288.0, 152.0, 288.0, 152.0);
//endShape();
}

void drawTriangle(int x, int y) {
  float x0 = x * colWidth;
  float y0 = y * rowHeight;
  float x1 = x0 + colWidth;
  float y1 = y0 + rowHeight;
  // 208, 237, 24
  //println(x*y);
  //colorMode(HSB);
  //fill(map(x*y, 0, 3600, 0, 255), map(x*y, 0, 3600, 0, 255), 255);
  //colorMode(RGB);
  fill(208, 237, 24);  // semi-transparent black
  noStroke();
  
  // Draw triangle from top-left to bottom-right
  triangle(x0, y0, x1, y0, x1, y1);
}
