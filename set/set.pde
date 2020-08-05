float x,y,z;
int count;

void setup(){
  fullScreen(P3D);
  noFill();
  background(255);
  stroke(0,70);
  count = 0;
  translate(width/2,height/2);
  for(int i=0; i< 100; i++){
    x=random(-width/2, width/2);
    y=random(-height/2, height/2);
    z = random(-1000, 1000);
    bezier(0, 0, 0, z, x, y, y, z, x, x, y, z);
  }
}

void draw(){
}

void keyPressed(){
  if (key == 's') {
    save("Setup" + count + ".png");
    count++;
  }
}
