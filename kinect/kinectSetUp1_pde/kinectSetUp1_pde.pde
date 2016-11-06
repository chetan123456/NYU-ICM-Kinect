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


float ballPosX = 687;
float ballPosY = 623;

float diameter; 
float angle = 0;

ArrayList<Blob> blobs = new ArrayList<Blob>();

Oscillator[] oscillators = new Oscillator[10];

void setup() {
  size(700, 520);
  
  kinect = new Kinect(this);
  tracker = new KinectTracker();
  
  //Tracking Ball----------------------------------------
  diameter = height - 490;
  
  //Oscillating Objects below----------------------------
  smooth();  
  // Initialize all objects
  for (int i = 0; i < oscillators.length; i++) {
    oscillators[i] = new Oscillator();
  }
}


void draw() {
  background(255);
  blobs.clear();

  // Run the tracking analysis
  tracker.track();
  // Show the image
  tracker.display();

  // Let's draw the raw location
  // PVector v1 = tracker.getPos();
  //fill(50, 100, 250, 200);
  //noStroke();
  //ellipse(v1.x, v1.y, 20, 20);

  // Let's draw the "lerped" location
  
  float d1 = 10 + (sin(angle + PI/2) * diameter/2) + diameter;
  PVector v2 = tracker.getLerpedPos();
  fill(100, 250, 50, 200);
  noStroke();

  ellipse(v2.x, v2.y, d1, d1);
  //println(v2.x + "ball tracking");
  
  for (Blob b : blobs) {
    b.show();
  }

  angle += 0.05;

  // Display some info
  int t = tracker.getThreshold();
  fill(0);
  text("threshold: " + t + "    " +  "framerate: " + int(frameRate) + "    " + 
    "UP increase threshold, DOWN decrease threshold", 10, 500);
    
    stroke(255);
    
    //Oscillating Objects below--------------------------------------------
    
      for (int i = 0; i < oscillators.length; i++) {
    oscillators[i].oscillate();
    oscillators[i].display();
  }
  
  //oscillators[3].velocity.mult(0);

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