int num = 5;
Circle[] cArray = {};

float yRotation = random(6);
float xRotation = random(6);
float h = random(150, 250);
float hPlus = 0.5;
int count;

void setup() {
  size(800, 800, P3D);
  colorMode(HSB, 360, 100, 100, 100);
  background(0, 0, 100);
  drawCircle();
  count = 0;
}

void draw() {
  noStroke();

  translate(width/2, height/2);
  camera(mouseX, mouseY, 1100, 0, 0, 0, 0, 1, 0);

  rotateY(frameCount /120.0+noise(yRotation)*0.5);
  rotateX(frameCount/180.0+noise(xRotation)*0.5);
  yRotation += 0.01;
  xRotation += 0.01;

  background(0, 0, 100);
  for (int i=0; i<cArray.length; i++) {
    Circle circle = cArray[i];
    circle.updateMe();
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
  box(800, 800, 800);
}

void mousePressed() {
  drawCircle();
}

void keyPressed(){
  if (key == 's') {
    save("Collision" + count + ".png");
    count++;
  }
}

void drawCircle() {
  for (int i=0; i<=num; i++) {
    Circle circle = new Circle();
    circle.drawMe();
    cArray = (Circle[])append(cArray, circle);
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

  Circle() {
    x = random(-400, 400);
    y = random(-400, 400);
    //x=mouseX-width/2;
    //y=mouseY-height/2;
    z=random(-400, 400);
    radius = random(20) +10;
    lColor = random(150, 250);
    alph = random(30,100);
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

    if (lColor>300) {
      colorNoiser = colorNoiser*(-1);
    }
    if (lColor<60) {
      colorNoiser = colorNoiser*(-1);
    }

    if (x>400-radius) {
      xSpeed = xSpeed*(-1);
    }
    if (x<-400+radius) {
      xSpeed = xSpeed*(-1);
    }
    if (y>400-radius) {
      ySpeed = ySpeed*(-1);
    }
    if (y<-400+radius) {
      ySpeed = ySpeed*(-1);
    }
    if (z>400-radius) {
      zSpeed = zSpeed*(-1);
    }
    if (z<-400+radius) {
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
          //radius--;
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
