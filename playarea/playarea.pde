
Ball b1;

void setup(){
  size(640, 360);
  noLoop();
  //b1 = new Ball();
  //create the ball object with parameters
  b1 = new Ball(width*0.5, height*0.4, 16);
  
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

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      b1.step(0,-10);
    } 
    if (keyCode == DOWN) {
      b1.step(0,10);
    } 
    if (keyCode == RIGHT) {
      b1.step(10,0);
    }
    if (keyCode == LEFT) {
      b1.step(-10,0);
    }
  }
}
