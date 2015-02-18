void setup(){
  size(640, 360);
}

void draw(){
  background(75);
  noFill();
  stroke(255);
  //green floor at the bottom
  fill(129, 206, 15);
  rect(0, 340, width, 20);
  //create the ball and fill with white color
  fill(255);
  ellipse(252, 144, 32, 32);
}
