/*
a…分子
b…波紋/ランダム
c…線
v…イメージの変更
r…視点の回転/停止
s…画像の保存
*/


int num = 0;

Circle[] cArray = {};
Ripple[] rArray = {};
Line[] lArray = {};
Drop[] dArray = {};


float yRotation = random(6);
float xRotation = random(6);
float h = random(150, 250);
float hPlus = 0.5;

int mode = 1;
boolean eyeMode = false;
float saveX = 0;
float rad;
float x;
float px;
float z;
float pz;
int count = 1;
boolean whiteMode = true;
float randomMaker;

void setup() {
  fullScreen(P3D);
  colorMode(HSB, 360, 100, 100, 100);
  background(0, 0, 100);
}

void draw() {
  noStroke();

  translate(width/2, height/2);

  if (eyeMode == true) {
    saveX = mouseX-width/2;
  }
  rotateY(saveX*0.001f);
  rad = saveX*0.001f;

  x = (((mouseX-width/2)*sin(rad/2))*2)*cos(PI/2-(rad/2));
  px = (((pmouseX-width/2)*sin(rad/2))*2)*cos(PI/2-(rad/2));
  z = (((mouseX-width/2)*sin(rad/2))*2)*sin(PI/2-(rad/2));
  pz = (((pmouseX-width/2)*sin(rad/2))*2)*sin(PI/2-(rad/2));




  if (whiteMode == true) {
    background(0, 0, 100);
  } else {
    background(0, 0, 0);
  }

  for (int i=0; i<cArray.length; i++) {
    Circle circle = cArray[i];
    circle.updateMe();
  }

  for (int i=0; i<rArray.length; i++) {
    Ripple ripple = rArray[i];
    ripple.updateMe();
  }

  for (int i=0; i<lArray.length; i++) {
    Line line = lArray[i];
    line.updateMe();
  }

  for (int i=0; i<dArray.length; i++) {
    Drop drop = dArray[i];
    drop.updateMe();
  }

  noFill();
  h = h+hPlus;
  stroke(h, 100, 100, 30);
  if (h<150) {
    hPlus = hPlus * (-1);
  }
  if (h>250) {
    hPlus = hPlus * (-1);
  }
  strokeWeight(2);
  //box(2000, 2000, 2000); //確認用立方体

  if (mousePressed) {
    if (mode == 1) {
      drawCircle(x, z, whiteMode);
    } else if (mode == 2) {
      if (abs(rad) < PI/60) {
        drawRipple(whiteMode);
      } else {
        randomMaker = random(1,3);
        if(round(randomMaker) == 1){
          drawCircle(x, z, whiteMode);
        }else if(round(randomMaker) == 2){
          drawLine(x, px, z, pz, whiteMode);
        }else if(round(randomMaker) == 3){
          drawDrop(x, z, whiteMode);
        } 
      }
    } else if (mode == 3) {
      drawLine(x, px, z, pz, whiteMode);
    } else if (mode == 4) {
      drawDrop(x, z, whiteMode);
    }
  }
}



void keyPressed() {
  if (key == 'a') {
    mode = 1;
  } else if (key == 'b') {
    mode = 2;
  } else if (key == 'c') {
    mode = 3;
  } else if (key == 'd') {
    mode = 4;
  }

  if (key =='r') {
    if (eyeMode == false) {
      eyeMode = true;
    } else {
      eyeMode = false;
    }
  }
  if (key == 's') {
    save("Ripple" + count + ".png");
    count++;
  }
  if (key == 'v') {
    if (whiteMode == true) {
      whiteMode = false;
    } else {
      whiteMode = true;
    }
  }
}



void drawCircle(float x, float z, boolean mode) {
  for (int i=0; i<=num; i++) {
    Circle circle = new Circle(x, z, mode);
    circle.drawMe();
    cArray = (Circle[])append(cArray, circle);
  }
}

void drawRipple(boolean mode) {
  for (int i=0; i<=num; i++) {
    Ripple ripple = new Ripple(mode);
    ripple.drawMe();
    rArray = (Ripple[])append(rArray, ripple);
  }
}


