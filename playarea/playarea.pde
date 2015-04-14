//VVizball Game Playarea

//imports from box2d library
import shiffman.box2d.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
import controlP5.*;

// A reference to our box2d world
Box2DProcessing box2d;
PImage sky, bg, startupImg, enemy1;
int gameScreen, isHelpDisplayed, gameStartupCount;
//ControlP5 Library used
// 2nd March: Bikram: Added startup of Name Inquiry and greetings Screen.
ControlP5 cp5;
Textfield targetField;
Textlabel displayGreetings, displayNameOnLeft, displayGameOver, timerRight, gameLevel;
Textarea helpTextarea;
String playerName;
Button bangButton, playButton;
//Array list to hold box objects for floors, ceilings and platforms
ArrayList<Box> platforms;
ArrayList<Box> ceilings;
ArrayList<Box> floors;

//endbox at the end of each level
Box endbox;

// enemy object
ArrayList<Enemy> enemy;

boolean collission_with_enemy = false;


// Vertical surface
Surface verticalSurface, verticalSurfaceRight;

//Ball in the playarea
Ball ball;
float game_width = 640 * 5;
float scrolled_width = 0;
//float scroll_flag = 0;
float floor_width = 0;
float ceiling_width = 0;

float old_pos = 0;
float current_pos = 0;
float shift = 0;

//Check to Restart the game
boolean game_over = false;

//Background shift value
float x_bg = 0;

// Game Level 
int level = 0;

// Scroll value
float fast_scroll = 2;
float slow_scroll = 1;

// scroll control 
boolean left_scroll_state = false;
boolean right_scroll_state = false;

// Key pressed
boolean keyUp = false;
boolean keyDown = false;
boolean keyRight = false;
float moveRight = 0;
float moveLeft = 0;
boolean keyLeft = false;
boolean keyCtrl = false;
boolean keyR = false;


// An objects to store information about the surfaces
//3rd March 2015: Srijan: Added ceiling surface
//Surface surface, surface2, surface3, verticalSurface, ceiling1, ceiling2;

//Startup Screen object 
StartUpScreen s;
// Timer object
Timer t;
// Game Level Object
GameLevel gl;

//GameOver Screen object
EndScreen endscreen;

