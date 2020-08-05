float x, y, x1, y1;
float a;
float b;
float h;
float hNoiser;
float theta = 0;
float ramda = 90;
int count = 0;
boolean mode = true;

void setup() {
  size(800, 800);
  a = 1;
  b = 2;
  colorMode(HSB, 360, 100, 100);
  background(0, 0, 100);
  x = 0;
  y = 0;
  if (mode == true) {
    h = 200;
    background(0, 0, 100);
  } else if (mode == false) {
    h = 300;
    background(0, 0, 0);
  }
  hNoiser = random(1, 4);
}

void draw() {
  if (mode == true) {
    if (h>270) {
      hNoiser *= (-1);
    } else if (h<190) {
      hNoiser *= (-1);
    }
    h += hNoiser;
  } else if (mode == false) {
    if (h>355) {
      hNoiser *= (-1);
    } else if (h<290) {
      hNoiser *= (-1);
    }
    h += hNoiser;
  }
  noFill();
  theta += 0.4;
  ramda += 0.5;
  stroke(h, 100, 100, 60);
  translate(width/2, height/2);
  x = 350*sin(a*(theta-0.4) + ramda-0.5);
  y = 350*sin(b*(theta-0.4));
  x1 = 350*sin(a*theta + ramda);
  y1 = 350*sin(b*theta);
  line(x, y, x1, y1);
}

void keyPressed() {
  if (key == 's') {
    save("If" +count+ ".png");
    count++;
  }
  if(key == 'm'){
    if(mode == true){
      mode = false;
    }else if(mode == false){
      mode = true;
    }
  }
}
