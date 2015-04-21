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
import java.util.concurrent.TimeUnit;

// A reference to our box2d world
Box2DProcessing box2d;
PImage sky, nightsky, bg, startupImg, enemyOne, enemyTwo, levelup, shieldOne, powerOne, powerTwo;
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
ArrayList<Enemy2> enemy2;
int[] enemySize = {1,1,1,1,1,1,1,1,1,1};
int[] enemy2Size = {1,1,1,1,1,1,1,1,1,1};
Enemy acquired_enemy;
Enemy2 acquired_enemy2;
//boolean killed_enemy = false;

// shield object
ArrayList <Shield> shield1;
int[] shieldSize = {1,1,1,1,1};
Shield acquired_shield;
boolean got_shield = false;

// power up object
ArrayList <Power> heart;
int[] heartSize = {1,1};
Power acquired_power;
ArrayList <Power> coin;
int[] coinSize = {1,1,1,1,1,1,1,1,1,1};
//Power acquired_coin;

//float shield_move = 0.10;
//float addT = 0;
//float[] shield_pos = {-12.8, -7.8, -2.8};
//float shield_right = -0.10;


boolean collission_with_enemy = false;
boolean collission_with_shield = false;
boolean enemy_collide_with_shield = false;
boolean enemy2_collide_with_shield = false;
boolean collission_with_power = false;
//boolean collision_with_coin = false;


int hmove_count = 0;


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

// Player life
int life = 1;

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

