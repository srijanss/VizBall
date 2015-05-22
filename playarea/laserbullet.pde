/*
*
class defining the bullet
17th May 2015 : Srijan
*
*/


class LaserBullet {
  // We need to keep track of a Body and a radius
  Body body;
  BodyDef bd;
  float x;
  float y;
  float w;
  float h;
  
  LaserBullet(float _x, float _y, float _w, float _h) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    // This function puts the bullet in the Box2d world
    makeBody(x,y,w,h);
    body.setUserData(this);
  }

  // This function removes the bullet from the box2d world
  boolean kill() {
    box2d.destroyBody(body);
    return true;
  }

  // Is the bullet ready for deletion?
  boolean done() {
    // Let's find the screen position of the bullet
    Vec2 pos = box2d.getBodyPixelCoord(body);
      kill();
      return true;
  }
  

  // 
  void display() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    //float a = body.getAngle();

    pushMatrix();
    translate(pos.x, pos.y);
    //rotate(-a);
    //noFill();
    noStroke();
    fill(204,0,0);
    //stroke(0);
    //strokeWeight(1);
    //fill(129, 206, 15);
    //stroke(0);
    rectMode(CENTER);
    rect(0,0,w,h);
    popMatrix();
  }
  
  void shiftBody(String dir) {
   if(dir == "l"){
     body.setTransform(new Vec2(body.getPosition().x + 0.5, body.getPosition().y), body.getAngle());
   }else{
    body.setTransform(new Vec2(body.getPosition().x - 0.5, body.getPosition().y), body.getAngle());
   } 
  }

  // Here's our function that adds the bullet objects to the Box2D world
  void makeBody(float x, float y, float w, float h) {
    
    // Define a body
    bd = new BodyDef();
    // Set its position
    bd.position = box2d.coordPixelsToWorld(x,y);
    bd.type = BodyType.DYNAMIC;
    body = box2d.world.createBody(bd);
    body.setGravityScale(0);

    // Define the polygon
    PolygonShape sd = new PolygonShape();
    // Figure out the box2d coordinates
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    // We're just a box
    sd.setAsBox(box2dW, box2dH);
    
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    // Parameters that affect physics
    fd.density = 1;
    fd.friction = 0.01;
    fd.restitution = 0.3;
    
    // Attach fixture to body
    body.createFixture(fd);
  }
  
  
  
  //Function that returns bullet object's x and y coordinates in the game area : Srijan 7th March 2015
  float get_bullet_pos(String cord){
    Vec2 pos = box2d.getBodyPixelCoord(body);
    if(cord == "x"){
      return pos.x;
    }
    else{
      return pos.y;
    }
  }
} 