void drawLine(float x, float px, float z, float pz, boolean mode) {
  for (int i=0; i<=num; i++) {
    Line line = new Line(x, px, z, pz, mode);
    line.drawMe();
    lArray = (Line[])append(lArray, line);
  }
}

void drawDrop(float x, float z, boolean mode) {
  for (int i=0; i<=num; i++) {
    Drop drop = new Drop(x, z, mode);
    drop.drawMe();
    dArray = (Drop[])append(dArray, drop);
  }
}


class Circle {
  float x, y, z;
  float radius;
  float lColor;
  float alph;
  float xSpeed, ySpeed, zSpeed;
  float colorNoiser;
  float m;
  float saveX1;
  float rad1;
  boolean colorMode;

  Circle(float worldX, float worldZ, boolean whiteMode) {
    x=mouseX-width/2+worldX ;
    y=mouseY-height/2;
    z=worldZ;

    colorMode = whiteMode;
    radius = random(20) +10;
    if (colorMode == true) {
      lColor = random(150, 250);
    } else {
      lColor = random(250, 350);
    }

    alph = random(30, 100);
    xSpeed = random(-5, 5);
    ySpeed = random(-5, 5);
    zSpeed = random(-5, 5);
    colorNoiser = noise(random(5));
    //m = (4*PI)/3*pow(radius,3);
  }

  void drawMe() {
    stroke(lColor, 100, 100, alph);
    fill(lColor, 100, 100, alph);
    strokeWeight(radius);
    point(x, y, z);
  }

  void updateMe() {
    x += xSpeed;
    y += ySpeed; 
    z += zSpeed;
    lColor += colorNoiser;
    m = (4*PI)/3*pow(radius, 3);

    if (colorMode == true) {
      if (lColor>300) {
        colorNoiser = colorNoiser*(-1);
      }
      if (lColor<60) {
        colorNoiser = colorNoiser*(-1);
      }
    } else {
      if (lColor>360) {
        colorNoiser = colorNoiser*(-1);
      }
      if (lColor<250) {
        colorNoiser = colorNoiser*(-1);
      }
    }

    if (x>1000-radius) {
      xSpeed = xSpeed*(-1);
    }
    if (x<-1000+radius) {
      xSpeed = xSpeed*(-1);
    }
    if (y>1000-radius) {
      ySpeed = ySpeed*(-1);
    }
    if (y<-1000+radius) {
      ySpeed = ySpeed*(-1);
    }
    if (z>1000-radius) {
      zSpeed = zSpeed*(-1);
    }
    if (z<-1000+radius) {
      zSpeed = zSpeed*(-1);
    }

    boolean touching = false;
    for (int i=0; i<cArray.length; i++) {
      Circle otherCircle = cArray[i];
      if (otherCircle != this) {
        float d = dist(x, y, z, otherCircle.x, otherCircle.y, otherCircle.z);
        if (d-(radius+otherCircle.radius)<0) {
          touching = true;
          radius--;
          break;
        }
        if (d < 100) {
          strokeWeight(1);
          line(x, y, z, otherCircle.x, otherCircle.y, otherCircle.z);
        }
        if (touching == true) {
          xSpeed = ((m-otherCircle.m)*xSpeed+2.0*otherCircle.m*otherCircle.xSpeed)/(m+otherCircle.m);
          ySpeed = ((m-otherCircle.m)*ySpeed+2.0*otherCircle.m*otherCircle.ySpeed)/(m+otherCircle.m);
          zSpeed = ((m-otherCircle.m)*zSpeed+2.0*otherCircle.m*otherCircle.zSpeed)/(m+otherCircle.m);
        }
      }

      if (radius < 0) {
        break;
      }

      drawMe();
    }
  }
}





class Ripple {
  float radius;
  float cent_x;
  float cent_y;
  float rColor;
  float radiusChanger;
  float alph;
  float colorNoiser;
  boolean colorMode;

  Ripple(boolean whiteMode) {
    radius = random(50)+10;
    cent_x=mouseX-width/2;
    cent_y=mouseY-height/2;

    if (whiteMode == true) {
      rColor = random(150, 250);
    } else {
      rColor = random(250, 350);
    }
    alph = random(30, 100);
    radiusChanger = noise(random(10));
    colorNoiser = noise(random(5));
  }

