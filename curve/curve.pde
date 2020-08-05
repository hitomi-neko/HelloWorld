float x1,y1,x2,y2;
float w = 1;
float a = 1;
float theta = 0;
int count = 0;

void setup(){
  fullScreen();
  colorMode(HSB,360,100,100);
  background(0,0,100);
}

void draw(){
  translate(width/2,height/2);
  theta += 0.4;
  x1 = a*(cos(theta-0.4) + theta*sin(theta-0.4));
  y1 = a*(sin(theta-0.4) - theta*cos(theta-0.4));
  x2 = a*(cos(theta) + theta*sin(theta));
  y2 = a*(sin(theta) - theta*cos(theta));
  
  fill(0,0,0);
  noStroke();
  ellipse(x2,y2,w,w);
  stroke(0,0,0,80);
  line(x1,y1,x2,y2);
}

void keyPressed() {
  if (key == 's') {
    save("Curve" +count+ ".png");
    count++;
  }
}
