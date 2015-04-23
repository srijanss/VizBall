/*
*
class defining the bullet ups
21st April 2015 : Srijan
*
*/


class Bullet {
  // We need to keep track of a Body and a radius
  Body body;
  BodyDef bd;
  float r;
  
  Bullet(float x, float y, float r_) {
    r = r_;
    // This function puts the bullet in the Box2d world
    makeBody(x,y,r);
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
    float a = body.getAngle();

    pushMatrix();
    //translate(pos.x,pos.y);
    translate(pos.x, pos.y);
    rotate(-a);
    noFill();
    //noStroke();
    /*if(bullet == "gun") {
      //fill(51,51,205);
      noFill();
      stroke(51,51,205);
    } else if(bullet == "laser") {
      noFill(); 
      stroke(204);
    } else if(bullet == "ammo") {
      noFill();
      
    }*/
    stroke(0);
    strokeWeight(4);
    
    ellipse(0,0,r/2,r/2);
    // Let's add a line so we can see the rotation
    //line(0,0,r,0);
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
  void makeBody(float x, float y, float r) {
    
    // Define a body
    bd = new BodyDef();
    // Set its position
    bd.position = box2d.coordPixelsToWorld(x,y);
    bd.type = BodyType.DYNAMIC;
    body = box2d.world.createBody(bd);
    body.setGravityScale(0);

    // Make the body's shape a circle
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);
    
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    // Parameters that affect physics
    fd.density = 1;
    fd.friction = 0.01;
    fd.restitution = 0.3;
    
    // Attach fixture to body
    body.createFixture(fd);

    // Give it a random initial velocity (and angular velocity)
    //body.setLinearVelocity(new Vec2(0,random(10f,10f)));
    //body.setAngularVelocity(random(-10,10));
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
