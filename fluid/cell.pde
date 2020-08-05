class Cell {
  float x, y;
  float d;
  float radius;
  float state;
  float nextState;
  float lastState = 1;
  float h;
  Cell[] neighbours;

  Cell(float ex, float why, float r,float mx,float my) {
    x = ex * cellSize;
    y = why * cellSize;
    radius = r;
    nextState = (((x-500)/500) + ((y-500)/200))*8;
    state = nextState;
    d = dist(x, y, mx, my);
    h = 260-(d/20);
    neighbours = new Cell[0];
  }

  void addNeighbour(Cell cell) {
    neighbours = (Cell[])append(neighbours, cell);
  }

  void calcNextState() {
    float total = 0;
    for (int i= 0; i<neighbours.length; i++) {
      total += neighbours[i].state;
    }
    float average = int(total/8);

    if (average == 255) {
      nextState = 0;
    } else if (average == 0) {
      nextState = 255;
    } else {
      nextState = state + average;
      if (lastState > 0) {
        nextState -= lastState;
      }
      if (nextState >255) {
        nextState = 255;
      } else if (nextState < 0) {
        nextState = 0;
      }
    }
    lastState = state;
  }
  
  void updateMe(float mx,float my){
    d = dist(x, y, mx, my);
    h = 260-(d/10);
  }

  void drawMe() {
    state = nextState;
    if (d<r) {
      state += 200;
    }

    fill(h, state, 255);
    rect(x, y, cellSize, cellSize);
  }
}