void setup() {
  size(640, 360);
  sky = loadImage("./images/sky.png");
  bg = loadImage("./images/mountain_trees.png");
  startupImg = loadImage("./images/1.jpg");
  enemy1 = loadImage("./images/enemy1.png");
  smooth();


  cp5 = new ControlP5(this);
  s = new StartUpScreen();
  endscreen = new EndScreen();
  t  =  new Timer();

  s.display();
  gameScreen = 1;
  gameStartupCount = 5;
  //Check if if help is displayed
  isHelpDisplayed = 0;
  t.initializeTimer();
  // Initiliaze Game level
  gl = new GameLevel();

  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  // We are setting a custom gravity
  box2d.setGravity(0, -20);
  
  /*
   * Turn on collission listening
   * April 15 2015 : Srijan
   *
   */
  box2d.listenForCollisions();

  //Create the empty list for surfaces
  platforms = new ArrayList<Box>();
  ceilings = new ArrayList<Box>();
  floors = new ArrayList<Box>();
  
  // Create empty list for enemies
  enemy = new ArrayList<Enemy>();

  //create a Ball with specified size and at given coordinates in screen
  ball = new Ball(width*0.1, height*0.4, 16);
  
  // endbox object
  endbox = new Box(3000, -10, 100, 1024); 


  //gap that defines the platforms to occur after the screen width : Srijan 3rd March 2015
  float platform_gap = 0;
  //Creating new platforms and adding to ArrayList : Srijan 3rd March 2015
  for (float w=width; w<=width; w+=width) {
    //float platform_x_pos = random(3,5);
    //float platform_y_pos = random(10,20);
    platforms.add(new Box(platform_gap + 3*w/4, height-150, width/2-50, 10));
    platforms.add(new Box(platform_gap + w/4, height-250, width/2-50, 10));
    platforms.add(new Box(platform_gap + 5*w/4, height-200, width/2-50, 10));
    platform_gap += width;
  }
  //Defines the gap between the floors : Srijan 3rd March 2015
  float floor_gap = 0;
  //Defines the gap between the ceilings : Srijan 3rd March 2015
  float ceiling_gap = 0;
  //Create floors and adds to Arraylist : Srijan 3rd March 2015
  float floor_width = 0;
   float ceiling_width = 0;
  //for (float w=0; w<game_width; w+=width/2) {
  for (float w=0; w<game_width; w+=width/2) {
    floors.add(new Box(w+floor_gap, height-5, width/2, 10));
    floor_gap +=100;
    floor_width = w+floor_gap;
    if(floor_width >= game_width){
       break; 
    }
  }
  //Create ceilings and adds to Arraylist : Srijan 3rd March 2015
  for (float w=0; w<game_width; w+=width) {  
    ceilings.add(new Box(w+ceiling_gap, 5, width, 10));
    ceiling_gap += 100;
    //ceilings.add(new Box(0,5,width*2,10));
    ceiling_width = w+ceiling_gap;
    if(ceiling_width >= game_width){
       break; 
    }
  }
  println("Ceilings", ceilings.size());
  println("Floors", floors.size());
  
  // adding enemies to the playarea
  float enemy_gap = 0;
  for (float w=width; w<=game_width; w+=width) {
     enemy.add(new Enemy(enemy_gap+width*0.1, height*0.25, 8));
     //enemy.add(new Enemy(enemy_gap+width*0.3, height*0.45, 8));
     //enemy.add(new Enemy(enemy_gap+width*0.5, height*0.65, 8));
     enemy_gap += 512;
  }


  //Commented out the vertical surface : Srijan 7th March 2015
  // Create the surface
  verticalSurface = new Surface(0, 640, -10, 0);
  verticalSurfaceRight = new Surface(0, 640, -10, 1);
}

