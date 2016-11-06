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

float ballPosX = 400;
float ballPosY = 400;

float diameter; 
float angle = 0;

//ArrayList<Blob> blobs = new ArrayList<Blob>();
Oscillator[] oscillators = new Oscillator[10];

void setup() {
  
  //Kinect down----------------------------------------
  size(640, 520);
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

  //Green Tracking Ball down-----------------------------------
  
  float d1 = 10 + (sin(angle + PI/2) * diameter/2) + diameter;
  PVector v2 = tracker.getLerpedPos();
  fill(0, 255,255);
  noStroke();

  ellipse(v2.x, v2.y, d1, d1);
  
  angle += 0.05;

  // Display some info------------------------------------------
  int t = tracker.getThreshold();
  fill(0);
  text("threshold: " + t + "    " +  "framerate: " + int(frameRate) + "    " + 
    "UP increase threshold, DOWN decrease threshold", 10, 500);
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