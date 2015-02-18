class Ball {
  float x, y, radius;
  
  //initial version of ball 
  Ball() {
    radius = 16;
  }
  
  //creation of ball w.r.t parameters
  Ball(float xpos, float ypos, float r){
    x = xpos;
    y = ypos;
    radius = r;
  }
  
  void display(){
    fill(255);
    ellipse(252, 144, 32, 32);
    redraw();
  }
  
  void step(float xstep, float ystep){
    x += xstep;
    y += ystep;
    redraw();
     
  }
} 
