import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;
import org.openkinect.tests.*;

// Daniel Shiffman
// Tracking the average location beyond a given depth threshold
// Thanks to Dan O'Sullivan

// https://github.com/shiffman/OpenKinect-for-Processing
// http://shiffman.net/p5/kinect/

// The kinect stuff is happening in another class
KinectTracker tracker;
Kinect kinect;

color trackColor; 
float colorThreshold = 50;
float distThreshold = 75;

float ballPosX = 540;
float ballPosY = 450;

float diameter; 
float angle = 0;

ArrayList<Blob> blobs = new ArrayList<Blob>();
Oscillator[] oscillators = new Oscillator[10];

void setup() {
  
  //Kinect down----------------------------------------
  size(640, 520);
  
  trackColor = color(0, 0, 0);
  kinect = new Kinect(this);
  tracker = new KinectTracker();
  
  //Oscillating Objects down---------------------------
  smooth();  
  // Initialize all objects
  for (int i = 0; i < oscillators.length; i++) {
    oscillators[i] = new Oscillator();
  }
  
  //Tracking Ball----------------------------------------
  diameter = height - 490;
}

void draw() {
  background(255);
  blobs.clear();
  
  //Kinect down

  // Run the tracking analysis-------------------------------
  tracker.track();
  // Show the image
  tracker.display();
  
    //Oscillating Objects down---------------------------------
  for (int i = 0; i < oscillators.length; i++) {
    oscillators[i].oscillate();
    oscillators[i].display();
  }

  // Multiple hands tracking for the ball------------------------------------------
 
  for (int x = 0; x < tracker.display.width; x+=30 ) {
    for (int y = 0; y < tracker.display.height; y+=30 ) {
      int loc = x + y * tracker.display.width;
      // What is current color
      color currentColor = tracker.display.pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      float r2 = red(trackColor);
      float g2 = green(trackColor);
      float b2 = blue(trackColor);

      float d = distSq(r1, g1, b1, r2, g2, b2); 

      if (d < colorThreshold*colorThreshold) {

        boolean found = false;
        for (Blob b : blobs) {
          if (b.isNear(x, y)) {
            b.add(x, y);
            found = true;
            break;
          }
        }

        if (!found) {
          Blob b = new Blob(x, y);
          blobs.add(b);
        }
      }
    }
  }

  for (Blob b : blobs) {
    //if (b.size() > 500) {
      b.show();
    //}
  }
  
  //Display Information
  int t = tracker.getThreshold();
  textAlign(RIGHT);
  fill(0);
  text("distance threshold: " + distThreshold, width-10, 25);
  text("color threshold: " + colorThreshold, width-10, 50);
}

// Adjust the threshold with key presses
void keyPressed() {
  int t = tracker.getThreshold();
  if (key == CODED) {
    if (keyCode == UP) {
      t+=5;
      tracker.setThreshold(t);
    } else if (keyCode == DOWN) {
      t-=5;
      tracker.setThreshold(t);
    }
  }
}

float distSq(float x1, float y1, float x2, float y2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1);
  return d;
}

float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) +(z2-z1)*(z2-z1);
  return d;
}