float pad_top = 30;

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
  nightsky = loadImage("./images/nightsky.png");
  bg = loadImage("./images/mountain_trees.png");
  startupImg = loadImage("./images/1.jpg");
  enemyOne = loadImage("./images/enemy1.png");
  enemyTwo = loadImage("./images/enemy2.png");
  //enemyThree = loadImage("./images/enemy3.png");
  levelup = loadImage("./images/level.png");
  shieldOne = loadImage("./images/shield1.png");
  powerOne = loadImage("./images/heart.png");
  powerTwo = loadImage("./images/coin.png");
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
  enemy2 = new ArrayList<Enemy2>();
  
  
  // Create list of shields
  shield1 = new ArrayList<Shield>();
  
  // create list of power i.e coins and hearts
  heart = new ArrayList<Power>();
  coin = new ArrayList<Power>();

  //create a Ball with specified size and at given coordinates in screen
  ball = new Ball(width*0.1, height*0.4, 10);

  // endbox object
  endbox = new Box(3000, -10, 200, 600); 


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
    if (floor_width >= game_width) {
      break;
    }
  }
  //Create ceilings and adds to Arraylist : Srijan 3rd March 2015
  for (float w=0; w<game_width; w+=width) {  
    ceilings.add(new Box(w+ceiling_gap, pad_top + 5, width, 10));
    ceiling_gap += 100;
    //ceilings.add(new Box(0,5,width*2,10));
    ceiling_width = w+ceiling_gap;
    if (ceiling_width >= game_width) {
      break;
    }
  }
  //println("Ceilings", ceilings.size());
  //println("Floors", floors.size());

  // adding enemies to the playarea
  float enemy_gap = 0;
  for (float w=0; w<enemySize.length; w++) {
    enemy.add(new Enemy(enemy_gap+width*0.1, height*0.25, 8));
    //enemy.add(new Enemy(enemy_gap+width*0.3, height*0.45, 8));
    //enemy.add(new Enemy(enemy_gap+width*0.5, height*0.65, 8));
    enemy_gap += 512;
  }

  // adding enemy2 to the playarea
  create_enemy2_obj(enemy2, 0.93, 0.65);
  
  // adding shields to the playarea
  float shield_gap = 0;
  for (int w=0; w<shieldSize.length; w++) {
    if(shieldSize[w] == 1){
      if(w%2 == 0)
      {
        shield1.add(new Shield(shield_gap+width*0.3, height*0.20, 16));
      }
      else{
        shield1.add(new Shield(shield_gap+width*0.3, height*0.50, 16));
      }
      shield_gap += 440;
    }
  }
  
  // adding hearts and coins to the playarea , Srijan : 21st April 2015
  // HEARTS
  float heart_gap = 0;
  for (int w=0; w<heartSize.length; w++) {
    if(heartSize[w] == 1){
      heart.add(new Power(heart_gap+width*2, height*0.15, 8));
      heart_gap += 1200;
    }
  }
  // COINS
  float coin_gap = 0;
  for (int w=0; w<coinSize.length; w++) {
    if(coinSize[w] == 1){
      if(w%2 == 0)
      {
        coin.add(new Power(coin_gap+width*0.75, height*0.35, 8));
      }
      else{
        coin.add(new Power(coin_gap+width*0.75, height*0.75, 8));
      }
      coin_gap += 200;
    }
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
        game_over = false;
      }
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
      if (level == 0) {
        image(sky, 0, 0);
      } else if (level == 1) {
        image(nightsky, 0, 0);
      }
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
      //for (Enemy e : enemy) {
      //  e.display();
      //}
      for(int e=0; e<enemySize.length; e++){
         if(enemySize[e] == 1){
           enemy.get(e).display();
         } 
      }
      
      //display hearts
      for(int h=0; h<heartSize.length; h++){
         if(heartSize[h] == 1){
             heart.get(h).display("heart");
         } 
      }
      
      // display coin
      for(int c=0; c<coinSize.length; c++){
         if(coinSize[c] == 1){
             coin.get(c).display("coin");
         } 
      }
      
      //display shield
      //for(Shield s: shield1) {
      //     s.display();
      //}
      for(int shield=0; shield<shieldSize.length; shield++){
         if(shieldSize[shield] == 1){
             shield1.get(shield).display();
         } 
      }
      
      
      // display bouncing and crawling enemies
      for(int i=0; i<enemy2.size(); i++){
        if(enemy2Size[i] == 1){
          Enemy2 e = enemy2.get(i);
          e.display();
          if(i%2 == 0){//Bouncing enemy implementation
           if (e.get_enemy2_pos("y") >333) {
            e.bounce(10);
            //bounce_count++;
            }
            //else if(bounce_count > 100 && bounce_count <=400) {
            else if (e.get_enemy2_pos("y") < 250) {
              e.bounce(-10);
              //bounce_count++;
            } 
            //else {
            //  bounce_count = 0;
            //}
          }
          else { //Crawling enemy implementation
            if(hmove_count <=100){
              e.crawl(10);
              hmove_count++;
            }else if(hmove_count > 100 && hmove_count <= 200){
              e.crawl(-10);
              hmove_count++; 
            }else {
              hmove_count = 0; 
            }
          }
        }
      }
      
      //for (Enemy2 e : enemy2) {
      //  e.display(); 
        /*
         * Bouncing enemy 
         */

      /*  if (e.get_enemy2_pos("y") >333) {
          e.bounce(10);
          //bounce_count++;
        }
        //else if(bounce_count > 100 && bounce_count <=400) {
        else if (e.get_enemy2_pos("y") < 250) {
          e.bounce(-10);
          //bounce_count++;
        } 
        //else {
        //  bounce_count = 0;
        //}
      }*/
      //ceiling1.display();
      
      // Draw the ball
      if(got_shield){
        ball.display("shield");
      }else if(collission_with_enemy){
         ball.display("dead");
      }else {
         ball.display("normal"); 
      }
      //box.display();

      endbox.display();
      
      //Background for username and timer
      fill(50,50,50);
      rect(0, 0, game_width, 60);      
      
      // Kill the enemy if it collides with shielded ball
      if(enemy_collide_with_shield == true) {
         
         kill_enemy(acquired_enemy);
         enemy_collide_with_shield = false; 
      }
      
      if(enemy2_collide_with_shield == true) {
         
         kill_enemy2(acquired_enemy2);
         enemy2_collide_with_shield = false; 
      }
      

      //Kill the ball if ball goes through hole in floors or ceiling : Srijan 5th March 2015
      if (ball.get_ball_pos("y") > height + 16 || ball.get_ball_pos("y") < -16 + pad_top  || collission_with_enemy == true) {

        ball.done(); 
        ball = new Ball(width*0.1, height*0.4, 10);
        gameScreen = 4;
        // reset the shift value
        shift = 0;
        // create the floors, platforms, ceilings for new level
        scroll(0);
        // reset the background scroll value
        x_bg = 0;   
        //reset enemies and shields to initial position
        destroy_enemy(enemy);
        destroy_enemy2(enemy2);
        destroy_shield(shield1);
        //reset level to zero
        if(life > 0){
          life--;
        }
        else {
          level = 0;
        }
        //reset collision flag
        collission_with_enemy = false;
      }
      
      // Hiding the acquired shield
      if( collission_with_shield == true) {
         get_shield(acquired_shield);
         collission_with_shield = false; 
      }
      
      // Hiding the acquired heart
      if( collission_with_power == true) {
        if(heart.contains(acquired_power)){
           get_heart(acquired_power);
        }
        else if(coin.contains(acquired_power)){
           get_coin(acquired_power); 
        }
         collission_with_power = false; 
      }
      
      // Hiding the acquired coin
      //if( collission_with_coin == true) {
      //   get_coin(acquired_coin);
      //   collission_with_coin = false; 
      //}

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
        if (x_bg > -640) {
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
              //print(x_bg);
              if (x_bg <=-610) {
                // Level up and Increase scroll speed
                level +=1;
                //fast_scroll +=1;
                //slow_scroll +=1;
                // Recreate the ball at the start for new level
                ball.done();
                ball = new Ball(width*0.1, height*0.4, 10);
                // reset the shift value
                shift = 0;
                // create the floors, platforms, ceilings for new level
                scroll(0);
                // reset the background scroll value
                x_bg = 0;
               
                // TODO: Currently resetting when level up
                //  Need to set different placement in the playarea for different level
                // reset shieldSize array
                for(int shield=0; shield<shieldSize.length; shield++) {
                    shieldSize[shield] = 1;
                }  
                // reset heartSize array
                for(int h=0; h<heartSize.length; h++) {
                    heartSize[h] = 1;
                } 
                // reset coinSize array
                for(int c=0; c<coinSize.length; c++) {
                    coinSize[c] = 1;
                } 
                // reset enemy positions
                for(int e=0; e<enemySize.length; e++) {
                    enemySize[e] = 1;
                } 
                for(int e2=0; e2<enemy2Size.length; e2++) {
                    enemy2Size[e2] = 1;
                }  
                //reset enemies and shields to initial position
                destroy_enemy(enemy);
                destroy_enemy2(enemy2);
                destroy_shield(shield1);
                destroy_power(heart);
                destroy_power(coin);
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
 * TODO: make Use of this function for other enemy objects and shield object
 * Enemy2 object create
 * April 15 2015 : Srijan
 *
 */
void create_enemy2_obj(ArrayList<Enemy2> enemy2, float vshift, float hshift) {
  float enemy2_gap = 0;
  for (float w=0; w<enemy2Size.length; w++) {
    enemy2.add(new Enemy2(enemy2_gap+width*hshift, height*vshift, 13));
    enemy2_gap += 512;
  }
}



/* 
 April 1st 2015 : Srijan
 Created destroy box function to destroy the box objects inthe box2d area
 */
boolean destroy_box(ArrayList<Box> boxobj) {
  while (boxobj.size () > 0) {
    for (int i=0; i<boxobj.size (); i++) {
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
void destroy_enemy(ArrayList<Enemy> enemyobj) {
  while (enemyobj.size () > 0) {
    for (int i=0; i<enemyobj.size (); i++) {
      Enemy e = enemyobj.get(i);
      //b.update();
      if (e.kill()) {
        enemyobj.remove(i);
      }
    }
  }
 // if (destroy_enemy(enemy)) {
    float enemy_gap = 0;
    for (float w=0; w<enemySize.length; w++) {
      enemy.add(new Enemy(enemy_gap+width*0.1, height*0.25, 8));
      enemy_gap += 512;
    }
  //return true;
}

float enemy2_xpos = 0;
float enemy2_ypos = 0;

// destroys enemy2 arraylist in playarea
void destroy_enemy2(ArrayList<Enemy2> enemyobj) {
  while (enemyobj.size () > 0) {
    for (int i=0; i<enemyobj.size (); i++) {
      Enemy2 e = enemyobj.get(i);
      enemy2_xpos = e.get_enemy2_pos("x");
      enemy2_ypos = e.get_enemy2_pos("y");
      //b.update();
      if (e.kill()) {
        enemyobj.remove(i);
      }
    }
  }
  float enemy2_gap = 0;
    for (float w=0; w<enemy2Size.length; w++) {
      enemy2.add(new Enemy2(enemy2_gap+width*0.65, height*0.93, 13));
      enemy2_gap += 512;
    }
  //return true;
}

// destroys shields  arrraylist in playarea
void destroy_shield(ArrayList<Shield> shieldobj) {
  while (shieldobj.size () > 0) {
    for (int i=0; i<shieldobj.size (); i++) {
      Shield s = shieldobj.get(i);
      //b.update();
        if (s.kill()) {
          shieldobj.remove(i);
        }
      }
  }
    float shield_gap = 0;
    for (int w=0; w<shieldSize.length; w++) {
        if(w%2==0){
          shield1.add(new Shield(shield_gap+width*0.3, height*0.2, 16));
        }
        else{
          shield1.add(new Shield(shield_gap+width*0.3, height*0.50, 16));
      }
        shield_gap += 440;
    }
}

// destroys powerups , Srijan : 21st April 2015
void destroy_power(ArrayList<Power> powerobj) {
  while (powerobj.size () > 0) {
    for (int i=0; i<powerobj.size (); i++) {
      Power p = powerobj.get(i);
      //b.update();
        if (p.kill()) {
          powerobj.remove(i);
        }
      }
  }
  if(powerobj == heart){
    float heart_gap = 0;
    for (int w=0; w<heartSize.length; w++) {
      heart.add(new Power(heart_gap+width*2, height*0.15, 8));
      heart_gap += 1200;
    }
  }
  else{
    float coin_gap = 0;
    for (int w=0; w<coinSize.length; w++) {
        if(w%2==0){
          coin.add(new Power(coin_gap+width*0.75, height*0.35, 8));
        }
        else{
          coin.add(new Power(coin_gap+width*0.75, height*0.75, 8));
      }
        coin_gap += 200;
    }
  }
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
  endbox = new Box(shift+3000, -10, 200, 600);
  
  
  /* Commented out this code as it is used as separate function
   *
  if (destroy_enemy(enemy)) {
    float enemy_gap = 0;
    for (float w=width; w<=game_width; w+=width) {
      enemy.add(new Enemy(shift+enemy_gap+width*0.1, height*0.25, 8));
      //enemy.add(new Enemy(shift+enemy_gap+width*0.3, height*0.45, 8));
      //enemy.add(new Enemy(shift+enemy_gap+width*0.5, height*0.65, 8));
      enemy_gap += 512;
    }
  }*/
  /*if (destroy_enemy2(enemy2)) {
    float enemy2_gap = 0;
    for (float w=width; w<=game_width; w+=width) {
      //enemy2.add(new Enemy2(shift+enemy2_gap+width*0.65, enemy2_ypos, 13));
      enemy2.add(new Enemy2(shift+enemy2_gap+width*0.65, height*0.93, 13));
      //enemy.add(new Enemy(shift+enemy_gap+width*0.3, height*0.45, 8));
      //enemy.add(new Enemy(shift+enemy_gap+width*0.5, height*0.65, 8));
      enemy2_gap += 512;
    }
  }*/
  
  /*float shieldSize = shield1.size();
  if (destroy_shield(shield1)) {
    float shield_gap = 0;
    for (int w=0; w<shieldSize; w++) {
        shield1.add(new Shield(shift+shield_gap+width*0.3, height*0.2, 16));
        shield_gap +=20;
    }
  }*/
  
  // TODO: make scroll_object functions which can be used by all the scrolling objects in playarea
  // Currently for loop used for individual object
  int i=0;
  for(i=0; i<enemy.size(); i++) {
   if(left_scroll_state == true){
    enemy.get(i).shiftBody("l");
   } 
   else if(right_scroll_state == true) {
     enemy.get(i).shiftBody("r");
   }
  }
  
  
  for(i=0; i<enemy2.size(); i++) {
   if(left_scroll_state == true){
    enemy2.get(i).shiftBody("l");
   } 
   else if(right_scroll_state == true) {
     enemy2.get(i).shiftBody("r");
   }
  }
  
   for(i=0; i<shield1.size(); i++){
    if(left_scroll_state == true){ 
     shield1.get(i).shiftBody("l");
     }
     else if(right_scroll_state == true) {
     shield1.get(i).shiftBody("r");
     } 
   }
   
   for(i=0; i<heart.size(); i++){
    if(left_scroll_state == true){ 
     heart.get(i).shiftBody("l");
     }
     else if(right_scroll_state == true) {
     heart.get(i).shiftBody("r");
     } 
   }
   
   for(i=0; i<coin.size(); i++){
    if(left_scroll_state == true){ 
     coin.get(i).shiftBody("l");
     }
     else if(right_scroll_state == true) {
     coin.get(i).shiftBody("r");
     } 
   }
  
  
  if (destroy_box(platforms)) {
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
  if (destroy_box(floors)) {
    float floor_gap = 0;
    for (float w=0; w<game_width; w+=width/2) {
      floors.add(new Box(shift+w+floor_gap, height-5, width/2, 10));
      floor_gap +=100;
      floor_width = w+floor_gap;
      if (floor_width >= game_width) {
        break;
      }
    }
  }
  
  if (destroy_box(ceilings)) {
    float ceiling_gap = 0;
    for (float w=0; w<game_width; w+=width) {  
      ceilings.add(new Box(shift+w+ceiling_gap, pad_top + 5, width, 10));
      ceiling_gap += 100;
      ceiling_width = w+ceiling_gap;
      if (ceiling_width >= game_width) {
        break;
      }
    }
  }
}

//float addT = 0;
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
    } else if (keyUp == true && keyRight == true) {
      if (left_scroll_state == true) {
        ball.step(0.1, 10);
      } else {
        ball.step(5, 10);
      }
    } else if (keyUp == true && keyLeft == true) {
      if (right_scroll_state == true && x_bg > -640) {
        ball.step(-0.1, 10);
      } else {
        ball.step(-5, 10);
      }
    } else if (keyUp == true && keyRight == false && keyLeft == false) {

      ball.step(0, 10);
    } else if (keyUp == false && keyRight == false && keyLeft == false) {

      ball.step(0, 0);
    } else if (keyUp == true) {
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

// acquires the shield object that collides with ball 
boolean get_shield(Shield s) {
    for (int i=0; i<shieldSize.length; i++) {
      if (shield1.get(i) == s) {
        println("shield removed from playarea");
        s.kill();
        //if (s.kill()) {
        //  shield1.remove(i);
        //}
        shieldSize[i] = 0;
        got_shield = true;
        
      }
    }
    return true;
}

// acquires the heart that collides with shielded ball , Srijan : 21st April 2015 
boolean get_heart(Power p) {
    for (int i=0; i<heartSize.length; i++) {
      if (heart.get(i) == p) {
        println("heart removed from playarea");
        p.kill();
        //if (s.kill()) {
        //  shield1.remove(i);
        //}
        heartSize[i] = 0;
        //got_shield = true;
        
      }
    }
    return true;
}

// acquires the coin that collides with shielded ball, Srijan : 21st April 2015
boolean get_coin(Power p) {
    for (int i=0; i<coinSize.length; i++) {
      if (coin.get(i) == p) {
        println("coin removed from playarea");
        p.kill();
        //if (s.kill()) {
        //  shield1.remove(i);
        //}
        coinSize[i] = 0;
        //got_shield = true;
        
      }
    }
    return true;
}

// kill the enemy that collides with shielded ball
boolean kill_enemy(Enemy e) {
    for (int i=0; i<enemySize.length; i++) {
      if (enemy.get(i) == e) {
        println("enemy removed from playarea");
        e.kill();
        enemySize[i] = 0;
        //killed_enemy = true;
        
      }
    }
    return true;
}

// kill the enemy2 that collides with shielded ball
boolean kill_enemy2(Enemy2 e) {
    for (int i=0; i<enemy2Size.length; i++) {
      if (enemy2.get(i) == e) {
        println("enemy removed from playarea");
        e.kill();
        enemy2Size[i] = 0;
        //killed_enemy = true;
        
      }
    }
    return true;
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

/* Srijan : 21st April 2015
 *
 * Commented out this code as I addes setUserdata for surfaces as well 
 * Now there is no exception when ball hits surfaces
 *
*/
//<<<<<<< Updated upstream
//  if (o1 != null && o2 != null) {
//    if ((o1.getClass() == Ball.class && (o2.getClass() == Enemy.class || o2.getClass() == Enemy2.class) )) {
//      println("collided with enemy");
//      collission_with_enemy = true;
//    } else if ((o2.getClass() == Ball.class && (o1.getClass() == Enemy.class || o1.getClass() == Enemy2.class))) {
//      println("collided with enemy");
//      collission_with_enemy = true;
//    }
//=======

// Check if the Ball hits other objects in the playarea
  if ((o1.getClass() == Ball.class && (o2.getClass() == Enemy.class || o2.getClass() == Enemy2.class) )) {
    println("collided with enemy");
    if(got_shield == false){
      collission_with_enemy = true;
    }else {
      if(o2.getClass() == Enemy.class){
        acquired_enemy = (Enemy) o2;
        enemy_collide_with_shield = true; 
      }
      else{
        acquired_enemy2 = (Enemy2) o2;
        enemy2_collide_with_shield = true;  
      }
      //enemy_collide_with_shield = true; 
    }
  } else if ((o2.getClass() == Ball.class && (o1.getClass() == Enemy.class || o1.getClass() == Enemy2.class))) {
    println("collided with enemy");
    if(got_shield == false){
      collission_with_enemy = true;
    }else {
      if(o1.getClass() == Enemy.class){
        acquired_enemy = (Enemy) o1;
        enemy_collide_with_shield = true; 
      }
      else{
        acquired_enemy2 = (Enemy2) o1;
        enemy2_collide_with_shield = true;  
      }
      //enemy_collide_with_shield = true; 
    }
  } else if (o1.getClass() == Ball.class && o2.getClass() == Shield.class) { // Checks if the ball hits the shield object
    println("collided with shield");
    acquired_shield = (Shield) o2;
    //get_shield(s);
    collission_with_shield = true;
  } else if (o2.getClass() == Ball.class && o1.getClass() == Shield.class) {
    println("collided with shield");
    Shield s = (Shield) o1;
    //get_shield(s);
    acquired_shield = s;
    collission_with_shield = true;
  } else if (o1.getClass() == Ball.class && o2.getClass() == Power.class) { // Checks if ball hits the power ups , Srijan : 21st April 2015
    println("collided with power");
    acquired_power = (Power) o2;
    //get_shield(s);
    collission_with_power = true;
  } else if (o2.getClass() == Ball.class && o1.getClass() == Power.class) {
    println("collided with power");
    Power p = (Power) o1;
    //get_shield(s);
    acquired_power = p;
    collission_with_power = true;
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

void endContact(Contact cp) {
}
