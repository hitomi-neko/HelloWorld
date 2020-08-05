class Star {
  float x, y, z;
  float x1, y1, z1;
  float x2, y2, z2;
  float radius;
  float sColor;

  float xSpeed, ySpeed, zSpeed;
  float colorNoiser;
  float m;
  float rad1;
  float step;
  int n;

  boolean sMode = true;

  Star(boolean mode) {
    x = random(-width/2, width/2);
    y = random(-height/2, height/2);
    z = random(-800, 800);
    step = random(6, 8);
    radius = random(55) + 35;
    sMode = mode;
    if (sMode == true) {
      sColor = random(280, 340);
    } else {
      sColor = random(200, 260);
    }

    n = int(random(5,9));
    xSpeed = random(-7, 7);
    ySpeed = random(-7, 7);
    zSpeed = random(-7, 7);
    colorNoiser = noise(random(5));
  }

  void drawMe() {
    stroke(sColor, 20, 100,80);
    noFill();
    strokeWeight(3);

    for (int i=0; i<360; i+=step) {
      rad1 = i;
      x1 = x + radius*cos(rad1-step)*sin(n*(rad1-step));
      y1 = y + radius*sin(rad1-step)*sin(n*(rad1-step));
      z1 = z + radius*cos(rad1-step)*sin(n*(rad1-step));
      x2 = x + radius*cos(rad1)*sin(n*(rad1));
      y2 = y + radius*sin(rad1)*sin(n*(rad1));
      z2 = z + radius*cos(rad1)*sin(n*(rad1));
      line(x1, y1, z, x2, y2, z);
      line(x, y1, z1, x, y2, z2);
    }
  }

  void updateMe(boolean mode) {
    sMode = mode;
    x += xSpeed;
    y += ySpeed; 
    z += zSpeed;
    sColor += colorNoiser;
    m = (4*PI)/3*pow(radius, 3);
    if (sMode == true) {
      if (sColor>280) {
        colorNoiser = colorNoiser*(-1);
      }
      if (sColor<360) {
        colorNoiser = colorNoiser*(-1);
      }
    } else if (sMode == false) {
      if (sColor>190) {
        colorNoiser = colorNoiser*(-1);
      }
      if (sColor<270) {
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
    int count =0;
    for (int i=0; i<sArray.length; i++) {
      Star otherStar = sArray[i];
      if (otherStar != this) {
        float d = dist(x, y, z, otherStar.x, otherStar.y, otherStar.z);
        if (d-(radius+otherStar.radius)+5<0) {
          touching = true;
          radius-= 5;
          count+=1;
          break;
        }
        if (touching == true) {
          xSpeed = ((m-otherStar.m)*xSpeed+2.0*otherStar.m*otherStar.xSpeed)/(m+otherStar.m);
          ySpeed = ((m-otherStar.m)*ySpeed+2.0*otherStar.m*otherStar.ySpeed)/(m+otherStar.m);
          zSpeed = ((m-otherStar.m)*zSpeed+2.0*otherStar.m*otherStar.zSpeed)/(m+otherStar.m);
        }
      }
    }


    if (count>=3) {
      radius=0;
    }
    if (radius < 5) {
      radius=0;
    }

    drawMe();
  }
}
