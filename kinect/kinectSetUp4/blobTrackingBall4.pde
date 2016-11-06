class Blob {
  float minx;
  float miny;
  float maxx;
  float maxy;

  ArrayList<PVector> points;

  Blob(float x, float y) {
    minx = x;
    miny = y;
    maxx = x;
    maxy = y;
    points = new ArrayList<PVector>();
    points.add(new PVector(x, y));
  }

  void show() {
    noStroke();
    rectMode(CORNERS);
    //rect(minx, miny, maxx, maxy);
    //Green Tracking Ball down-----------------------------------
  
  float d1 = 10 + (sin(angle + PI/2) * diameter/2) + diameter;
  //PVector v2 = tracker.getLerpedPos();
  fill(0, 255,255);
  noStroke();

  //ellipse(v2.x, v2.y, d1, d1);
  
  angle += 0.05;
    ellipse((maxx + minx)/2, (maxy + miny)/2, d1, d1);
    
    //for (PVector v : points) {
      //stroke(0, 0, 255);
      //point(v.x, v.y);
    //}
  }


  void add(float x, float y) {
    points.add(new PVector(x, y));
    minx = min(minx, x);
    miny = min(miny, y);
    maxx = max(maxx, x);
    maxy = max(maxy, y);
  }

  float size() {
    return (maxx-minx)*(maxy-miny);
  }
  
  void checkCollision(Blob other){
    //if (){
    //}
  }

  boolean isNear(float x, float y) {

    // The Rectangle "clamping" strategy
    // float cx = max(min(x, maxx), minx);
    // float cy = max(min(y, maxy), miny);
    // float d = distSq(cx, cy, x, y);

    // Closest point in blob strategy
    float d = 10000000;
    for (PVector v : points) {
      float tempD = distSq(x, y, v.x, v.y);
      if (tempD < d) {
        d = tempD;
      }
    }

    if (d < distThreshold*distThreshold) {
      return true;
    } else {
      return false;
    }
  }
}