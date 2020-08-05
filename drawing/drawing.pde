float x1,y1,x2,y2,z1,z2;
float eyeX,eyeY;
float w = 1;
float h;
float a = 20;
float theta = 0;
int count = 0;

void setup(){
  fullScreen(P3D);
  colorMode(HSB,360,100,100);
  background(0,0,100);
}

void draw(){
  translate(width/2,height/2);
  eyeX = map(mouseX,0,width,width/2,-width/2);
  eyeY = map(mouseY,0,height,height/2,-height/2);
  camera(eyeX, eyeY, 2100, 0, 0, 0, 0, 1, 0);
  rotateX(radians(-1));
  theta += 0.4;
  x1 = a*(cos(theta-0.4));
  y1 = a*(sin(theta-0.4));
  x2 = a*(cos(theta));
  y2 = a*(sin(theta));
  z1 = a*(theta-0.4)/20;
  h = 260+30*cos(theta);
  z2 = a*theta/20;
  
  fill(0,0,0);
  noStroke();
  point(z2,y2,z2);
  stroke(h,100,100,80);
  line(x1,y1,z1,x2,y2,z2);
}

void keyPressed() {
  if (key == 's') {
    save("Drawig" +count+ ".png");
    count++;
  }
}