void draw() {
  switch (gameScreen) {
  case 1:
    {
      /*Show Homepage Name Input Screen*/
      background(startupImg);
      break;
    }
  case 2:
    {
      /*Show Greetings, Help and Play buttons*/
      //1/8/015: Bikram
      displayGreetings.setText("Welcome " + playerName); 
      background(startupImg);


      if (isHelpDisplayed == 0) {
        /* Removing GUI */
        targetField.remove();
        bangButton.remove();
        s.displayHelp();
        gameScreen = 2;
        isHelpDisplayed =1;
      }
      break;
    }
  case 3:
    {
      //Check if game is restarting : Srijan 8th March 2015 
      if (game_over) {
        displayGameOver.remove(); 
        t.showTimer();
        game_over = false;}
          //scroll(0.05);
          //scroll(0);

        
      //Display Username: left
      //3/8/015: Bikram
      displayNameOnLeft.setVisible(true);
      displayGreetings.remove();
      displayNameOnLeft.setText(playerName);
      helpTextarea.remove();
      playButton.remove();
      //Display Timer on right
      //13/8/015: Bikram
      if (t.isTimeOver()==true)
        gameScreen = 4;
      else                   
        timerRight.setText(""+t.getTimerValue());
      //Show Game Level
      gl.showLevel();
      gl.display();


      // We must always step through time!
      box2d.step();

      background(255, 204, 153);
      image(sky, 0, 0);
      // Background scrolling with repetition , Parallax scrolling implemented : Srijan 10th March 2015
      for (int i=0; i<game_width; i+=width) {
        image(bg, x_bg + i, 0);
      }

      //Display platforms, floors, ceilings in the Array list : Srijan 3th March 2015
      for (Box b : platforms) {
        b.display();
      }
      for (Box b : floors) {
        b.display();
      }
      for (Box b : ceilings) {
        b.display();
      }
      // display enemies listed in ArrayList
      for (Enemy e: enemy) {
        e.display(); 
      }
      //ceiling1.display();

      // Draw the ball
      ball.display();
      //box.display();
      
      endbox.display();

      //Kill the ball if ball goes through hole in floors or ceiling : Srijan 5th March 2015
      if (ball.get_ball_pos("y") > height+16 || ball.get_ball_pos("y") < -16 || collission_with_enemy == true) {

        ball.done(); 
        ball = new Ball(width*0.1, height*0.4, 16);
        gameScreen = 4;
        // reset the shift value
        shift = 0;
        // create the floors, platforms, ceilings for new level
        scroll(0);
        // reset the background scroll value
       x_bg = 0;   
       //reset collision flag
       collission_with_enemy = false;
      }

      //Scrolling effect when the ball is moved : Srijan 8th March 2015
      current_pos = ball.get_ball_pos("x");
      
     
      if (old_pos != current_pos) {

        left_scroll_state = false;
        if (current_pos < 65) {
          println(x_bg);
          if (keyRight == true && keyUp == false) {
            ball.step(5, -10);
          } else if (keyRight == true && keyUp == true) {
            ball.step(5, 10);
          } else if (keyLeft == true && keyUp == false) {
            ball.step(-0.05, -10);
          } else if (keyLeft == true && keyUp == true && x_bg < 0.25) {
            ball.step(-0.05, 10);
          } else if (keyLeft == true && keyUp == true && x_bg >= 0) {
            println(x_bg);
            ball.step(-5, 10);
          } 

          left_scroll_state = true;
          if (old_pos > current_pos) {
            /* 
             monitoring background scrolling to disable scrolling left at level start
             :Srijan 11th March 2015
             */
            if (x_bg <=0) {
              //Calculate left displacement of the ball
              float left_displacement = old_pos - current_pos;
              if (left_displacement > 0.15) {
                scroll(fast_scroll);
                x_bg += 0.5;
              } else {
                scroll(slow_scroll);
                x_bg += 0.25;
              }
            }
          }
        }
        if(x_bg > -640) {
        right_scroll_state = false;
        if (current_pos >525) {
          if (keyLeft == true && keyUp == false) {
            ball.step(-5, -10);
          } else if (keyLeft == true && keyUp == true) {
            ball.step(-5, 10);
          } else if (keyRight == true && keyUp == false) {
            ball.step(0.05, -10);
          } else if (keyRight == true && keyUp == true) {
            ball.step(0.05, 10);
          }
          right_scroll_state = true;
          if (old_pos < current_pos) {
            /* 
             monitoring background scrolling to disable scrolling more that level width
             :Srijan 11th March 2015
             */
            if (x_bg >= -640 * 3) {
              //Calculating right displacement of the ball : Srijan 11th March 2015
              float right_displacement = current_pos - old_pos;
              if (right_displacement > 0.15) {
                scroll(-fast_scroll);
                x_bg -= 0.5;
              } else {
                scroll(-slow_scroll);
                x_bg -= 0.25;
              }
            }
            //Check for end of level : Srijan 11th March 2015
            print(x_bg);
            if (x_bg <=-630) {
              // Level up and Increase scroll speed
              level +=1;
              //fast_scroll +=1;
              //slow_scroll +=1;
              // Recreate the ball at the start for new level
              ball.done();
              ball = new Ball(width*0.1, height*0.4, 16);
              // reset the shift value
              shift = 0;
              // create the floors, platforms, ceilings for new level
              scroll(0);
              // reset the background scroll value
              x_bg = 0;
              /*
                                TODO: Show Level up screen , Currently game over screen is used
               :Srijan 11th March 2015
               */
              gameScreen = 4;
            }
          }
        }
        }
        old_pos = current_pos;
      }
    
      break;
    }
  case 4:
    {
      //Show Game over to user : Srijan 8th March 2015
      
      //scroll(-5);
      endscreen.display();
      displayGameOver.setText("GAME OVER, " + playerName);
      gameScreen = 1;

      // Reset Timer and Remove it; Bikram 14th March 015
      t.resetTimer();
      t.hideTimer();

      break;
    }
  default:
    {
    }
  }
}


