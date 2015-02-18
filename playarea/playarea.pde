
Ball b1;
float r = 48;
float g = 139;
float b = 206;
float ballXRPos = 0;
float ballXLPos = 0;
float ballYTPos = 0;
float ballYBPos = 0;


void setup(){
  size(640, 360);
  noLoop();
  //b1 = new Ball();
  //create the ball object with parameters
  b1 = new Ball(width*0.5, height*0.4, 16);
  
}

void draw(){
  background(r, g, b);
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
      ballXRPos = b1.getBallXPos();
        if(ballXRPos>650){
          changeBackground();
          b1.resetBallXPosition(10);
          redraw();
        }
    }
    if (keyCode == LEFT) {
      b1.step(-10,0);
        ballXLPos = b1.getBallXPos();
        if(ballXLPos<0){
          b1.resetBallXPosition(640);
          changeBackground();
          redraw();
        }
    }
  }
}

void changeBackground(){
    r = 41;
    g = 5;
    b = 106; 
    redraw();   
}

