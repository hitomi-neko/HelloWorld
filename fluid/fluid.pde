import processing.sound.*;

Cell[][] cellArray;
int cellSize = 5;
int numX, numY;
float r;

int value;
int count;
int imageCount;


SoundFile cellSound;

void setup() {

  frameRate(60);

  noCursor();

  fullScreen();
  numX = floor(1000/cellSize);
  numY = floor(1000/cellSize);
  
  count = 0;
  imageCount = 0;

  restart();
  colorMode(HSB, 360, 255, 255, 255);
  rectMode(CENTER);
  textAlign(CENTER);
  background(255,0,255);

  cellSound = new SoundFile(this, "teardrop1.mp3");
  cellSound.loop();
}

void draw() {
  background(255,0,255);
  noStroke();
  translate(width/2 -500, height/2 -500);

  for (int x=0; x<numX; x++) {
    for (int y=0; y<numY; y++) {
      cellArray[x][y].calcNextState();
    }
  }
  for (int x=0; x<numX; x++) {
    for (int y=0; y<numY; y++) {
      cellArray[x][y].updateMe(mouseX,mouseY);
      cellArray[x][y].drawMe();
    }
  }

  count++;

  value = 10;

  r = map(value, 0, 100, 0, 300);

  float rate = map(value, -40, 100, 0.0, 2.0);
  cellSound.rate(rate);
  float amp = map(value, -10, 100, 0.1, 2.0);
  cellSound.amp(amp);
}


void restart() {
  cellArray = new Cell[numX][numY];
  for (int x=0; x<numX; x++) {
    for (int y=0; y<numY; y++) {
      Cell newCell = new Cell(x, y, r, mouseX, mouseY);
      cellArray[x][y] = newCell;
    }
  }

  for (int x=0; x<numX; x++) {
    for (int y=0; y<numY; y++) {
      int above = y-1;
      int below = y +1;
      int left = x-1;
      int right = x+1;

      if (above<0) {
        above = numY-1;
      }
      if (below == numY) {
        below = 0;
      }
      if (left<0) {
        left = numX-1;
      }
      if (right == numX) {
        right = 0;
      }

      cellArray[x][y].addNeighbour(cellArray[left][above]);
      cellArray[x][y].addNeighbour(cellArray[left][y]);
      cellArray[x][y].addNeighbour(cellArray[left][below]);
      cellArray[x][y].addNeighbour(cellArray[x][below]);
      cellArray[x][y].addNeighbour(cellArray[right][below]);
      cellArray[x][y].addNeighbour(cellArray[right][y]);
      cellArray[x][y].addNeighbour(cellArray[right][above]);
      cellArray[x][y].addNeighbour(cellArray[x][above]);
    }
  }
}

void keyPressed() {
  if (key == 's') {
    save("Fluid" +imageCount+ ".png");
    imageCount++;
  }
}