/* 
  April 1st 2015 : Srijan
  Created destroy box function to destroy the box objects inthe box2d area
*/
boolean destroy_box(ArrayList<Box> boxobj){
 while(boxobj.size() > 0){
   for (int i=0; i<boxobj.size(); i++) {
      Box b = boxobj.get(i);
      //b.update();
      if (b.kill()) {
        boxobj.remove(i);
       }
    }
 }
return true; 
}

/* 
  April 13th 2015 : Srijan
  Created destroy box function to destroy the enemy objects in the box2d area
*/
boolean destroy_enemy(ArrayList<Enemy> enemyobj){
 while(enemyobj.size() > 0){
   for (int i=0; i<enemyobj.size(); i++) {
      Enemy e = enemyobj.get(i);
      //b.update();
      if (e.kill()) {
        enemyobj.remove(i);
       }
    }
 }
return true; 
}

//Scroll function to scroll the floor, ceilings and platforms : Srijan 5th March 2015
void scroll(float value) {
  shift += value;
  /*for (int i=0; i<platforms.size (); i++) {
    Box b = platforms.get(i);
    //b.update();
    if (b.kill()) {
      platforms.remove(i);
    }
  }*/
  // scrolling the enemies in the playarea
  endbox.kill();
  endbox = new Box(shift+3000, -10, 100, 1024);
  if(destroy_enemy(enemy)) {
    float enemy_gap = 0;
    for (float w=width; w<=game_width; w+=width) {
       enemy.add(new Enemy(shift+enemy_gap+width*0.1, height*0.25, 8));
       //enemy.add(new Enemy(shift+enemy_gap+width*0.3, height*0.45, 8));
       //enemy.add(new Enemy(shift+enemy_gap+width*0.5, height*0.65, 8));
       enemy_gap += 512;
    }
  }
  if(destroy_box(platforms)){
    float platform_gap = 0;
    for (float w=width; w<=game_width; w+=width) {
      platforms.add(new Box(shift+platform_gap + 3*w/4, height-150, width/2-50, 10));
      platforms.add(new Box(shift+platform_gap + w/4, height-250, width/2-50, 10));
      platforms.add(new Box(shift+platform_gap + 5*w/4, height-200, width/2-50, 10));
      platform_gap += width;
    }
  }
  
  /*for (int i=0; i<floors.size (); i++) {
    Box f = floors.get(i);
    //f.update();
    if (f.kill()) {
      floors.remove(i);
    }
  }
  for (int i=0; i<ceilings.size (); i++) {
    Box c = ceilings.get(i);
    //c.update();
    if (c.kill()) {
      ceilings.remove(i);
    }
  }*/
  if(destroy_box(floors)){
    float floor_gap = 0;
    for (float w=0; w<game_width; w+=width/2) {
      floors.add(new Box(shift+w+floor_gap, height-5, width/2, 10));
      floor_gap +=100;
      floor_width = w+floor_gap;
    if(floor_width >= game_width){
       break; 
    }
    }
  }
  if(destroy_box(ceilings)){
    float ceiling_gap = 0;
    for (float w=0; w<game_width; w+=width) {  
      ceilings.add(new Box(shift+w+ceiling_gap, 5, width, 10));
      ceiling_gap += 100;
      ceiling_width = w+ceiling_gap;
    if(ceiling_width >= game_width){
       break; 
    }
    }
  }
}

