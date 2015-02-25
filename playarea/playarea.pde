//VVizball Game Playarea

//imports from box2d library
import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.*;

// A reference to our box2d world
Box2DProcessing box2d;

//Ball in the playarea
Ball ball;

// An objects to store information about the surfaces
Surface surface, surface2, surface3;


void setup(){
  size(640, 360);
  smooth();
  
  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  // We are setting a custom gravity
  box2d.setGravity(0, -20);
  //create a Ball with specified size and at given coordinates in screen
  ball = new Ball(width*0.5, height*0.4, 16);
  // Create the surface
  surface = new Surface(width, height - 20, -10);
  surface2 = new Surface(width, height - 250, 320);
  surface3 = new Surface(width, height - 230, 320); 
  
}

void draw(){
  // We must always step through time!
  box2d.step();

  background(255);

  // Draw the surface
  surface.display();
  surface2.display();
  //surface3.display();

  // Draw the ball
  ball.display();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      ball.step(0,10);
    } 
    if (keyCode == DOWN) {
      ball.step(0,-100);
    } 
    if (keyCode == RIGHT) {
      ball.step(10,-2);
      //redraw();
    }
    if (keyCode == LEFT) {
      ball.step(-10,-2);
      //redraw();
    }
  }
}


