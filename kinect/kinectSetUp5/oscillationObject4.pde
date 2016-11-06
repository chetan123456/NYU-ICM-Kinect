class Oscillator {   

  PVector angle;
  PVector velocity;
  PVector amplitude;
  float x = width/2;
  float y = height/2;
  boolean oscillatorStop = false;

  Oscillator() {   
    angle = new PVector();
    velocity = new PVector(random(-0.05, 0.05), random(-0.05, 0.05));
    amplitude = new PVector(random(20,width/2-200), random(20,height/2)-200);
  }   

  void oscillate() {
    if (!oscillatorStop) {
      angle.add(velocity);
    }
  }   

  void display() {   

    //x = sin(angle.x)*amplitude.x;
    //y = sin(angle.y)*amplitude.y;
    x += random(-2, 2);
    y += random(-2, 2);

    //pushMatrix();
    //translate(width/2, height/2);
    stroke(0);
    strokeWeight(2);
    if (!oscillatorStop) {
      fill(0,0,0);
    } else {
      fill(255, 0, 0);
    }
    //line(0, 0, x, y);  
    ellipse(x, y, 32, 32);  
    //popMatrix();
  }
}   