/*
*
class defining the enemy
13th April 2015 : Srijan
*
*/


class Enemy {
  // We need to keep track of a Body and a radius
  Body body;
  float r;
  
  Enemy(float x, float y, float r_) {
    r = r_;
    // This function puts the ball in the Box2d world
    makeBody(x,y,r);
    body.setUserData(this);
  }

  // This function removes the ball from the box2d world
  boolean kill() {
    box2d.destroyBody(body);
    return true;
  }

  // Is the ball ready for deletion?
  boolean done() {
    // Let's find the screen position of the ball
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
    

    Fixture f = body.getFixtureList();
    PolygonShape ps = (PolygonShape) f.getShape();
    
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(-a);
    noFill();
    noStroke();
    //fill(51,51,205);
    //stroke(0);
    //strokeWeight(1);
    
    beginShape();
    for (int i = 0; i < ps.getVertexCount(); i++) {
      Vec2 v = box2d.vectorWorldToPixels(ps.getVertex(i));
      vertex(v.x, v.y);
    }
    endShape(CLOSE);
    //ellipse(0,0,r*2,r*2);
    image(enemyOne,-240,-125);
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

  // Here's our function that adds the ball to the Box2D world
  void makeBody(float x, float y, float r) {
    
    // custom polygon shape
    PolygonShape sd = new PolygonShape();

    Vec2[] vertices = new Vec2[4];
    //vertices[0] = box2d.vectorPixelsToWorld(new Vec2(-10, -35));
    //vertices[1] = box2d.vectorPixelsToWorld(new Vec2(10, -35));
    //vertices[2] = box2d.vectorPixelsToWorld(new Vec2(28, 15));
    //vertices[3] = box2d.vectorPixelsToWorld(new Vec2(-28, 15));
    
    //for smaller image
    vertices[0] = box2d.vectorPixelsToWorld(new Vec2(-5, -18));
    vertices[1] = box2d.vectorPixelsToWorld(new Vec2(5, -18));
    vertices[2] = box2d.vectorPixelsToWorld(new Vec2(15, 15));
    vertices[3] = box2d.vectorPixelsToWorld(new Vec2(-15, 15));
    

    sd.set(vertices, vertices.length);
    
    // Define a body
    BodyDef bd = new BodyDef();
    // Set its position
    bd.position = box2d.coordPixelsToWorld(x,y);
    bd.type = BodyType.STATIC;
    body = box2d.world.createBody(bd);

    // Make the body's shape a circle
    //CircleShape cs = new CircleShape();
    //cs.m_radius = box2d.scalarPixelsToWorld(r);
    
    //FixtureDef fd = new FixtureDef();
    //fd.shape = cs;
    //// Parameters that affect physics
    //fd.density = 1;
    //fd.friction = 0.01;
    //fd.restitution = 0.3;
    
    // Attach fixture to body
    body.createFixture(sd, 1.0);
    //body.createFixture(fd);

    // Give it a random initial velocity (and angular velocity)
    //body.setLinearVelocity(new Vec2(random(-10f,10f),random(5f,10f)));
    //body.setAngularVelocity(random(-10,10));
  }
 /* 
  void step(float xplus, float yplus){
    Vec2 pos = box2d.getBodyPixelCoord(body);
    body.setLinearVelocity(new Vec2(xplus, yplus));
    body.setAngularVelocity(-xplus * 10);
  }
  */
  
  //Function that returns ball's x and y coordinates in the game area : Srijan 7th March 2015
  float get_enemy_pos(String cord){
    Vec2 pos = box2d.getBodyPixelCoord(body);
    if(cord == "x"){
      return pos.x;
    }
    else{
      return pos.y;
    }
  }
} 
