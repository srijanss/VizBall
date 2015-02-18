class Ball {
  float x, y, radius;
  
  //initial version of ball 
  /*Ball() {
    radius = 16;
    x = width*0.25;
    y = height*0.5;
  }*/
  
  //creation of ball w.r.t parameters
  Ball(float xpos, float ypos, float r){
    x = xpos;
    y = ypos;
    radius = r;
  }
  
  void display(){
    fill(255);
    ellipse(x, y, radius*2, radius*2);
    redraw();
  }
  
  void step(float xstep, float ystep){
    x += xstep;
    y += ystep;
    redraw();
     
  }
} 
