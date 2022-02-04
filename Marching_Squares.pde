int MAX_STEP = 100, step = 0, RES = 40, THRESHOLD_VALUE;
float[][] rands = new float[600/RES + 1][960/RES + 1];

void setup(){
  size(960, 600);
  //noStroke();
  THRESHOLD_VALUE = 1;
  calculateRands();
}

void draw(){
  if (step == MAX_STEP){
    step = 0;
    calculateRands();
    drawSquares();
  }
  step++;
}

void calculateRands(){
  for (int row = 0; row <= height/RES; row++){
    for (int col = 0; col <= width/RES; col++){
      rands[row][col] = random(2);
    }
  }
}

float getValue(float xf, float yf){
  int x = (int)xf/RES, y = (int)yf/RES;
  if (x + y != (int)((xf + yf)/RES)){ return 2; }
  return rands[y][x];
}

void drawSquares(){
  clear();
  noStroke();
  for (int row = 0; row <= height/RES; row++){
    for (int col = 0; col <= width/RES; col++){
      fill(rands[row][col]*125);
      ellipse(col*RES, row*RES, RES*0.5, RES*0.5);
    }
  }
  stroke(255);
  for (int y = 0; y < height; y+=RES){
    for (int x = 0; x < width; x+=RES){
      float nw = getValue(x, y), ne = getValue(x+RES, y), sw = getValue(x, y+RES), se = getValue(x+RES, y+RES);
      int state = getState(nw, ne, sw, se);
      switch(state){
        case 0:
          // No fill, so no lines
          break;
        case 1:
          line(x, y + 0.5*RES, x + 0.5*RES, y + RES);
          break;
        case 2:
          line(x + 0.5*RES, y + RES, x + RES, y + 0.5*RES);
          break;
        case 3:
          line(x, y + 0.5*RES, x + RES, y + 0.5*RES);
          break;
        case 4:
          line(x + 0.5*RES, y, x + RES, y + 0.5*RES);
          break;
        case 5:
          if (getValue(y + 0.5*RES, y + 0.5*RES) > THRESHOLD_VALUE){
            line(x + 0.5*RES, y + RES, x + RES, y + 0.5*RES);
            line(x, y + 0.5*RES, x + 0.5*RES, y);
          } else {
            line(x, y + 0.5*RES, x + 0.5*RES, y + RES);
            line(x + 0.5*RES, y, x + RES, y + 0.5*RES);
          }
          break;
        case 6:
          line(x + 0.5*RES, y, x + 0.5*RES, y + RES);
          break;
        case 7:
          line(x, y + 0.5*RES, x + 0.5*RES, y);
          break;
        case 8:
          line(x, y + 0.5*RES, x + 0.5*RES, y);
          break;
        case 9:
          line(x + 0.5*RES, y, x + 0.5*RES, y + RES);
          break;
        case 10:
          if (getValue(y + 0.5*RES, y + 0.5*RES) > THRESHOLD_VALUE){
            line(x, y + 0.5*RES, x + 0.5*RES, y + RES);
            line(x + 0.5*RES, y, x + RES, y + 0.5*RES);
          } else {
            line(x + 0.5*RES, y + RES, x + RES, y + 0.5*RES);
            line(x, y + 0.5*RES, x + 0.5*RES, y);
          }
          break;
        case 11:
          line(x + 0.5*RES, y, x + RES, y + 0.5*RES);
          break;
        case 12:
          line(x, y + 0.5*RES, x + RES, y + 0.5*RES);
          break;
        case 13:
          line(x + 0.5*RES, y + RES, x + RES, y + 0.5*RES);
          break;
        case 14:
          line(x, y + 0.5*RES, x + 0.5*RES, y + RES);
          break;
        case 15:
          // All filled, so no lines
          break;
      }
    }
  }
}

int getState(float nw, float ne, float sw, float se){
  int state = 0;
  if (nw > THRESHOLD_VALUE){ state += 8; }
  if (ne > THRESHOLD_VALUE){ state += 4; }
  if (se > THRESHOLD_VALUE){ state += 2; }
  if (sw > THRESHOLD_VALUE){ state++; }
  return state;
}
