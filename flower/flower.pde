import processing.sound.*;


int num = 10;

Circle[] cArray = {};
Ripple[] rArray = {};
Drop[] dArray = {};
Line[] lArray = {};
Flower[] fArray ={};
Bezier[] bArray = {};


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

int imageCount;

SoundFile circSound;
SoundFile centSound;
SoundFile ripSound;
SoundFile dropSound;
SoundFile lineSound;
SoundFile flowerSound;
SoundFile bezierSound;
SoundFile touchSound;
//AudioIn input;
//Amplitude rms;
//Amplitude rms2;

void setup() {
  //size(800, 800, P3D);
  fullScreen(P3D);
  colorMode(HSB, 360, 100, 100, 100);
  background(0, 0, 0);

  circSound = new SoundFile(this, "water-drop1.wav");
  ripSound = new SoundFile(this, "water-drop3.wav");
  dropSound = new SoundFile(this, "bell1.mp3");
  lineSound = new SoundFile(this, "piano-single1.mp3");
  flowerSound = new SoundFile(this, "cursor1.mp3");
  bezierSound = new SoundFile(this, "teardrop1.mp3");
  //touchSound = new SoundFile(this, "water-drop2.wav");
  noCursor();
  
  imageCount = 0;
}

void draw() {
  noStroke();

  translate(width/2, height/2);
  rotateY(frameCount/240.0);
  //rad = frameCount/240.0;

  background(0, 0, 0);

  noFill();

  for (int i=0; i<cArray.length; i++) {
    Circle circle = cArray[i];
    circle.updateMe(circSound);
  }
  for (int i=0; i<rArray.length; i++) {
    Ripple ripple = rArray[i];
    ripple.updateMe();
  }
  for (int i=0; i<dArray.length; i++) {
    Drop drop = dArray[i];
    drop.updateMe();
  }
  for (int i=0; i<lArray.length; i++) {
    Line line = lArray[i];
    line.updateMe();
  }
  for (int i=0; i<fArray.length; i++) {
    Flower flower = fArray[i];
    flower.updateMe(flowerSound);
  }
  for (int i=0; i<bArray.length; i++) {
    Bezier bezier = bArray[i];
    bezier.updateMe();
  }
}

void keyPressed() {
  if (key == 'a') {
    drawCircle();
  }
  if(key == 'b'){
     drawRipple();
  }
  if(key == 'c'){
    drawDrop();
  }
  if(key == 'd'){
    drawBezier();
  }
  if(key == 'e'){
    drawFlower();
  }
  if(key == 'f'){
    drawLine();
  }
   if (key == 's') {
    save("Flower" + imageCount + ".png");
    imageCount++;
  }
}


void drawCircle() {
  for (int i=0; i<=num; i++) {
    Circle circle = new Circle(circSound);
    circle.drawMe();
    cArray = (Circle[])append(cArray, circle);
  }
}

void drawRipple() {
  for (int i=0; i<=num; i++) {
    Ripple ripple = new Ripple(ripSound);
    ripple.drawMe();
    rArray = (Ripple[])append(rArray, ripple);
  }
}

void drawDrop() {
  for (int i=0; i<=num; i++) {
    Drop drop = new Drop(dropSound);
    drop.drawMe();
    dArray = (Drop[])append(dArray, drop);
  }
}

void drawLine() {
  for (int i=0; i<=num; i++) {
    Line line = new Line(lineSound);
    line.drawMe();
    lArray = (Line[])append(lArray, line);
  }
}

void drawFlower() {
  for (int i=0; i<=num; i++) {
    Flower flower =new Flower(flowerSound);
    flower.drawMe();
    fArray=(Flower[])append(fArray, flower);
  }
}

void drawBezier() {
  for (int i=0; i<=num; i++) {
    Bezier bezier =new Bezier(bezierSound);
    bezier.drawMe();
    bArray=(Bezier[])append(bArray, bezier);
  }
}




