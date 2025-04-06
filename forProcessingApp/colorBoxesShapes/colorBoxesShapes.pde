

int background_palette = #1d1d1b;
int outline_palette = #f2f2e7;
int[] color_palette = {
  #ffb000,
  #ff4200,
  #7da030,
  #ff99cc,
  #1d1d1b,
  #f2f2e7
};

float sine_scale = 0.01f;

int grid_columns_qty;
int grid_rows_qty;
float seed;

void setup() {
  size(800, 800);
  strokeJoin(ROUND);
  
  grid_columns_qty = floor(random(3, 7));
  float module_size = width / (float)grid_columns_qty;
  grid_rows_qty = ceil(height/module_size);
  seed = random(1000);

  // EN - Draw a grid of squares and within each square a geometric graphic is drawn...
}

void draw() {
  background(220);
  randomSeed((long)seed);
  grid(0, 0, grid_columns_qty, grid_rows_qty, (float)width);
}

void grid(float initial_x, float initial_y, int columns_qty, int rows_qty, float total_width) {
  
  stroke(background_palette);
  strokeWeight(1);
  
  float module_size = total_width / (float)columns_qty;
  float differential_movement = 0;
  for (int j = 0; j < rows_qty; j++) {
    for (int i = 0; i < columns_qty; i++) {
      
      float x = initial_x + i * module_size;
      float y = initial_y + j * module_size;
      
      int color_index = floor(random(color_palette.length - 1));
      fill(color(color_palette[color_index]));
      rect(x, y, module_size, module_size);
      fill(color(color_palette[(color_index + 1) % color_palette.length]));
      
      float movement = map(sin(frameCount * sine_scale + differential_movement), -1, 1, 0, 1);
      
      int selector = floor(random(6 + 3));
      
      if (selector == 0) {
        float outer_radius = module_size / 2 - 5;
        float inner_radius = outer_radius * movement;
        int points_qty = (int)random(4, 18);
        star(x + module_size / 2, y + module_size / 2, inner_radius, outer_radius, points_qty, 0);
      }
      
      if (selector == 1) {
        float diameter = random(module_size/2, module_size) * movement;
        circle(x + module_size / 2, y + module_size / 2, diameter);
      }
      
      if (selector == 2) {
        int points = (int)random(3, 13);
        float points_height = map(movement, 0, 1, 0.2f, 0.8f);
        double_crown(x, y, module_size, module_size, points, points_height);
      }
      
      if (selector == 3) {
        float handle_width = map(movement, 0, 1, 0.2f, 0.8f);
        axe(x, y, module_size, module_size, handle_width);
      }
      
      if (selector == 4) {
        float opening_width = random(0.4f, 1) * movement;
        rhombus(x, y, module_size, module_size, opening_width);
      }
      if (selector >= 5 && module_size > 60) {
        grid(x, y, 2, 2, module_size);
      }
      differential_movement += 1;
    }
  }
}

void star(float x, float y, float inner_radius, float outer_radius, int points_qty, float initial_angle) {
  float step = TWO_PI / points_qty;
  beginShape();
  for (int i = 0; i < points_qty; i++) {
    float ang = initial_angle + step * i;
    float inner_x = x + cos(ang) * inner_radius;
    float inner_y = y + sin(ang) * inner_radius;
    vertex(inner_x, inner_y);
    float outer_x = x + cos(ang + step / 2.0f) * outer_radius;
    float outer_y = y + sin(ang + step / 2.0f) * outer_radius;
    vertex(outer_x, outer_y);
  }
  endShape(CLOSE);
}

void simple_crown(float x, float y, float width, float height, int points_qty, float points_relative_height) {
  float points_height = height * points_relative_height;
  float points_displacement = width / (points_qty - 1);
  float point_x = 0.0, point_y = 0.0;
  beginShape();
  for (int i = 0; i < points_qty; i++) {
    point_x = x + i * points_displacement;
    point_y = y;
    if (i % 2 != 0) {
      point_y = y + points_height;
    }
    vertex(point_x, point_y);
  }
  vertex(x + width, point_y + height);
  vertex(x, point_y + height);
  endShape(CLOSE);
}

void double_crown(float x, float y, float width, float height, int points_qty, float points_relative_height) {
  float points_height = height * points_relative_height / 2;
  float points_displacement = width / (points_qty - 1);
  beginShape();
  for (int i = 0; i < points_qty; i++) {
    float point_x = x + i * points_displacement;
    float point_y = y;
    if (i % 2 != 0) {
        point_y = y + points_height;
    }
    vertex(point_x, point_y);
  }
  for (int i = 0; i < points_qty; i++) {
    float point_x = (x + width) - (i * points_displacement);
    float point_y = y + height;
    if (i % 2 != 0) {
        point_y = (y + height) - points_height;
    }
    vertex(point_x, point_y);
  }
  endShape(CLOSE);
}

void axe(float x, float y, float width, float height, float handle_relative_width) {
  float handle_width = width * handle_relative_width / 2;
  beginShape();
  vertex(x, y);
  vertex(x + handle_width, y + handle_width);
  vertex(x + handle_width, y);
  vertex(x + (width - handle_width), y);
  vertex(x + (width - handle_width), y + handle_width);
  vertex(x + width, y);
  vertex(x + width, y + height);
  vertex(x + (width - handle_width), y + (height - handle_width));
  vertex(x + (width - handle_width), y + height);
  vertex(x + handle_width, y + height);
  vertex(x + handle_width, y + (height - handle_width));
  vertex(x, y + height);
  endShape(CLOSE);
}

void rhombus(float x, float y, float width, float height, float opening_relative) {
  float opening_width = width * opening_relative / 2;
  beginShape();
  vertex(x + opening_width, y + height / 2);
  vertex(x + width / 2, y);
  vertex(x + (width - opening_width), y + height / 2);
  vertex(x + width / 2, y + height);
  endShape(CLOSE);
}