void keyPressed() {
  if (key == 'r' || key == 'R') {
      print("R pressed\n");
  }
  if (key == 'l' || key == 'L') {
    scroll(-0.5);
  }
  if (key == CODED) {
    if (keyCode == CONTROL) {
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
    if (keyCtrl == true && keyUp == true) {
      box2d.setGravity(0, 5); 
      //keyCtrl = false;
    } else if (keyCtrl == true && keyDown == true) {
      box2d.setGravity(0, -20);
      //keyCtrl = false;
    }
    else if (keyUp == true && keyRight == true) {
      if (left_scroll_state == true) {
        ball.step(0.1, 10);
      } else {
        ball.step(5, 10);
      }
    } else if (keyUp == true && keyLeft == true) {
      if (right_scroll_state == true && x_bg > -640) {
        ball.step(-0.1, 10);
      } else {
         ball.step(-5,10); 
      }
    } else if (keyUp == true && keyRight == false && keyLeft == false) {

      ball.step(0, 10);
    } else if (keyUp == false && keyRight == false && keyLeft == false) {

      ball.step(0, 0);
    }  else if (keyUp == true) {
      ball.step(0, 10);
      moveLeft = 0;
      moveRight = 0;
    }
    /*else if(keyDown == true && keyRight == true) {
     ball.step(5, -15); 
     }
     else if(keyDown == true && keyLeft == true) {
     ball.step(-5, -15);
     }*/
    else if (keyDown == true) {
      //ball.step(0, -30);
      moveLeft = 0;
      moveRight = 0;
    } else if (keyRight == true) {
      float y_mov = 0;
      if (ball.get_ball_pos("y") > 333.9) {
        y_mov = 0;
      } else {
        y_mov = 10;
      }
      if (left_scroll_state == true) {  
        ball.step(0.05 + moveRight, -y_mov);
        if (moveRight < 3 && moveRight < 4) {
          moveRight += 0.1;
        }
        moveLeft = 0;
      } else {
        ball.step(1 + moveRight, -y_mov);
        if (moveRight < 5 && moveRight < 4) {
          moveRight += 1;
        }
        moveLeft = 0;
      }
    } else if (keyLeft == true) {
      float y_mov = 0;
      if (ball.get_ball_pos("y") > 333.9) {
        y_mov = 0;
      } else {
        y_mov = 10;
      }
      if (right_scroll_state == true) {  
        ball.step(-0.05 + moveLeft, -y_mov);
        if (moveLeft > -5 && moveLeft > -6) {
          moveLeft -= 0.1;
        }
        moveRight = 0;
      } else {
        ball.step(-1 + moveLeft, -y_mov);
        if (moveLeft > -6 && moveLeft > -5) {
          moveLeft -= 1;
        }
        moveRight = 0;
      }
    }
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP) {
      keyUp = false;
    }
    if (keyCode == DOWN) {
      keyDown = false;
    }
    if (keyCode == RIGHT) {
      keyRight = false;
      //moveRight = 0;
    }
    if (keyCode == LEFT) {
      keyLeft = false;
      //moveLeft = 0;
    }
    if (keyCode == CONTROL) {
      keyCtrl = false;
      //moveLeft = 0;
    }
  }
}

//Play button click event
public void play() {
  playerName = targetField.getText();
  if (playerName!="") {
    gameScreen = 2;
  }
}

//OkPlay button click event
public void play_Game() {
  gameScreen = 3;
}


//Restart button 
public void restart() {
  displayNameOnLeft.setVisible(false);
  gl.hideLevel();
  bangButton.remove();
  game_over = true;
  gameScreen = 3;
}

/*
   * Collission event listener
   * Check if Ball collides with Enemy
   * If Ball collides with Enemy kill ball 
   * April 15 2015 : Srijan
   *
   */
void beginContact(Contact cp) {
  
  // Get both fixtures
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  // Get both bodies
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();

  // Get our objects that reference these bodies
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();

  if ((o1.getClass() == Ball.class && o2.getClass() == Enemy.class) ) {
      println("collided with enemy");
      collission_with_enemy = true;
  }
  else if ((o2.getClass() == Ball.class && o1.getClass() == Enemy.class)) {
    println("collided with enemy");
     collission_with_enemy = true;
    
  }
  /*
  else if ((o1.getClass() == Ball.class && o2.getClass() == Box.class) ) {
      println("collided with box");
  }
  else if ((o2.getClass() == Ball.class && o1.getClass() == Box.class)) {
    println("collided with box");
    
  }
  */

}
  

