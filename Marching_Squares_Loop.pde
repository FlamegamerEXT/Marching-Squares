int MAX_STEP = 1000, step = 0, RES = 4;
float THRESHOLD_VALUE = 0.5, PERLIN_SCALE = 0.015;
boolean record = false;  // WARNING! Will create 1000 .png image files if true

void setup(){
  size(1000, 600);
  noStroke();
  fill(200, 55, 55);
}

void draw(){
  clear();
  // Draw each square
  for (int y = 0; y <= height-RES; y+=RES){
    for (int x = 0; x <= width-RES; x+=RES){
      drawSquare(x, y);
    }
  }
  
  // Increment step, or loop back to 0
  step = (step + 1)%MAX_STEP;
  
  // Save frames
  if (record){
    saveFrame("output/gif-"+nf(step, 3)+".png");
    if (step == 0){
      exit();
    }
  }
}

/** Returns a value to be used in drawing the 'marching squares' */
float getValue(float xf, float yf){
  // The noise function is built into Processing, and uses classic Perlin noise
  float ans = 0;
  for (int i = 0; i < 2; i++){  // Takes the weighted average of two different points of noise
    int phase = step - i*MAX_STEP;
    ans += noise(xf*PERLIN_SCALE, yf*PERLIN_SCALE, phase*0.01)*abs(phase)/MAX_STEP;
  }
  return ans;
}

/** Returns a unique int to represent the 'state' of the square */
int getState(float nw, float ne, float sw, float se){
  int state = 0;
  if (nw > THRESHOLD_VALUE){ state += 8; }
  if (ne > THRESHOLD_VALUE){ state += 4; }
  if (se > THRESHOLD_VALUE){ state += 2; }
  if (sw > THRESHOLD_VALUE){ state++; }
  return state;
}

/** Fills this 'marching square' with a shape to represent part of the field, represented by getValue(x, y) */
void drawSquare(float x, float y){
  float nw = getValue(x, y), ne = getValue(x+RES, y), sw = getValue(x, y+RES), se = getValue(x+RES, y+RES);
  int state = getState(nw, ne, sw, se);
  float nMid = (nw - THRESHOLD_VALUE)/(nw - ne), sMid = (sw - THRESHOLD_VALUE)/(sw - se);
  float wMid = (nw - THRESHOLD_VALUE)/(nw - sw), eMid = (ne - THRESHOLD_VALUE)/(ne - se);
  
  // Create a shape within a given 'marching' square
  beginShape();
  switch (state) {
    case 0:
      // No fill, so no lines
      break;
    case 1:
      // Fill triangle in the south-west corner
      vertex(x, y + wMid*RES);
      vertex(x, y + RES);
      vertex(x + sMid*RES, y + RES);
      break;
    case 2:
      // Fill triangle in the south-east corner
      vertex(x + RES, y + eMid*RES);
      vertex(x + sMid*RES, y + RES);
      vertex(x + RES, y + RES);
      break;
    case 3:
      // Fill rectangle in the south half
      vertex(x + RES, y + eMid*RES);
      vertex(x, y + wMid*RES);
      vertex(x, y + RES);
      vertex(x + RES, y + RES);
      break;
    case 4:
      // Fill triangle in the north-east corner
      vertex(x + nMid*RES, y);
      vertex(x + RES, y);
      vertex(x + RES, y + eMid*RES);
      break;
    case 5:
    // Fill triangle in the south-west corner
      vertex(x, y + wMid*RES);
      vertex(x, y + RES);
      vertex(x + sMid*RES, y + RES);
      // If the value at the center is above the THRESHOLD_VALUE, break the shape into triangles 
      // else, if the value is below the THRESHOLD_VALUE, keep the polygon linked
      if (getValue(x + 0.5*RES, y + 0.5*RES) > THRESHOLD_VALUE){
        endShape(CLOSE);
        beginShape();
      }
      // Fill triangle in the south-east corner
      vertex(x + RES, y + eMid*RES);
      vertex(x + RES, y);
      vertex(x + nMid*RES, y);
      break;
    case 6:
      // Fill rectangle in the east half
      vertex(x + sMid*RES, y + RES);
      vertex(x + nMid*RES, y);
      vertex(x + RES, y);
      vertex(x + RES, y + RES);
      break;
    case 7:
      // Fill the whole square except in the north-west corner
      vertex(x + nMid*RES, y);
      vertex(x, y + wMid*RES);
      vertex(x, y + RES);
      vertex(x + RES, y + RES);
      vertex(x + RES, y);
      break;
    case 8:
      // Fill triangle in the north-west corner
      vertex(x + nMid*RES, y);
      vertex(x, y + wMid*RES);
      vertex(x, y);
      break;
    case 9:
      // Fill rectangle in the north half
      vertex(x + sMid*RES, y + RES);
      vertex(x + nMid*RES, y);
      vertex(x, y);
      vertex(x, y + RES);
      break;
    case 10:
      // Fill triangle in the south-east corner
      vertex(x + RES, y + eMid*RES);
      vertex(x + RES, y + RES);
      vertex(x + sMid*RES, y + RES);
      // If the value at the center is above the THRESHOLD_VALUE, break the shape into triangles 
      // else, if the value is below the THRESHOLD_VALUE, keep the polygon linked
      if (getValue(x + 0.5*RES, y + 0.5*RES) > THRESHOLD_VALUE){
        endShape(CLOSE);
        beginShape();
      }
      // Fill triangle in the north-west corner
      vertex(x, y + wMid*RES);
      vertex(x, y);
      vertex(x + nMid*RES, y);
      break;
    case 11:
      // Fill the whole square except in the north-east corner
      vertex(x + nMid*RES, y);
      vertex(x, y);
      vertex(x, y + RES);
      vertex(x + RES, y + RES);
      vertex(x + RES, y + eMid*RES);
      break;
    case 12:
      // Fill rectangle in the north half
      vertex(x + RES, y + eMid*RES);
      vertex(x, y + wMid*RES);
      vertex(x, y);
      vertex(x + RES, y);
      break;
    case 13:
      // Fill the whole square except in the south-east corner
      vertex(x + sMid*RES, y + RES);
      vertex(x + RES, y + eMid*RES);
      vertex(x + RES, y);
      vertex(x, y);
      vertex(x, y + RES);
      break;
    case 14:
      // Fill the whole square except in the south-west corner
      vertex(x + sMid*RES, y + RES);
      vertex(x, y + wMid*RES);
      vertex(x, y);
      vertex(x + RES, y);
      vertex(x + RES, y + RES);
      break;
    case 15:
      // All filled, so no lines
      rect(x, y, RES, RES);
      break;
     default:
       break;
  }
  endShape(CLOSE);
}
