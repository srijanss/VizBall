/*
*
class defining the weapon ups
21st April 2015 : Srijan
*
*/


class Weapon {
  // We need to keep track of a Body and a radius
  Body body;
  BodyDef bd;
  float r;
  
  Weapon(float x, float y, float r_) {
    r = r_;
    // This function puts the weapon in the Box2d world
    makeBody(x,y,r);
    body.setUserData(this);
  }

  // This function removes the weapon from the box2d world
  boolean kill() {
    box2d.destroyBody(body);
    return true;
  }

  // Is the weapon ready for deletion?
  boolean done() {
    // Let's find the screen position of the weapon
    Vec2 pos = box2d.getBodyPixelCoord(body);
      kill();
      return true;
  }
  

  // 
  void display(String weapon) {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();

    pushMatrix();
    //translate(pos.x,pos.y);
    translate(pos.x, pos.y);
    rotate(-a);
    //noFill();
    //noStroke();
    if(weapon == "gun") {
      //fill(51,51,205);
      noFill();
      //stroke(51,51,205);
      noStroke();
      image(gunmedium, -17, -18);
    } else if(weapon == "laser") {
      noFill(); 
      noStroke();
      image(lasermedium, -17, -18);
    } else if(weapon == "ammo") {
      noFill();
      noStroke();
      image(ammomedium, -17, -18);
    }
    
    //strokeWeight(4);
    
    ellipse(0,0,r*2,r*2);
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

  // Here's our function that adds the weapon objects to the Box2D world
  void makeBody(float x, float y, float r) {
    
    // Define a body
    bd = new BodyDef();
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
  
  /*void hmove(float y) {
    body.setLinearVelocity(new Vec2(0, y));
  }*/
  
  /*void shiftBody(float x) {
   body.setLinearVelocity(new Vec2(x, 0)); 
  }*/
 /* 
  void step(float xplus, float yplus){
    Vec2 pos = box2d.getBodyPixelCoord(body);
    body.setLinearVelocity(new Vec2(xplus, yplus));
    body.setAngularVelocity(-xplus * 10);
  }
  */
  
  //Function that returns weapon object's x and y coordinates in the game area : Srijan 7th March 2015
  float get_weapon_pos(String cord){
    Vec2 pos = box2d.getBodyPixelCoord(body);
    if(cord == "x"){
      return pos.x;
    }
    else{
      return pos.y;
    }
  }
} 
