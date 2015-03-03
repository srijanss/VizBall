//VVizball Game Playarea

//imports from box2d library
import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.*;

// A reference to our box2d world
Box2DProcessing box2d;
PImage sky, bg;

//Ball in the playarea
Ball ball;

// An objects to store information about the surfaces
//3rd March 2015: Srijan: Added ceiling surface
Surface surface, surface2, surface3, verticalSurface, ceiling1, ceiling2;


void setup(){
  size(640, 360);
  sky = loadImage("./images/sky.png");
  bg = loadImage("./images/mountain_trees.png");
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
  ceiling1 = new Surface(width, 0, -10);
  ceiling2 = new Surface(width, 20, -10);
  verticalSurface = new Surface(0, 640, -10);
  
}

void draw(){
  // We must always step through time!
  box2d.step();

  background(255,204,153);
  image(sky, 0, 0);
  image(bg, 0, 0);
  //background(bg);

  // Draw the surface
  surface.display();
  surface2.display();
  //surface3.display();
  ceiling1.display();

  // Draw the ball
  ball.display();
}
boolean keyUp = false;
boolean keyDown = false;
boolean keyRight = false;
float moveRight = 0;
float moveLeft = 0;
boolean keyLeft = false;
boolean keyCtrl = false;
boolean keyR = false;

void keyPressed() {
  if(key == 'r' || key == 'R'){
    if(ball.done()){
      ball = new Ball(width*0.5, height*0.4, 16);
    } 
  }
  if (key == CODED) {
    if(keyCode == CONTROL) {
    keyCtrl = true; 
  }
    if (keyCode == UP) {
      keyUp = true;
      //ball.step(0,10);
    } 
    if (keyCode == DOWN) {
      keyDown = true;
      //ball.step(0,-30);
    } 
    if (keyCode == RIGHT) {
      keyRight = true;
      //ball.step(30,-2);
      //redraw();
    }
    if (keyCode == LEFT) {
      keyLeft = true;
      //ball.step(-30,-2);
      //redraw();
    }
    if(keyUp == true && keyRight == true) {
      ball.step(10,10); 
    }
    else if(keyUp == true && keyLeft == true) {
      ball.step(-10,10);
    }
    else if(keyCtrl == true && keyUp == true){
      box2d.setGravity(0, 5); 
      //keyCtrl = false;
    }
    else if(keyCtrl == true && keyDown == true){
      box2d.setGravity(0, -20);
      //keyCtrl = false; 
    }
    else if(keyUp == true) {
      ball.step(0,10);
      moveLeft = 0;
      moveRight = 0;
    }
    /*else if(keyDown == true && keyRight == true) {
      ball.step(5, -15); 
    }
    else if(keyDown == true && keyLeft == true) {
      ball.step(-5, -15);
    }*/
    else if(keyDown == true) {
      //ball.step(0, -30);
      moveLeft = 0;
      moveRight = 0;
    }
    else if(keyRight == true) {
      ball.step(10 + moveRight, -10);
      if(moveRight < 20){
        moveRight += 5;
      }
      moveLeft = 0;
    }
    else if(keyLeft == true) {
      ball.step(- 10 + moveLeft, -10);
      if(moveLeft > -20){
        moveLeft -= 5;
      }
      moveRight = 0;
    }
    
  }
  
}
  
  void keyReleased(){
    if(key == CODED) {
      if(keyCode == UP){
         keyUp = false; 
      }
      if(keyCode == DOWN) {
        keyDown = false;
      }
      if(keyCode == RIGHT) {
        keyRight = false;
        //moveRight = 0;
      }
      if(keyCode == LEFT) {
        keyLeft = false;
        //moveLeft = 0;
      }
      if(keyCode == CONTROL) {
        keyCtrl = false;
        //moveLeft = 0;
      }
      
    }
  }


