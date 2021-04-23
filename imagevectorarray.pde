import peasy.*;
import java.util.ArrayDeque;
import java.util.Queue;

// choose channel  
int channel = RED; 
 
// channels to work with
final static int RED = 0;
final static int GREEN = 1;
final static int BLUE = 2;
final static int HUE = 3;
final static int SATURATION = 4;
final static int BRIGHTNESS = 5;
final static int NRED = 6;
final static int NGREEN = 7;
final static int NBLUE = 8;
final static int NHUE = 9;
final static int NSATURATION = 10;
final static int NBRIGHTNESS = 11;

int n=2000;
int arc = 20;
float [][] cx = new float[n][arc];
float [][] cy = new float[n][arc];
 
PImage img;
int len;
 
// working buffer
PGraphics buffer; 
 
void setup() {
  
  size(800,600);
  
  img = loadImage("Desktop/check4.jpeg");
  
  buffer = createGraphics(width, height);
  buffer.beginDraw();
  buffer.noFill();
  buffer.strokeWeight(0.3);
  buffer.background(0);
  buffer.endDraw();
  
  
  image(img,0,0,width,height);
  for(int i=0;i<n;i++) {
    float xrand = random(width);
    float yrand = random(height);
    for(int j=0;j<arc;j++) {
      cx[i][j]=xrand;
      cy[i][j]=yrand;
    }
  }

}
 
void draw() {  

  buffer.beginDraw();
  //buffer.background(0);
  for(int i=0;i<n;i++) {
    for(int j=0;j<arc-1;j++) {
      
      color c = img.get((int)cx[i][j], (int)cy[i][j]);
      buffer.stroke(255);
      buffer.strokeWeight(2);
      buffer.point(cx[i][j], cy[i][j]);
      // you can choose channels: red(c), blue(c), green(c), hue(c), saturation(c) or brightness(c)
      cy[i][0] += sin(map(getChannel(c),0,255,0,TWO_PI));
      cx[i][0] += cos(map(getChannel(c),0,255,0,TWO_PI));
      cy[i][j+1] = cy[i][j] + sin(map(getChannel(c),0,255,0,TWO_PI));
      cx[i][j+1] = cx[i][j] + cos(map(getChannel(c),0,255,0,TWO_PI));
      
      //boundaries
      if(cx[i][0]>width||cx[i][0]<0) { 
        cx[i][0]=random(width);
      }
      if(cy[i][0]>height||cy[i][0]<0) { 
        cy[i][0]=random(height);
      }
    }
  } 

  buffer.endDraw();


  image(buffer,0,0,width,height);
    
  
  if(frameCount==1000) {
    //println("Ahhh");
    saveFrame("handout.png");
  }
  

}
 
float getChannel(color c) {
  int ch = channel>5?channel-6:channel;
  float cc;
  
  switch(ch) {
    case RED: cc = red(c); break;
    case GREEN: cc = green(c); break;
    case BLUE: cc = blue(c); break;
    case HUE: cc = hue(c); break;
    case SATURATION: cc = saturation(c); break;
    default: cc= brightness(c); break;
  }
  
  return channel>5?255-cc:cc;
}
  
