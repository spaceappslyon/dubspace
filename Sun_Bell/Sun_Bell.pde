import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer player;
AudioMetaData meta;
BeatDetect beat;
int  r = 300;
float rad = 800;
Location[] points = new Location[20000];
int myWidth = 1920;
int myHeight = 1080;
int myX, myY, myZ; 
int radius = 400;
float rotY = PI/25;
void setup()
{
  size(1920, 1080, P3D);
  minim = new Minim(this);
  player = minim.loadFile("Sun Bell.mp3");
  createPoints();
  meta = player.getMetaData();
  beat = new BeatDetect();
  player.loop();
  PImage img;
  img = loadImage("bg.jpg");
  background(img);
  noCursor();
}

void draw()
{ 
  float t = map(mouseX, 0, width, 0, 1);
  beat.detect(player.mix);
  fill(#1A1F18, 20);
  noStroke();
  translate(1920/2, 1080/2);
  float h = random(0, 150);
  stroke(5);
  fill(250, h, 10);
  rad = 70;
  stroke(0, 50);
  rotateY(-rotY/50);
  for (int b = 0; b <= points.length - 1; b++){
    pushMatrix();
    translate(points[b].x, points[b].y, points[b].z);
    rect(0, 0, 1, 1);
    popMatrix();
  }
  rotY = rotY + TWO_PI / 25;
  int bsize = player.bufferSize();
    beginShape();
  fill(250, 150, 0, 250);
  stroke(200, h, 0, 250);
  for (int i = 0; i < bsize; i+=10)
  {
    float x2 = (r + player.left.get(i)*100)*cos(i*2*PI/bsize);
    float y2 = (r + player.left.get(i)*100)*sin(i*2*PI/bsize);
    vertex(x2 , y2);
    pushStyle();
    strokeWeight(0);
    smooth(8);
    point(x2, y2);
    popStyle();
  }
  endShape();
  rotateY(rotY/50);
   rotateZ(rotY/50);
  fill(250, 150, 0, 250);
  for (int i = 0; i < bsize - 1; i+=5)
  {
   float x = (r)*cos(i*2*PI/bsize);
    float y = (r)*sin(i*2*PI/bsize);
    float x2 = (r + player.left.get(i)*300)*cos(i*2*PI/bsize);
    float y2 = (r + player.left.get(i)*300)*sin(i*2*PI/bsize);
    smooth(8);
    line(x, y, x2, y2);
    frameRate(80);
  }
}


void showMeta() {
  int time =  meta.length();
  textSize(1);
  textAlign(CENTER);
  text( (int)(time/1000-millis()/1000)/60 + ":"+ (time/1000-millis()/1000)%60, -7, 21);
}

boolean flag =false;

boolean sketchFullScreen() {
  return true;
}

void createPoints()
{
for(int i = 0; i <= points.length-1; i++)
{
float angleA = random(0, TWO_PI);
float angleB = random(0, TWO_PI);

myX = int(radius*sin(angleA)*cos(angleB));
myY = int(radius*sin(angleA)*sin(angleB));
myZ = int(radius*cos(angleA));
points[i] = new Location (myX, myY, myZ);
}
}

class Location
{
int x, y, z;

Location (int myX, int myY, int myZ)
{
x = myX;
y = myY;
z = myZ; 
}
}
