import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
//参考文献　[普及版]ジェネラティブアートprocessing実践ガイド

import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

FractalRoot pentagon;

float _strutFactor = 0.2;
float _strutNoise;
int _maxlevels = 3;
int _numSides = 6;
int h = hour();
float m = minute();
float s = second();
float _rnoise = random(15);
float H,H1,S;
int count = 0;
//float sc = 1.0;

Minim minim;
AudioOutput out;

void setup(){
  size(1000,1000,P3D);
  colorMode(HSB, 360, 120, 100, 100);
  smooth();
  _strutNoise = random(10);
  rectMode(CENTER);
 
   pixelDensity(displayDensity());
   strokeCap(SQUARE); 
   
   minim = new Minim(this);
   out = minim.getLineOut();
   out.setTempo(100.0f);
   out.setDurationFactor( 0.95f );
   out.pauseNotes();
}

void draw(){
 int h = hour();
 float m = minute();
 float s = second();
  //background(255);
  background(0, 0, 100);
  float vol = 0.45;
  float H1 = H+120;
  if(H1 <= 0){
    H1 = H1+360;
  }  
  if(h<=12){
    H = h*30+m*(1/2)+s*(1/180);
    //S = h*10+m*(1/6)+s*(1/360);
           S = 120;
   }
   if(h>12){
     H = 360-((h-12)*30+m*(1/2)+s*(1/360));
     //S = 120-((h-12)*10+m*(1/6)+s*(1/360));
          S = 120;
   }
   
  _strutNoise += 0.005;
  if(m<=15){
  _strutFactor = ((noise(_strutNoise)*2)-1);
  }
  if(m>15 && m<=30){
  _strutFactor = ((noise(_strutNoise)*3)-1);
  }
  if(m>30 && m<=45){
  _strutFactor = ((noise(_strutNoise)*3)-2);
  }
  if(m>45 && m<=60){
  _strutFactor = ((noise(_strutNoise)*4)-2);
  }
  pentagon = new FractalRoot(frameCount/60);
  pentagon.drawShape();


  for( int i = 0; i < out.bufferSize() - 1; i++ ){
     stroke(H1, S, 100, 2);
     noFill();
     ellipse(width/2, height/2, (out.left.get(i)*50)*60, (out.left.get(i)*50)*60);
  }

   Waveform disWave = Waves.sawh( 1 );
   
   if(h == 0 && m <= 15 && s % 3 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "C3", vol/2, disWave, out ) );
   }
   if(h == 0 && m > 15 && m <=30 && s % 3 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "C3", vol/2, disWave, out ) );
   out.playNote( 0.06, 0.03, new tempo( "E3", vol/2, disWave, out ) );
   }
   if(h == 0 && m > 30 && m <= 45 && s % 2 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "C3", vol/2, disWave, out ) );
   out.playNote( 0.06, 0.03, new tempo( "E3", vol/2, disWave, out ) );
   }
   if(h == 0 && m > 45 && m <= 59 && s % 2 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "C3", vol/2, disWave, out ) );
   out.playNote( 0.06, 0.03, new tempo( "E3", vol/2, disWave, out ) );
   out.playNote( 0.12, 0.03, new tempo( "G3", vol/2, disWave, out ) );
   }
   if(h == 0 && m % 5 == 0 && s % 59 == 1){
   out.playNote( 0.0, 0.03, new tempo( "C4", vol/2, disWave, out ) );
   }
   
   if((h == 1 || h == 23) && m <= 15 && s % 3 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "D3", vol/2, disWave, out ) );
   }
   if((h == 1 || h == 23) && m > 15 && m <=30 && s % 3 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "D3", vol/2, disWave, out ) );
   out.playNote( 0.06, 0.03, new tempo( "F#3", vol/2, disWave, out ) );
   }
   if((h == 1 || h == 23) && m > 30 && m <= 45 && s % 2 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "D3", vol/2, disWave, out ) );
   out.playNote( 0.06, 0.03, new tempo( "F#3", vol/2, disWave, out ) );
   }
   if((h == 1 || h == 23) && m > 45 && m <= 59 && s % 2 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "D3", vol/2, disWave, out ) );
   out.playNote( 0.06, 0.03, new tempo( "F#3", vol/2, disWave, out ) );
   out.playNote( 0.12, 0.03, new tempo( "A3", vol/2, disWave, out ) );
   }
   if((h == 1 || h == 23) && m % 5 == 0 && s % 59 == 1){
   out.playNote( 0.0, 0.03, new tempo( "D4", vol/2, disWave, out ) );
   }
   
   if((h == 2 || h == 22) && m <= 15 && s % 3 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "E3", vol/2, disWave, out ) );
   }
   if((h == 2 || h == 22) && m > 15 && m <=30 && s % 3 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "E3", vol/2, disWave, out ) );
   out.playNote( 0.06, 0.03, new tempo( "G#3", vol/2, disWave, out ) );
   }
   if((h == 2 || h == 22) && m > 30 && m <= 45 && s % 2 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "E3", vol/2, disWave, out ) );
   out.playNote( 0.06, 0.03, new tempo( "G#3", vol/2, disWave, out ) );
   }
   if((h == 2 || h == 22) && m > 45 && m <= 59 && s % 2 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "E3", vol/2, disWave, out ) );
   out.playNote( 0.06, 0.03, new tempo( "G#3", vol/2, disWave, out ) );
   out.playNote( 0.12, 0.03, new tempo( "B3", vol/2, disWave, out ) );
   }
   if((h == 2 || h == 22) && m % 5 == 0 && s % 59 == 1){
   out.playNote( 0.0, 0.03, new tempo( "E4", vol/2, disWave, out ) );
   }
   
   if((h == 3 || h == 21) && m <= 15 && s % 3 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "F3", vol/2, disWave, out ) );
   }
   if((h == 3 || h == 21) && m > 15 && m <=30 && s % 3 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "F3", vol/2, disWave, out ) );
   out.playNote( 0.06, 0.03, new tempo( "A3", vol/2, disWave, out ) );
   }
   if((h == 3 || h == 21) && m > 30 && m <= 45 && s % 2 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "F3", vol/2, disWave, out ) );
   out.playNote( 0.06, 0.03, new tempo( "A3", vol/2, disWave, out ) );
   }
   if((h == 3 || h == 21) && m > 45 && m <= 59 && s % 2 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "F3", vol/2, disWave, out ) );
   out.playNote( 0.06, 0.03, new tempo( "A3", vol/2, disWave, out ) );
   out.playNote( 0.12, 0.03, new tempo( "C4", vol/2, disWave, out ) );
   }
   if((h == 3 || h == 21) && m % 5 == 0 && s % 59 == 1){
   out.playNote( 0.0, 0.03, new tempo( "F4", vol/2, disWave, out ) );
   }
   
   if((h == 4 || h == 20) && m <= 15 && s % 3 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "G3", vol/2, disWave, out ) );
   }
   if((h == 4 || h == 20) && m > 15 && m <=30 && s % 3 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "G3", vol/2, disWave, out ) );
   out.playNote( 0.06, 0.03, new tempo( "B3", vol/2, disWave, out ) );
   }
   if((h == 4 || h == 20) && m > 30 && m <= 45 && s % 2 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "G3", vol/2, disWave, out ) );
   out.playNote( 0.06, 0.03, new tempo( "B3", vol/2, disWave, out ) );
   }
   if((h == 4 || h == 20) && m > 45 && m <= 59 && s % 2 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "G3", vol/2, disWave, out ) );
   out.playNote( 0.06, 0.03, new tempo( "B3", vol/2, disWave, out ) );
   out.playNote( 0.12, 0.03, new tempo( "D4", vol/2, disWave, out ) );
   }
   if((h == 4 || h == 20) && m % 5 == 0 && s % 59 == 1){
   out.playNote( 0.0, 0.03, new tempo( "G4", vol/2, disWave, out ) );
   }

   if((h == 5 || h == 19) && m <= 15 && s % 3 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "A3", vol/2, disWave, out ) );
   }
   if((h == 5 || h == 19) && m > 15 && m <=30 && s % 3 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "A3", vol/2, disWave, out ) );
   out.playNote( 0.06, 0.03, new tempo( "C#4", vol/2, disWave, out ) );
   }
   if((h == 5 || h == 19) && m > 30 && m <= 45 && s % 2 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "A3", vol/2, disWave, out ) );
   out.playNote( 0.06, 0.03, new tempo( "C#4", vol/2, disWave, out ) );
   }
   if((h == 5 || h == 19) && m > 45 && m <= 59 && s % 2 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "A3", vol/2, disWave, out ) );
   out.playNote( 0.06, 0.03, new tempo( "C#4", vol/2, disWave, out ) );
   out.playNote( 0.12, 0.03, new tempo( "E4", vol/2, disWave, out ) );
   }
   if((h == 5 || h == 19) && m % 5 == 0 && s % 59 == 1){
   out.playNote( 0.0, 0.03, new tempo( "A4", vol/2, disWave, out ) );
   }
   
   if((h == 6 || h == 18) && m <= 15 && s % 3 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "B3", vol/2, disWave, out ) );
   }
   if((h == 6 || h == 18) && m > 15 && m <=30 && s % 3 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "B3", vol/2, disWave, out ) );
   out.playNote( 0.06, 0.03, new tempo( "D#4", vol/2, disWave, out ) );
   }
   if((h == 6 || h == 18) && m > 30 && m <= 45 && s % 2 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "B3", vol/2, disWave, out ) );
   out.playNote( 0.06, 0.03, new tempo( "D#4", vol/2, disWave, out ) );
   }
   if((h == 6 || h == 18) && m > 45 && m <= 59 && s % 2 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "B3", vol/2, disWave, out ) );
   out.playNote( 0.06, 0.03, new tempo( "D#4", vol/2, disWave, out ) );
   out.playNote( 0.12, 0.03, new tempo( "F#4", vol/2, disWave, out ) );
   }
   if((h == 6 || h == 18) && m % 5 == 0 && s % 59 == 1){
   out.playNote( 0.0, 0.03, new tempo( "B4", vol/2, disWave, out ) );
   }
   
   if((h == 7 || h == 17) && m <= 15 && s % 3 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "C4", vol/2, disWave, out ) );
   }
   if((h == 7 || h == 17) && m > 15 && m <=30 && s % 3 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "C4", vol/2, disWave, out ) );
   out.playNote( 0.06, 0.03, new tempo( "E4", vol/2, disWave, out ) );
   }
   if((h == 7 || h == 17) && m > 30 && m <= 45 && s % 2 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "C4", vol/2, disWave, out ) );
   out.playNote( 0.06, 0.03, new tempo( "E4", vol/2, disWave, out ) );
   }
   if((h == 7 || h == 17) && m > 45 && m <= 59 && s % 2 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "C4", vol/2, disWave, out ) );
   out.playNote( 0.06, 0.03, new tempo( "E4", vol/2, disWave, out ) );
   out.playNote( 0.12, 0.03, new tempo( "G4", vol/2, disWave, out ) );
   }
   if((h == 7 || h == 17) && m % 5 == 0 && s % 59 == 1){
   out.playNote( 0.0, 0.03, new tempo( "C5", vol/2, disWave, out ) );
   }
   
   if((h == 8 || h == 16) && m <= 15 && s % 3 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "D4", vol/2, disWave, out ) );
   }
   if((h == 8 || h == 16) && m > 15 && m <=30 && s % 3 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "D4", vol/2, disWave, out ) );
   out.playNote( 0.06, 0.03, new tempo( "F#4", vol/2, disWave, out ) );
   }
   if((h == 8 || h == 16) && m > 30 && m <= 45 && s % 2 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "D4", vol/2, disWave, out ) );
   out.playNote( 0.06, 0.03, new tempo( "F#4", vol/2, disWave, out ) );
   }
   if((h == 8 || h == 16) && m > 45 && m <= 59 && s % 2 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "D4", vol/2, disWave, out ) );
   out.playNote( 0.06, 0.03, new tempo( "F#4", vol/2, disWave, out ) );
   out.playNote( 0.12, 0.03, new tempo( "A4", vol/2, disWave, out ) );
   }
   if((h == 8 || h == 16) && m % 5 == 0 && s % 59 == 1){
   out.playNote( 0.0, 0.03, new tempo( "D5", vol/2, disWave, out ) );
   }

   if((h == 9 || h == 15) && m <= 15 && s % 3 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "E4", vol/2, disWave, out ) );
   }
   if((h == 9 || h == 15) && m > 15 && m <=30 && s % 3 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "E4", vol/2, disWave, out ) );
   out.playNote( 0.06, 0.03, new tempo( "G#4", vol/2, disWave, out ) );
   }
   if((h == 9 || h == 15) && m > 30 && m <= 45 && s % 2 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "E4", vol/2, disWave, out ) );
   out.playNote( 0.06, 0.03, new tempo( "G#4", vol/2, disWave, out ) );
   }
   if((h == 9 || h == 15) && m > 45 && m <= 59 && s % 2 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "E4", vol/2, disWave, out ) );
   out.playNote( 0.06, 0.03, new tempo( "G#4", vol/2, disWave, out ) );
   out.playNote( 0.12, 0.03, new tempo( "B4", vol/2, disWave, out ) );
   }
   if((h == 9 || h == 15) && m % 5 == 0 && s % 59 == 1){
   out.playNote( 0.0, 0.03, new tempo( "E5", vol/2, disWave, out ) );
   }
   
   if((h == 10 || h == 14) && m <= 15 && s % 3 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "F4", vol/2, disWave, out ) );
   }
   if((h == 10 || h == 14) && m > 15 && m <=30 && s % 3 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "F4", vol/2, disWave, out ) );
   out.playNote( 0.06, 0.03, new tempo( "A4", vol/2, disWave, out ) );
   }
   if((h == 10 || h == 14) && m > 30 && m <= 45 && s % 2 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "F4", vol/2, disWave, out ) );
   out.playNote( 0.06, 0.03, new tempo( "A4", vol/2, disWave, out ) );
   }
   if((h == 10 || h == 14) && m > 45 && m <= 59 && s % 2 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "F4", vol/2, disWave, out ) );
   out.playNote( 0.06, 0.03, new tempo( "A4", vol/2, disWave, out ) );
   out.playNote( 0.12, 0.03, new tempo( "C5", vol/2, disWave, out ) );
   }
   if((h == 10 || h == 14) && m % 5 == 0 && s % 59 == 1){
   out.playNote( 0.0, 0.03, new tempo( "F5", vol/2, disWave, out ) );
   }

   if((h == 11 || h == 13) && m <= 15 && s % 3 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "G4", vol/2, disWave, out ) );
   }
   if((h == 11 || h == 13) && m > 15 && m <=30 && s % 3 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "G4", vol/2, disWave, out ) );
   out.playNote( 0.06, 0.03, new tempo( "B4", vol/2, disWave, out ) );
   }
   if((h == 11 || h == 13) && m > 30 && m <= 45 && s % 2 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "G4", vol/2, disWave, out ) );
   out.playNote( 0.06, 0.03, new tempo( "B4", vol/2, disWave, out ) );
   }
   if((h == 11 || h == 13) && m > 45 && m <= 59 && s % 2 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "G4", vol/2, disWave, out ) );
   out.playNote( 0.06, 0.03, new tempo( "B4", vol/2, disWave, out ) );
   out.playNote( 0.12, 0.03, new tempo( "D5", vol/2, disWave, out ) );
   }
   if((h == 11 || h == 13) && m % 5 == 0 && s % 59 == 1){
   out.playNote( 0.0, 0.03, new tempo( "G5", vol/2, disWave, out ) );
   }
   
   if(h == 12 && m <= 15 && s % 3 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "A4", vol/2, disWave, out ) );
   }
   if(h == 12 && m > 15 && m <=30 && s % 3 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "A4", vol/2, disWave, out ) );
   out.playNote( 0.06, 0.03, new tempo( "C#5", vol/2, disWave, out ) );
   }
   if(h == 12 && m > 30 && m <= 45 && s % 2 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "A4", vol/2, disWave, out ) );
   out.playNote( 0.06, 0.03, new tempo( "C#5", vol/2, disWave, out ) );
   }
   if(h == 12 && m > 45 && m <= 59 && s % 2 == 0  ){
   out.playNote( 0.0, 0.03, new tempo( "A4", vol/2, disWave, out ) );
   out.playNote( 0.06, 0.03, new tempo( "C#5", vol/2, disWave, out ) );
   out.playNote( 0.12, 0.03, new tempo( "E5", vol/2, disWave, out ) );
   }
   if(h == 12 && m % 5 == 0 && s % 59 == 1){
   out.playNote( 0.0, 0.03, new tempo( "A5", vol/2, disWave, out ) );
   }
   
   out.resumeNotes(); 
   
   
}