  void drawMe() {
    noFill();
    strokeWeight(1);
    stroke(rColor, 100, 100, alph);
    circle(cent_x, cent_y, radius);
  }

  void updateMe() {
    radius += radiusChanger;
    if (radius > 150) {
      radiusChanger = radiusChanger *(-1);
    }
    if (radius < 0) {
      radiusChanger = radiusChanger *(-1);
    }
    rColor += colorNoiser;
    if (colorMode == true) {
      if (rColor>300) {
        colorNoiser = colorNoiser*(-1);
      }
      if (rColor<60) {
        colorNoiser = colorNoiser*(-1);
      }
    } else {
      if (rColor>360) {
        colorNoiser = colorNoiser*(-1);
      }
      if (rColor<250) {
        colorNoiser = colorNoiser*(-1);
      }
    }

    drawMe();
  }
}





class Line {
  float x;
  float y;
  float px;
  float py;
  float lColor;
  float z;
  float pz;
  float zChanger;
  float yChanger;
  float xChanger;
  float colorChanger;
  float count;
  float w;
  boolean colorMode;

  Line(float worldX, float worldPx, float worldZ, float worldPz, boolean whiteMode) {
    x = mouseX-width/2+worldX;
    y = mouseY-height/2;
    px = pmouseX-width/2+worldPx;
    py = pmouseY-height/2;

    z = worldZ;
    pz = worldPz;
    zChanger = random(-1, 1);
    xChanger = random(-1, 1);
    yChanger = random(-1, 1);
    colorMode = whiteMode;
    colorChanger = 1;
    if (colorMode == true) {
      lColor = 150;
    } else {
      lColor = 300;
    }
    w = 5;
  }

  void drawMe() {
    strokeWeight(w);
    stroke(lColor, 100, 100, 60);
    line(x, y, z, px, py, pz);
  }

  void updateMe() {
    count ++;
    lColor += colorChanger;
    if (colorMode ==true) {
      if (lColor > 300) {
        colorChanger = colorChanger*(-1);
      } else if (lColor<100) {
        colorChanger = colorChanger*(-1);
      }
    } else {
      if (lColor > 360) {
        colorChanger = colorChanger*(-1);
      } else if (lColor<250) {
        colorChanger = colorChanger*(-1);
      }
    }

    z += zChanger*0.1;
    x += xChanger*0.1;
    y += yChanger*0.1;
    px += xChanger*0.1;
    py += yChanger*0.1;
    w -= count*0.00003;
    if (w<0) {
      w = 0;
    }
    drawMe();
  }
}

class Drop {
  float x; 
  float y;
  float z;
  float dColor;
  boolean colorMode = true;
  float w;
  float xChanger;
  float yChanger;
  float colorChanger;
  float count;
  float zChanger;

  Drop(float worldX, float worldZ, boolean whiteMode) {
    x = mouseX-width/2+worldX;
    y = mouseY-height/2;

    z = worldZ;

    xChanger = random(-1, 1);
    zChanger = random(-1, 1);
    yChanger = random(2, 6);
    colorMode = whiteMode;
    colorChanger = 1;
    if (colorMode == true) {
      dColor = 150;
    } else {
      dColor = 300;
    }
    w = 7;
  }

  void drawMe() {
    strokeWeight(w);
    stroke(dColor, 100, 100, 60);
    point(x, y, z);
  }

  void updateMe() {
    count ++;
    dColor += colorChanger;
    if (colorMode ==true) {
      if (dColor > 300) {
        colorChanger = colorChanger*(-1);
      } else if (dColor<100) {
        colorChanger = colorChanger*(-1);
      }
    } else {
      if (dColor > 360) {
        colorChanger = colorChanger*(-1);
      } else if (dColor<250) {
        colorChanger = colorChanger*(-1);
      }
    }

    z += zChanger*0.1;
    x += xChanger*0.1;
    y += yChanger*0.6;
    w -= count*0.001;
    if (w<0) {
      w = 0;
    }
    drawMe();
  }
}
