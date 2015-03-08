//VVizball Game Playarea

//imports from box2d library
import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.*;
import controlP5.*;

// A reference to our box2d world
Box2DProcessing box2d;
PImage sky, bg, startupImg;
int gameScreen, timer, gameStartupCount;
//ControlP5 Library used
// 2nd March: Bikram: Added startup of Name Inquiry and greetings Screen.
ControlP5 cp5;
Textfield targetField;
Textlabel displayGreetings, displayNameOnLeft;
String playerName;
Button bangButton;


ArrayList<Box> platforms;
ArrayList<Box> ceilings;
ArrayList<Box> floors;


//Ball in the playarea
Ball ball;
float game_width = 640 * 5;
float scroll_flag = 0;
float old_pos = 0;
float current_pos = 0;
float shift = 0;

// An objects to store information about the surfaces
//3rd March 2015: Srijan: Added ceiling surface
//Surface surface, surface2, surface3, verticalSurface, ceiling1, ceiling2;

//Startup Screen object 
StartUpScreen s;

void setup(){
  size(640, 360);
  sky = loadImage("./images/sky.png");
  bg = loadImage("./images/mountain_trees.png");
  startupImg = loadImage("./images/1.jpg");
  smooth();
  

  cp5 = new ControlP5(this);
  s = new StartUpScreen();
  s.display();
  gameScreen = 1;
  gameStartupCount = 5;

  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  // We are setting a custom gravity
  box2d.setGravity(0, -20);
  
  //Create the empty list for surfaces
  platforms = new ArrayList<Box>();
  ceilings = new ArrayList<Box>();
  floors = new ArrayList<Box>();
  
  //create a Ball with specified size and at given coordinates in screen
  ball = new Ball(width*0.1, height*0.4, 16);
  
  //gap that defines the platforms to occur after the screen width : Srijan 3rd March 2015
  float platform_gap = 0;
  //Creating new platforms and adding to ArrayList : Srijan 3rd March 2015
  for(float w=width; w<=width; w+=width){
    //float platform_x_pos = random(3,5);
    //float platform_y_pos = random(10,20);
    platforms.add(new Box(platform_gap + 3*w/4,height-150,width/2-50,10));
    platforms.add(new Box(platform_gap + w/4,height-250,width/2-50,10));
    platforms.add(new Box(platform_gap + 5*w/4,height-200,width/2-50,10));
    platform_gap += width;
  }
  //Defines the gap between the floors : Srijan 3rd March 2015
  float floor_gap = 0;
  //Defines the gap between the ceilings : Srijan 3rd March 2015
  float ceiling_gap = 0;
  //Create floors and adds to Arraylist : Srijan 3rd March 2015
  for(float w=0; w<game_width; w+=width/2){
    floors.add(new Box(w+floor_gap,height-5,width/2,10));
    floor_gap +=100;
  }
  //Create ceilings and adds to Arraylist : Srijan 3rd March 2015
  for(float w=0; w<game_width; w+=width/4){  
    ceilings.add(new Box(w+ceiling_gap,5,width/4,10));
    ceiling_gap += 100;
    //ceilings.add(new Box(0,5,width*2,10));
  }
  
  
  // Create the surface
  //verticalSurface = new Surface(0, 640, -10, 0);*/
  
}