class PointObj{
  float x,y;
  PointObj(float ex,float why){
    x = ex;
    y = why;
  }
}
  
  

class FractalRoot{
  PointObj[] pointArr = {};
  Branch rootBranch;
  
  FractalRoot(float startAngle){
    float centX = width/2;
    float centY = height/2;
    float angleStep = 360.0f/_numSides;
    for(int i=0; i<360; i+= angleStep){
      float x = centX + (400*cos(radians(startAngle+i)));
      float y = centY + (400*sin(radians(startAngle+i)));
      pointArr = (PointObj[])append(pointArr,new PointObj(x,y));
    }
    rootBranch = new Branch(0,0,pointArr);
  }
  
  void drawShape(){
    rootBranch.drawMe();
  }
}



class Branch{
  int level,num;
  PointObj[] outerPoints = {};
  
  PointObj[] calcMidPoints(){
    PointObj[] mpArray = new PointObj[outerPoints.length];
    for(int i=0; i<outerPoints.length; i++){
      int nexti = i+1;
      if(nexti == outerPoints.length){nexti = 0;}
      PointObj thisMP = calcMidPoints(outerPoints[i],outerPoints[nexti]);
      mpArray[i] = thisMP;
    }
    return mpArray;
  }
  
  PointObj calcMidPoints(PointObj end1,PointObj end2){
    float mx,my;
    if(end1.x>end2.x){
      mx = end2.x + ((end1.x - end2.x)/2);
    }else{
      mx = end1.x + ((end2.x - end1.x)/2);
    }
    if(end1.y>end2.y){
      my = end2.y + ((end1.y - end2.y)/2);
    }else{
      my = end1.y + ((end2.y - end1.y)/2);
    }
    return new PointObj(mx,my);
  }
  PointObj[] midPoints = {};
  