class Circle {
  float x, y, z;
  float radius;
  float lColor;
  float xSpeed, ySpeed, zSpeed;
  float colorNoiser;
  float m;
  float saveX1;
  float rad1;
  int soundCount;
  int soundCount2;
  int soundMode;

  Circle(SoundFile sound) {
    //x=mouseX-width/2+worldX ;
    //y=mouseY-height/2;
    x=random(0, width)-width/2;
    y=random(0, height)-height/2;
    z=random(-800, 800);
    radius = (random(15) +10);
    lColor = random(250, 300);
    xSpeed = random(-15, 15);
    ySpeed = random(-15, 15);
    zSpeed = random(-15, 15);
    colorNoiser = noise(random(5));
    soundMode = int(random(5));
    if (soundMode==1) {
      sound.play();
      sound.amp(0.5);
      sound.rate(random(0.3, 0.7));
    }
  }

  void drawMe() {
    stroke(lColor, 50, 100);
    fill(lColor, 70, 100);
    strokeWeight(radius);
    point(x, y, z);
  }

  void updateMe(SoundFile sound) {
    x += xSpeed;
    y += ySpeed; 
    z += zSpeed;
    lColor += colorNoiser;
    m = (4*PI)/3*pow(radius, 3);


    if (lColor>240) {
      colorNoiser = colorNoiser*(-1);
    }
    if (lColor<310) {
      colorNoiser = colorNoiser*(-1);
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
    for (int i=0; i<cArray.length; i++) {
      Circle otherCircle = cArray[i];
      if (otherCircle != this) {
        float d = dist(x, y, z, otherCircle.x, otherCircle.y, otherCircle.z);
        if (d-(radius+otherCircle.radius)+5<0) {
          touching = true;
          radius-= 5;
          soundCount++;
          count+=1;
          if (soundCount%60==1) {
            float rate = map(radius, -10, 30, 0.0, 2.0); 
            sound.play();
            float pan = map(x, 0, width, -1, 1);
            sound.pan(pan);
            sound.rate(rate);
          }
          break;
        }
        if (d < 120) {
          strokeWeight(3);
          line(x, y, z, otherCircle.x, otherCircle.y, otherCircle.z);
        }
        if (touching == true) {
          //soundPlayer(sound,rate);
          xSpeed = ((m-otherCircle.m)*xSpeed+2.0*otherCircle.m*otherCircle.xSpeed)/(m+otherCircle.m);
          ySpeed = ((m-otherCircle.m)*ySpeed+2.0*otherCircle.m*otherCircle.ySpeed)/(m+otherCircle.m);
          zSpeed = ((m-otherCircle.m)*zSpeed+2.0*otherCircle.m*otherCircle.zSpeed)/(m+otherCircle.m);
        }
      }
    }

    boolean touching2 = false;
    for (int i=0; i<fArray.length; i++) {
      Flower otherFlower = fArray[i];
      float d = dist(x, y, z, otherFlower.x, otherFlower.y, otherFlower.z);
      if (d-(radius+otherFlower.radius)+5<0) {
        touching2 = true;
        radius-= 5;
        soundCount++;
        count+=1;
        if (soundCount%60==1) {
          float rate = map(radius, -10, 30, 0.0, 2.0); 
          sound.play();
          float pan = map(x, 0, width, -1, 1);
          sound.pan(pan);
          sound.rate(rate);
        }
        break;
      }
      if (touching2 == true) {
        xSpeed = ((m-otherFlower.m)*xSpeed+2.0*otherFlower.m*otherFlower.xSpeed)/(m+otherFlower.m);
        ySpeed = ((m-otherFlower.m)*ySpeed+2.0*otherFlower.m*otherFlower.ySpeed)/(m+otherFlower.m);
        zSpeed = ((m-otherFlower.m)*zSpeed+2.0*otherFlower.m*otherFlower.zSpeed)/(m+otherFlower.m);
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







class Ripple {
  float radius;
  float cent_x;
  float cent_y;
  float rColor;
  float radiusChanger;

  float colorNoiser;
  float ySpeed;
  float xSpeed;
  float w;
  float wCount;
  SoundFile sound;

  Ripple(SoundFile wsound) {
    radius = random(50)+10;
    cent_x = random(0, width)-width/2;
    cent_y = random(0, height)-height/2;


    rColor = random(200, 240);


    radiusChanger = noise(random(10));
    colorNoiser = noise(random(5));
    sound = wsound;
    sound.loop();
    ySpeed = random(10);
    xSpeed = random(-0.3, 0.3);
    w = 5;
    wCount = 0;
  }

  void drawMe() {
    pushMatrix();
    rotateY(-frameCount/240.0);

    noFill();
    strokeWeight(w);
    stroke(rColor, 40, 100);
    ellipse(cent_x, cent_y, radius, radius);
    popMatrix();
  }

  void updateMe() {
    wCount++;
    radius += radiusChanger;
    cent_x += xSpeed;
    cent_y += ySpeed;
    if (radius > 80) {
      radiusChanger = radiusChanger *(-1);
    }
    if (radius < 0) {
      radiusChanger = radiusChanger *(-1);
    }
    rColor += colorNoiser;

    if (rColor>250) {
      colorNoiser = colorNoiser*(-1);
    }
    if (rColor<200) {
      colorNoiser = colorNoiser*(-1);
    }

    if (cent_y> height+radius) {
      cent_y = -radius-height/2;
    }

    float rate = map(radius, 0, 60, 0.0, 2.0);
    float amp = map(radius, 0, 60, 0.0, 1.0);
    float amp2 = map(w, 0, 2, 0.0, 1.0);
    float pan = map(x, 0, width, -1, 1);
    sound.amp(amp*amp2);
    sound.pan(pan);
    sound.rate(rate);

    w -= 0.00001f*wCount;
    if (w<0) {
      w=0;
    }

    drawMe();
  }
}





class Drop {
  float x; 
  float y;
  float z;
  float dColor;
  float w;
  float xChanger;
  float yChanger;
  float colorChanger;
  float count;
  float zChanger;
  float rate;
  float amp;
  float soundMode;
  SoundFile sound;

  Drop(SoundFile dropSound) {
    //x = mouseX-width/2+worldX;
    //y = mouseY-height/2;
    x=random(0, width)-width/2;
    y=random(0, height)-height/2;

    z = random(-800, 800);

    xChanger = random(-1, 1);
    zChanger = random(-1, 1);
    yChanger = random(2, 6);
    colorChanger = 1;
    soundMode = int(random(5));

    dColor = random(70, 90);

    w = 15;
    sound = dropSound;
    if (soundMode == 1) {
      sound.play();
      amp = map(dColor, 60, 110, 0.0, 1.6);
      sound.rate(rate);
    }
  }

  void drawMe() {
    strokeWeight(w);
    stroke(dColor, 30, 100);
    noFill();
    point(x, y, z);
  }

  void updateMe() {
    count ++;
    dColor += colorChanger;

    if (soundMode ==1) {
      amp = map(w, 0, 15, 0.0, 0.7);
      sound.amp(amp);
    }
    if (dColor > 120) {
      colorChanger = colorChanger*(-1);
    } else if (dColor<60) {
      colorChanger = colorChanger*(-1);
    }

    z += zChanger*0.1;
    x += xChanger*0.1;
    y += yChanger*0.6;
    w -= count*0.001;
    if (w<0) {
      w = 0;
    }
    if (soundMode == 1) {
      float pan = map(x, 0, width, -1, 1);
      sound.pan(pan);
      sound.amp(0.6);
    }
    drawMe();
  }
}

class Line {
  float x; 
  float y;
  float z;
  float lColor;
  float w;
  float xChanger;
  float yChanger;
  float colorChanger;
  float count;
  float zChanger;
  float rate;
  float amp;
  float soundMode;
  SoundFile sound;

  Line(SoundFile lineSound) {
    //x = mouseX-width/2+worldX;
    //y = mouseY-height/2;
    x=random(0, width)-width/2;
    y=random(-250, height)-height/2;

    z = random(-800, 800);

    xChanger = random(-1, 1);
    zChanger = random(-1, 1);
    yChanger = random(2, 6);
    colorChanger = 1;
    soundMode = int(random(8));

    lColor = random(20, 70);

    w = 4;
    sound = lineSound;
    if (soundMode == 1) {
      sound.play();
      rate = map(lColor, 10, 80, 0.6, 1.4);
      sound.rate(rate);
    }
  }

  void drawMe() {
    strokeWeight(w);
    stroke(lColor, 20, 100);
    line(x, y, z, x, y+250, z);
  }

  void updateMe() {
    count ++;
    lColor += colorChanger;

    if (soundMode ==1) {
      amp = map(w, 0, 5, 0.0, 0.1);
      sound.amp(amp);
    }

    if (lColor > 80) {
      colorChanger = colorChanger*(-1);
    } else if (lColor<10) {
      colorChanger = colorChanger*(-1);
    }

    z += zChanger*0.1;
    x += xChanger*0.1;
    y += yChanger*0.6;
    w -= count*0.0002;
    if (w<0) {
      w = 0;
    }
    if (soundMode == 1) {
      float pan = map(x, 0, width, -1, 1);
      float amp = map(w, 0, 5, 0, 1);
      sound.pan(pan);
      sound.amp(0.7*amp);
    }
    drawMe();
  }
}




class Flower {
  float x, y, z;
  float x2, y2, z2;
  float radius;
  float fColor;

  float xSpeed, ySpeed, zSpeed;
  float colorNoiser;
  float m;
  float rad1;
  float rad2;
  int soundCount;
  int soundCount2;
  float step;
  float step2;
  int soundMode;
  float amp;
  SoundFile fSound;

  Flower(SoundFile sound) {
    x=random(0, width)-width/2;
    y=random(0, height)-height/2;
    z=random(-800, 800);
    step=random(6, 8);
    step2=random(6, 8);
    radius = random(55) +35;
    fColor = random(0, 360);
    soundMode = int(random(5));


    xSpeed = random(-7, 7);
    ySpeed = random(-7, 7);
    zSpeed = random(-7, 7);
    colorNoiser = noise(random(5));
    if (soundMode==1) {
      amp= 0.5;
      fSound =sound;
      fSound.play();
      fSound.rate(random(0.3, 0.7));
    }
  }

  void drawMe() {
    stroke(fColor, 10, 100);
    noFill();
    strokeWeight(3);

    for (int i=0; i<360; i+=step*12) {
      for (int j=0; j<360; j+=step2*12) {
        rad1 = i;
        rad2 = j;
        x2 = radius*cos(rad1)*cos(rad2)+x;
        y2 = radius*cos(rad1)*sin(rad2)+y;
        z2 = radius*sin(rad1)+z;
        line(x, y, z, x2, y2, z2);
      }
    }
    point(x, y, z);
  }

  void updateMe(SoundFile sound) {
    x += xSpeed;
    y += ySpeed; 
    z += zSpeed;
    fColor += colorNoiser;
    m = (4*PI)/3*pow(radius, 3);

    if (soundMode == 1) {
      amp-=0.0001;
      if (amp<0) {
        amp=0;
      }
      fSound.amp(amp);
    }

    if (fColor>0) {
      colorNoiser = colorNoiser*(-1);
    }
    if (fColor<360) {
      colorNoiser = colorNoiser*(-1);
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
    for (int i=0; i<fArray.length; i++) {
      Flower otherFlower = fArray[i];
      if (otherFlower != this) {
        float d = dist(x, y, z, otherFlower.x, otherFlower.y, otherFlower.z);
        if (d-(radius+otherFlower.radius)+5<0) {
          touching = true;
          radius-= 5;
          soundCount++;
          count+=1;
          if (soundCount%60==1) {
            float rate = map(radius, -10, 100, 0.0, 2.0); 
            sound.play();
            float pan = map(x, 0, width, -1, 1);
            sound.pan(pan);
            sound.rate(rate);
          }
          break;
        }
        if (touching == true) {
          xSpeed = ((m-otherFlower.m)*xSpeed+2.0*otherFlower.m*otherFlower.xSpeed)/(m+otherFlower.m);
          ySpeed = ((m-otherFlower.m)*ySpeed+2.0*otherFlower.m*otherFlower.ySpeed)/(m+otherFlower.m);
          zSpeed = ((m-otherFlower.m)*zSpeed+2.0*otherFlower.m*otherFlower.zSpeed)/(m+otherFlower.m);
        }
      }
    }

    boolean touching2 = false;
    for (int i=0; i<cArray.length; i++) {
      Circle otherCircle = cArray[i];
      float d = dist(x, y, z, otherCircle.x, otherCircle.y, otherCircle.z);
      if (d-(radius+otherCircle.radius)+5<0) {
        touching2 = true;
        radius-= 5;
        soundCount++;
        count += 1;
        if (soundCount%60==1) {
          float rate = map(radius, -10, 100, 0.0, 2.0); 
          sound.play();
          float pan = map(x, 0, width, -1, 1);
          sound.pan(pan);
          sound.rate(rate);
        }
        break;
      }
      if (touching2 == true) {
        //soundPlayer(sound,rate);
        xSpeed = ((m-otherCircle.m)*xSpeed+2.0*otherCircle.m*otherCircle.xSpeed)/(m+otherCircle.m);
        ySpeed = ((m-otherCircle.m)*ySpeed+2.0*otherCircle.m*otherCircle.ySpeed)/(m+otherCircle.m);
        zSpeed = ((m-otherCircle.m)*zSpeed+2.0*otherCircle.m*otherCircle.zSpeed)/(m+otherCircle.m);
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


class Bezier {
  float x; 
  float y;
  float z;
  float bColor;
  float w;
  float xChanger;
  float yChanger;
  float colorChanger;
  float count;
  float zChanger;
  float rate;
  float amp;
  float sChanger;
  float s;
  float soundMode;
  boolean wMode;
  SoundFile sound;

  Bezier(SoundFile bezierSound) {
    x=random(0, width)-width/2;
    y=random(0, height)-height/2;

    z = random(-1000, 1000);

    xChanger = random(-19, 19);
    zChanger = random(-19, 19);
    yChanger = random(-19, 19);
    colorChanger = 1;
    sChanger = 1;
    s=0;
    soundMode = int(random(5));
    bColor = random(0, 360);
    wMode = true;
    w = 0;
    sound = bezierSound;
    if (soundMode == 1) {
      sound.play();
    }
  }

  void drawMe() {
    strokeWeight(w);
    stroke(bColor, s, 100, 80);
    noFill();
    bezier(0, 0, 0, z, x, y, y, z, x, x, y, z);
  }

  void updateMe() {
    count ++;
    bColor += colorChanger;
    s+=sChanger*0.02;

    if (soundMode ==1) {
      rate = map(bColor, 0, 360, 0.0, 2.0);
      sound.rate(rate);
      amp = map(w, 0, 6.0, 0.0, 1.0);
      sound.amp(amp);
    }
    if (bColor > 360) {
      colorChanger = colorChanger*(-1);
    } else if (bColor<0) {
      colorChanger = colorChanger*(-1);
    }

    z += zChanger;
    x += xChanger;
    y += yChanger;

    if (wMode == true) {
      w += count*0.00005f;
    }
    if (w>=6) {
      wMode =false;
    }
    if (wMode == false) {
      w -= count*0.00005f;
    }
    if (w<0) {
      w = 0;
    }
    if (soundMode == 1) {
      float pan = map(x, 0, width, -1, 1);
      sound.pan(pan);
      sound.amp(0.6);
    }
    drawMe();
  }
}