void draw(){
  switch (gameScreen){
      case 1:{
          /*Show Homepage Name Input Screen*/
          background(startupImg);
          break;  
      }
      case 2:{
         /*Show Greetings and Play buttons*/
         //1/8/015: Bikram
          background(startupImg);
          displayGreetings.setText("Welcome " + playerName + " , Your Game Starting in \n                      " + gameStartupCount + " Seconds"); 
          if (millis() - timer >= 1000) {
              timer = millis();
              gameStartupCount  -= 1;
              if(gameStartupCount==0){
                displayGreetings.remove();
                gameScreen = 3;
              }
           }
            
          /* Removing GUI */
          targetField.remove();
          bangButton.remove();
          break;
      }
      case 3:{
           //Display Username: left
           //3/8/015: Bikram
           displayNameOnLeft.setText(playerName);
  // We must always step through time!
  box2d.step();

  background(255,204,153);
  image(sky, 0, 0);
  image(bg, 0, 0);
  //background(bg);

  //Display platforms, floors, ceilings in the Array list : Srijan 3th March 2015
  for(Box b: platforms) {
      b.display();
  }
  for(Box b: floors) {
      b.display();
  }
  for(Box b: ceilings) {
      b.display();
  }
  //ceiling1.display();

  // Draw the ball
  ball.display();
  //box.display();
  
  //Kill the ball if ball goes through hole in floors or ceiling : Srijan 5th March 2015
  if(ball.get_ball_pos("y") > height+16 || ball.get_ball_pos("y") < -16){
    ball.done(); 
    ball = new Ball(width*0.5, height*0.4, 16);
  }
  
  //Scrolling effect when the ball is moved : Srijan 8th March 2015
  current_pos = ball.get_ball_pos("x");
  if(old_pos != current_pos){
    if(old_pos > current_pos){
      if((old_pos - current_pos) > 0.15) { 
        scroll(2);
      }
      else{
        scroll(1); 
      }
    }
    else{
      if((current_pos - old_pos) > 0.15) { 
        scroll(-2);
      }
      else{
        scroll(-1); 
      }
     }
  }
  old_pos = current_pos;
  
}

boolean keyUp = false;
boolean keyDown = false;
boolean keyRight = false;
float moveRight = 0;
float moveLeft = 0;
boolean keyLeft = false;
boolean keyCtrl = false;
boolean keyR = false;

//Scroll function to scroll the floor, ceilings and platforms : Srijan 5th March 2015
void scroll(float value){
  shift += value;
    for(int i=0; i<platforms.size(); i++){
       Box b = platforms.get(i);
       if(b.kill()){
         platforms.remove(i);
       } 
    }
    float platform_gap = 0;
    for(float w=width; w<=game_width; w+=width){
      platforms.add(new Box(shift+platform_gap + 3*w/4,height-150,width/2-50,10));
      platforms.add(new Box(shift+platform_gap + w/4,height-250,width/2-50,10));
      platforms.add(new Box(shift+platform_gap + 5*w/4,height-200,width/2-50,10));
      platform_gap += width;
    }
   float floor_gap = 0;
   float ceiling_gap = 0;
   for(int i=0; i<floors.size(); i++){
       Box f = floors.get(i);
       if(f.kill()){
         floors.remove(i);
       } 
    }
    for(int i=0; i<ceilings.size(); i++){
       Box c = ceilings.get(i);
       if(c.kill()){
         ceilings.remove(i);
       } 
    }
   for(float w=0; w<game_width; w+=width/2){
     floors.add(new Box(shift+w+floor_gap,height-5,width/2,10));
     floor_gap +=100;
   }
   for(float w=0; w<game_width; w+=width/4){  
     ceilings.add(new Box(shift+w+ceiling_gap,5,width/4,10));
     ceiling_gap += 100;
    }
  
}

void keyPressed() {
  if(key == 'r' || key == 'R'){
     scroll(0.5);
  }
  if(key == 'l' || key == 'L'){
     scroll(-0.5);
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
      ball.step(0.1,10); 
    }
    else if(keyUp == true && keyLeft == true) {
      ball.step(-0.1,10);
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
      ball.step(0.05 + moveRight, -10);
      if(moveRight < 3 && moveRight < 4){
        moveRight += 0.1;
      }
      moveLeft = 0;
    }
    else if(keyLeft == true) {
      ball.step(-0.05 + moveLeft, -10);
      if(moveLeft > -5 && moveLeft > -6){
        moveLeft -= 0.1;
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

//Play button click event
public void play() {
  playerName = targetField.getText();
  if(playerName!=""){
     gameScreen = 2;
  }
}