  PointObj[] calcStrutPoints(){
    PointObj[] strutArray = new PointObj[midPoints.length];
    for(int i=0; i<midPoints.length; i++){
      int nexti = i+3;
      if(nexti >= midPoints.length){
        nexti -= midPoints.length;
      }
      PointObj thisSP = calcProjPoint(midPoints[i],outerPoints[nexti]);
      strutArray[i] = thisSP;
    }
    return strutArray;
  }
  
  PointObj calcProjPoint(PointObj mp,PointObj op){
    float px, py;
    float adj, opp;
    if(op.x > mp.x){
      opp = op.x - mp.x;
    }else{
      opp = mp.x - op.x;
    }
    if(op.y > mp.y){
      adj = op.y - mp.y;
    }else{
      adj = mp.y - op.y;
    }
    if(op.x > mp.x){
      px = mp.x + (opp*_strutFactor);
    }else{
      px = mp.x - (opp*_strutFactor);
    }
    if(op.y > mp.y){
      py = mp.y + (adj*_strutFactor);
    }else{
      py = mp.y - (adj*_strutFactor);
    }
    return new PointObj(px,py);
  }
  
  PointObj[] projPoints = {};
 
  Branch[] myBranches = {};
  
  Branch(int lev, int n, PointObj[] points){
    level = lev;
    num = n;
    outerPoints = points;
    midPoints = calcMidPoints();
    projPoints = calcStrutPoints();
    if((level+1)<_maxlevels){
      Branch childBranch = new Branch(level+1, 0, projPoints);
      myBranches = (Branch[])append(myBranches,childBranch);
      
      for(int k=0; k<outerPoints.length; k++){
        int nextk = k-1;
        if(nextk < 0){
          nextk += outerPoints.length;
        }
        PointObj[] newPoints = { projPoints[k],midPoints[k],outerPoints[k],midPoints[nextk] };
        childBranch = new Branch(level+1,k+1,newPoints);
        myBranches = (Branch[])append(myBranches,childBranch);
      }
    }
  }
  
