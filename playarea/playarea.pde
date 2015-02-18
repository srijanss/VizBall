
Ball b1;

void setup(){
  size(640, 360);
  noLoop();
  //create the initial ball object
  b1 = new Ball();
  
}

void draw(){
  background(75);
  noFill();
  stroke(255);
  //green floor at the bottom
  fill(129, 206, 15);
  rect(0, 340, width, 20);
  //create ball
  b1.display();
}
