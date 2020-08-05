boolean mode = true;

int num = 10;
int imageCount;
Star[] sArray ={};

void setup() {
  fullScreen(P3D);
  colorMode(HSB, 360, 100, 100);
  background(0, 0, 100);
  imageCount = 0;
  noCursor();
}

void draw() {

  translate(width/2, height/2);
  rotateY(frameCount/240.0);
  if (mode == true) {
    background(0, 0, 100);
  } else {
    background(0, 0, 0);
  }

  noFill();

  for (int i=0; i<sArray.length; i++) {
    Star star = sArray[i];
    star.updateMe(mode);
  }
}

void keyPressed() {
  if (key == 'a') {
    drawStar();
  }
  if (key == 'b') {
    if (mode == true) {
      mode = false;
    } else {
      mode = true;
    }
  }
  if (key == 's') {
    save("Boolean" + imageCount +mode+ ".png");
    imageCount++;
  }
}

void drawStar() {
  for (int i=0; i<=num; i++) {
    Star star = new Star(mode);
    star.drawMe();
    sArray = (Star[])append(sArray, star);
  }
}
