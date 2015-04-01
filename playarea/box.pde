/**
Box Class to for creating floors, ceilings and platforms
This creates box objects and adds to Box2d world
Srijan 3rd March 2015
**/
class Box {

  // A boundary is a simple rectangle with x,y,width,and height
  float x;
  float y;
  float w;
  float h;
  
  // But we also have to make a body for box2d to know about it
  Body b;
  BodyDef bd;
  PolygonShape sd;

  Box(float x_,float y_, float w_, float h_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;

    // Define the polygon
    sd = new PolygonShape();
    // Figure out the box2d coordinates
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    // We're just a box
    sd.setAsBox(box2dW, box2dH);


    // Create the body
    bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    b = box2d.createBody(bd);
    
    // Attached the shape to the body using a Fixture
    b.createFixture(sd,1);
  }

  // Draw the boundary, if it were at an angle we'd have to do something fancier
  void display() {
    //fill(0);
    fill(129, 206, 15);
    stroke(0);
    rectMode(CENTER);
    rect(x,y,w,h);
  }
 boolean kill() {
    
     box2d.destroyBody(b);
      return true;
  }
  float lifespan = 0;
  boolean isDead(){
    if(lifespan <0){
     return true;
    }
    else{
     return false;
    } 
  }
  
  void update(float _x, float _y) {
    //b.setTransform(new Vec2(_x+2, _y), b.getAngle());
    //b.setPosition(new Vec2(b.getPosition(), b.setPosition()), b.getAngle());
    lifespan = -1;
  }
  
  float get_box_pos(String cord){
    Vec2 pos = box2d.getBodyPixelCoord(b);
    if(cord == "x"){
      return pos.x;
    }
    else{
      return pos.y;
    }
  }
 
}
