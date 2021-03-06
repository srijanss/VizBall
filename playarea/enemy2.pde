/*
*
class defining the enemy
13th April 2015 : Srijan
*
*/


class Enemy2 {
  // We need to keep track of a Body and a radius
  Body body;
  float r;
  
  Enemy2(float x, float y, float r_) {
    r = r_;
    // This function puts the enemy in the Box2d world
    makeBody(x,y,r);
    body.setUserData(this);
  }

  // This function removes the ene from the box2d world
  boolean kill() {
    box2d.destroyBody(body);
    return true;
  }

  // Is the enemy ready for deletion?
  boolean done() {
    // Let's find the screen position of the enemy
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Is it off the bottom of the screen?
    //if (pos.y > height+r*2) {
      kill();
      return true;
    //}
    //return false;
  }

  // 
  void display() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();

    pushMatrix();
    translate(pos.x,pos.y);
    rotate(-a);
    noFill();
    noStroke();
    //fill(51,51,205);
    stroke(0);
    strokeWeight(1);
    
    ellipse(0,0,r*2,r*2);
    image(enemyTwo, -291, -103);
    // Let's add a line so we can see the rotation
    //line(0,0,r,0);
    popMatrix();
  }
  
  void shiftBody(String dir) {
   if(dir == "l"){
     body.setTransform(new Vec2(body.getPosition().x + 0.1, body.getPosition().y), body.getAngle());
   }else{
    body.setTransform(new Vec2(body.getPosition().x - 0.1, body.getPosition().y), body.getAngle());
   } 
  }

  // Here's our function that adds the enemy to the Box2D world
  void makeBody(float x, float y, float r) {
    
    // Define a body
    BodyDef bd = new BodyDef();
    // Set its position
    bd.position = box2d.coordPixelsToWorld(x,y);
    bd.type = BodyType.KINEMATIC;
    body = box2d.world.createBody(bd);

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
  
  void bounce(float y) {
    body.setLinearVelocity(new Vec2(0, y));
  }
  
  void crawl(float x) {
    body.setLinearVelocity(new Vec2(x, 0));
  }
 /* 
  void step(float xplus, float yplus){
    Vec2 pos = box2d.getBodyPixelCoord(body);
    body.setLinearVelocity(new Vec2(xplus, yplus));
    body.setAngularVelocity(-xplus * 10);
  }
  */
  
  //Function that returns enemy's x and y coordinates in the game area : Srijan 7th March 2015
  float get_enemy2_pos(String cord){
    Vec2 pos = box2d.getBodyPixelCoord(body);
    if(cord == "x"){
      return pos.x;
    }
    else{
      return pos.y;
    }
  }
} 