  void drawMe(){
    int h = hour();
    float m = minute();
    float s = second();
    for(int i=0; i<outerPoints.length; i++){
      int nexti = i+1;
      if(nexti == outerPoints.length){
        nexti = 0;
      }
      line(outerPoints[i].x, outerPoints[i].y, outerPoints[nexti].x, outerPoints[nexti].y);
    }
    //strokeWeight(1);
    //noFill();
    noStroke();
    fill(H,S,100,5);
    for(int j=0; j<midPoints.length; j++){
      _rnoise += 0.000001*h;
      float r = m*5-noise((_rnoise)*h)*h;
      float r1 = m*2-noise((_rnoise)*h)*h;
      //rect(midPoints[j].x,midPoints[j].y,r,r);
      line(midPoints[j].x,midPoints[j].y,projPoints[j].x,projPoints[j].y);
      //rect(projPoints[j].x,projPoints[j].y,r1,r1);
    }
    noFill();
    stroke(H+60,S,100,10);
    if(s>=0 && s<30){
      strokeWeight(0.1*s);
    }
    if(s>=30 && s<=60){
      strokeWeight(3.0 - 0.1*(s-30));
    }
    for(int j=0; j<midPoints.length; j++){
      _rnoise += 0.000001*h;
      float r2 = m*7-noise((_rnoise)*h)*h;
      //ellipse(midPoints[j].x,midPoints[j].y,r2,r2);
    }
    for(int k=0; k<myBranches.length; k++){
      myBranches[k].drawMe();
    }
  }
}

void keyPressed() {
  if (key == 's') {
    save("Noise" +count+ ".png");
    count++;
  }
}


class tempo implements Instrument {

  Oscil toneOsc;
  ADSR adsr;
  AudioOutput out;
  
  tempo( String note, float amplitude, Waveform wave, AudioOutput output )
  {
     out = output;
     float frequency = Frequency.ofPitch( note ).asHz();
     toneOsc = new Oscil( frequency, amplitude, wave );
     adsr = new ADSR( 1.0, 0.04, 0.01, 1.0, 0.1 );
     toneOsc.patch( adsr );
  }
     void noteOn( float dur )
  {
    adsr.noteOn();
    adsr.patch( out );
  }
  
  void noteOff()
  {
    adsr.noteOff();
    adsr.unpatchAfterRelease( out );
  }
}
