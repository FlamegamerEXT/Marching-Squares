int MAX_STEP = 100, step = 0, RES = 4;
float THRESHOLD_VALUE, PERLIN_SCALE = 0.02;
float[][] rands = new float[600/RES + 1][960/RES + 1];

void setup(){
  size(960, 600);
  //noStroke();
  THRESHOLD_VALUE = 1;
  calculateRands();
}

void draw(){
  //if (step%MAX_STEP == 0){
  //  step = 0;
  //  calculateRands();
  //  drawSquares();
  //}
  drawSquares();
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
  //int x = (int)xf/RES, y = (int)yf/RES;
  //if (x + y != (int)((xf + yf)/RES)){
  //  return (rands[y][x]+rands[y][x+1]+rands[y+1][x]+rands[y+1][x+1])/4;
  //}
  //return rands[y][x];
  return 2*noise(xf*PERLIN_SCALE, yf*PERLIN_SCALE, step*0.01);
}

void drawSquares(){
  clear();
  stroke(255);
  fill(55, 55, 200);
  for (int y = 0; y < height; y+=RES){
    for (int x = 0; x < width; x+=RES){
      float nw = getValue(x, y), ne = getValue(x+RES, y), sw = getValue(x, y+RES), se = getValue(x+RES, y+RES);
      int state = getState(nw, ne, sw, se);
      
      beginShape();
      switch(state){
        case 0:
          // No fill, so no lines
          break;
        case 1:
          vertex(x, y + 0.5*RES);
          vertex(x, y + RES);
          vertex(x + 0.5*RES, y + RES);
          //line(x, y + 0.5*RES, x + 0.5*RES, y + RES);
          break;
        case 2:
          vertex(x + RES, y + 0.5*RES);
          vertex(x + 0.5*RES, y + RES);
          vertex(x + RES, y + RES);
          //line(x + 0.5*RES, y + RES, x + RES, y + 0.5*RES);
          break;
        case 3:
          vertex(x + RES, y + 0.5*RES);
          vertex(x, y + 0.5*RES);
          vertex(x, y + RES);
          vertex(x + RES, y + RES);
          //line(x, y + 0.5*RES, x + RES, y + 0.5*RES);
          break;
        case 4:
          vertex(x + 0.5*RES, y);
          vertex(x + RES, y);
          vertex(x + RES, y + 0.5*RES);
          //line(x + 0.5*RES, y, x + RES, y + 0.5*RES);
          break;
        case 5:
          vertex(x, y + 0.5*RES);
          vertex(x, y + RES);
          vertex(x + 0.5*RES, y + RES);
          if (getValue(y + 0.5*RES, y + 0.5*RES) > THRESHOLD_VALUE){
            endShape(CLOSE);
            beginShape();
          }
          vertex(x + RES, y + 0.5*RES);
          vertex(x + RES, y);
          vertex(x + 0.5*RES, y);
          //if (getValue(y + 0.5*RES, y + 0.5*RES) > THRESHOLD_VALUE){
          //  line(x + 0.5*RES, y + RES, x + RES, y + 0.5*RES);
          //  line(x, y + 0.5*RES, x + 0.5*RES, y);
          //} else {
          //  line(x, y + 0.5*RES, x + 0.5*RES, y + RES);
          //  line(x + 0.5*RES, y, x + RES, y + 0.5*RES);
          //}
          break;
        case 6:
          vertex(x + 0.5*RES, y + RES);
          vertex(x + 0.5*RES, y);
          vertex(x + RES, y);
          vertex(x + RES, y + RES);
          //line(x + 0.5*RES, y, x + 0.5*RES, y + RES);
          break;
        case 7:
          vertex(x + 0.5*RES, y);
          vertex(x, y + 0.5*RES);
          vertex(x, y + RES);
          vertex(x + RES, y + RES);
          vertex(x + RES, y);
          //line(x, y + 0.5*RES, x + 0.5*RES, y);
          break;
        case 8:
          vertex(x + 0.5*RES, y);
          vertex(x, y + 0.5*RES);
          vertex(x, y);
          //line(x, y + 0.5*RES, x + 0.5*RES, y);
          break;
        case 9:
          vertex(x + 0.5*RES, y + RES);
          vertex(x + 0.5*RES, y);
          vertex(x, y);
          vertex(x, y + RES);
          //line(x + 0.5*RES, y, x + 0.5*RES, y + RES);
          break;
        case 10:
          vertex(x + RES, y + 0.5*RES);
          vertex(x + RES, y + RES);
          vertex(x + 0.5*RES, y + RES);
          if (getValue(y + 0.5*RES, y + 0.5*RES) > THRESHOLD_VALUE){
            endShape(CLOSE);
            beginShape();
          }
          vertex(x, y + 0.5*RES);
          vertex(x, y);
          vertex(x + 0.5*RES, y);
          //if (getValue(y + 0.5*RES, y + 0.5*RES) > THRESHOLD_VALUE){
          //  line(x, y + 0.5*RES, x + 0.5*RES, y + RES);
          //  line(x + 0.5*RES, y, x + RES, y + 0.5*RES);
          //} else {
          //  line(x + 0.5*RES, y + RES, x + RES, y + 0.5*RES);
          //  line(x, y + 0.5*RES, x + 0.5*RES, y);
          //}
          break;
        case 11:
          vertex(x + 0.5*RES, y);
          vertex(x, y);
          vertex(x, y + RES);
          vertex(x + RES, y + RES);
          vertex(x + RES, y + 0.5*RES);
          //line(x + 0.5*RES, y, x + RES, y + 0.5*RES);
          break;
        case 12:
          vertex(x + RES, y + 0.5*RES);
          vertex(x, y + 0.5*RES);
          vertex(x, y);
          vertex(x + RES, y);
          //line(x, y + 0.5*RES, x + RES, y + 0.5*RES);
          break;
        case 13:
          vertex(x + 0.5*RES, y + RES);
          vertex(x + RES, y + 0.5*RES);
          vertex(x + RES, y);
          vertex(x, y);
          vertex(x, y + RES);
          //line(x + 0.5*RES, y + RES, x + RES, y + 0.5*RES);
          break;
        case 14:
          vertex(x + 0.5*RES, y + RES);
          vertex(x, y + 0.5*RES);
          vertex(x, y);
          vertex(x + RES, y);
          vertex(x + RES, y + RES);
          //line(x, y + 0.5*RES, x + 0.5*RES, y + RES);
          break;
        case 15:
          // All filled, so no lines
          rect(x, y, RES, RES);
          break;
      }
      endShape(CLOSE);
    }
  }
  //noStroke();
  //for (int row = 0; row <= height/RES; row++){
  //  for (int col = 0; col <= width/RES; col++){
  //    fill(rands[row][col]*125);
  //    ellipse(col*RES, row*RES, RES*0.5, RES*0.5);
  //  }
  //}
}

int getState(float nw, float ne, float sw, float se){
  int state = 0;
  if (nw > THRESHOLD_VALUE){ state += 8; }
  if (ne > THRESHOLD_VALUE){ state += 4; }
  if (se > THRESHOLD_VALUE){ state += 2; }
  if (sw > THRESHOLD_VALUE){ state++; }
  return state;
}
