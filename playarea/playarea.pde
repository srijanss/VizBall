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
//import java.util.concurrent.TimeUnit;
import ddf.minim.*;
// For background audio 
AudioPlayer player, shootSound, coinCollectedSound, weaponCollected, GameEnd, heartCollected, enemyKilled, shieldCollected;
Minim minim1, minim2, minim3, minim4, minim5, minim6, minim7, minim8;//audio context


// A reference to our box2d world
Box2DProcessing box2d;
PImage sky, nightsky, bg, startupImg, enemyOne, enemyTwo, levelup, shieldOne, powerOne, powerTwo, scoreBoardBg, shieldOnesmall, gunmedium, gunsmall, lasermedium, lasersmall, ammomedium, ammosmall;
int gameScreen, isHelpDisplayed, isEndScreenDisplayed, gameStartupCount;
//ControlP5 Library used
// 2nd March: Bikram: Added startup of Name Inquiry and greetings Screen.
ControlP5 cp5;
Textfield targetField;
Textlabel displayGreetings = null;
Textlabel displayNameOnLeft, displayGameOver, timerRight, gameLevel, displayCoinsOnRight, displayShieldOnRight, displayLifeOnRight, displayScoreOnRight;
Textlabel coins_collected, shield_collected, enemies_killed, plyr_Name, total_points, highest_points, game_Lvl, life_collected;

Textarea helpTextarea = null;
String playerName, _reasonOfGameOver;
int _gamelvl, _coinsCollected, _shieldCollected, _enemiesKilled, _totalScore, _highestScore, _lifeCollected;
Button checkNameButton = null;
Button playButton = null;
Button restartButton = null;
Button quitButton = null;
//Array list to hold box objects for floors, ceilings and platforms
ArrayList<Box> platforms;
ArrayList<Box> ceilings;
ArrayList<Box> floors;
boolean box_destroyed = false;

//endbox at the end of each level
Box endbox;

// enemy object
ArrayList<Enemy> enemy;
ArrayList<Enemy2> enemy2;
int[] enemySize = {1,1,1,1,1};
int[] enemy2Size = {1,1,1,1,1};
Enemy acquired_enemy;
Enemy2 acquired_enemy2;
//boolean killed_enemy = false;

// shield object
ArrayList <Shield> shield1;
int[] shieldSize = {1,1};
Shield acquired_shield;
boolean got_shield = false;

// power up object
ArrayList <Power> heart;
int[] heartSize = {1,1};
Power acquired_power;
ArrayList <Power> coin;
int[] coinSize = {1,1,1,1,1,1,1,1,1,1};

// weapons object
ArrayList <Weapon> gun;
int[] gunSize = {1};
Weapon acquired_weapon;
ArrayList <Weapon> laser;
int[] laserSize = {1};
ArrayList <Weapon> ammo;
int[] ammoSize = {1,1};
boolean got_gun = false;
boolean got_laser = false;
boolean got_ammo = false;

// bullets
ArrayList <Bullet> gunbullet;
int total_gunbullet = 5;
int remaining_gunbullet = total_gunbullet;
int fired_gunbullet = 0;
int[] gunbulletSize = {2,2,2,2,2}; // Unsed state , Used state will be {0,0,0,0,0} and full state will be {1,1,1,1,1}
Bullet used_bullet;
//ArrayList <Bullet> laserbullet;
//int[] laserbulletSize = {1,1,1,1,1};

//laser bullets
ArrayList <LaserBullet> laserbullet;
int total_laserbullet = 5;
int remaining_laserbullet = total_laserbullet;
int fired_laserbullet = 0;
int[] laserbulletSize = {2,2,2,2,2};
LaserBullet used_laser_bullet;


boolean collission_with_enemy = false;
boolean collission_with_shield = false;
boolean enemy_collide_with_shield = false;
boolean enemy2_collide_with_shield = false;
boolean collission_with_power = false;
boolean collission_with_weapon = false;
boolean collission_with_bullet = false;
boolean enemy_collide_with_bullet = false;
boolean enemy2_collide_with_bullet = false;
boolean collission_with_laser = false;
boolean enemy_collide_with_laser = false;
boolean enemy2_collide_with_laser= false;


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

// Scoreboard data
int collected_coins = 0;
int collected_heart = 0;
int collected_shield = 0;
int enemy_killed = 0;


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
    //levelup = loadImage("./images/level.png");
    shieldOne = loadImage("./images/shield1.png");
    powerOne = loadImage("./images/heart.png");
    powerTwo = loadImage("./images/coin.png");
    //scoreBoardBg = loadImage("./images/scoreboard.png");
    shieldOnesmall = loadImage("./images/shield_small.png");
    gunmedium = loadImage("./images/gun_medium.png");
    gunsmall = loadImage("./images/gun_small.png");
    lasermedium = loadImage("./images/laser_medium.png");
    lasersmall = loadImage("./images/laser_gun.png");
    ammomedium = loadImage("./images/ammo_medium.png");
    ammosmall = loadImage("./images/ammo_icon.png");
    smooth();


    cp5 = new ControlP5(this);
    s = new StartUpScreen();
    endscreen = new EndScreen();
    t  =  new Timer();
    
    // Plyaer object - BIkram 10/05/015
    minim1 = new Minim(this);
    player = minim1.loadFile("./media/bg.mp3");
    minim2 = new Minim(this);
    shootSound = minim2.loadFile("media/shoot.mp3");
    minim3 = new Minim(this);
    coinCollectedSound = minim3.loadFile("media/colectCoin.mp3");  
    minim4 = new Minim(this);
    weaponCollected = minim4.loadFile("media/collectweapon.mp3");
    minim5 = new Minim(this);
    GameEnd = minim5.loadFile("media/GameEnd.mp3");
    minim6 = new Minim(this);
    heartCollected = minim6.loadFile("media/heartCollected.mp3");
    minim7 = new Minim(this);
    enemyKilled = minim7.loadFile("media/destroyed.mp3");
    minim8 = new Minim(this);
    shieldCollected = minim8.loadFile("media/shieldCollected.mp3");
    s.display();
    gameScreen = 1;
    gameStartupCount = 5;
    //Check if if help is displayed
    isHelpDisplayed = 0;
    isEndScreenDisplayed = 0;
    t.initializeTimer();
    // Initiliaze Game level
    gl = new GameLevel(level);

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

    // create list of weapons
    gun = new ArrayList<Weapon>();
    laser = new ArrayList<Weapon>();
    ammo = new ArrayList<Weapon>();

    // create list of bullets
    gunbullet = new ArrayList<Bullet>();
    laserbullet = new ArrayList<LaserBullet>();

    //create a Ball with specified size and at given coordinates in screen
    ball = new Ball(width*0.1, height*0.4, 10);

    // endbox object
    create_endbox(0);

    // Function that creates Floors, Ceilings and Platforms
    create_boxes(0);

    // Function that creates Standing Enemy in playarea
    create_enemy_obj();

    // adding enemy2 to the playarea
    create_enemy2_obj();

    // adding shields in playarea
    create_shield_obj();

    // adding hearts in playarea
    create_heart();

    // adding coins in playarea
    create_coin();

    // adding guns
    create_gun();

    //adding lasers
    create_laser();

    //adding ammos
    create_ammo();


    //Commented out the vertical surface : Srijan 7th March 2015
    // Create the surface
    verticalSurface = new Surface(0, 640, -10, 0);
    verticalSurfaceRight = new Surface(0, 640, -10, 1);
    
    // set lifeCollected equals to life
    _lifeCollected = life;
}

void create_endbox(float shift){
  endbox = new Box(shift+2800, -10, 200, 600);
} 

// created separate function to create floors, ceilings and platforms
void create_boxes(float shift){
   create_platforms(shift);
   create_floors(shift);
   create_ceilings(shift); 
}

void create_platforms(float shift) {
    //gap that defines the platforms to occur after the screen width : Srijan 3rd March 2015
    float platform_gap = 0;
    //platforms.add(new Box(320, 150, width/2-50, 10));
    //Creating new platforms and adding to ArrayList : Srijan 3rd March 2015
    for (float w=width; w<=game_width; w+=width) {
        //float platform_x_pos = random(3,5);
        //float platform_y_pos = random(10,20);

        if(level == 0){
            platforms.add(new Box(shift+platform_gap + 3*w/4, height-150, width/2-50, 10));
            platforms.add(new Box(shift+platform_gap + w/4, height-250, width/2-50, 10));
            platforms.add(new Box(shift+platform_gap + 5*w/4, height-200, width/2-50, 10));
        }
        else if(level == 1) {
            platforms.add(new Box(shift+platform_gap + 3*w/4, height-150, width/2-50, 10));
            platforms.add(new Box(shift+platform_gap + w/4 + 100, height-250, 10, width/2-50));
            platforms.add(new Box(shift+platform_gap + 5*w/4, height-200, width/2-50, 10));
        }
        else if (level > 1) {
            platforms.add(new Box(shift+platform_gap + 3*w/4 + 100, height-150, 10, width/2-50));
            platforms.add(new Box(shift+platform_gap + w/4, height-250, width/2-50, 10));
            platforms.add(new Box(shift+platform_gap + 5*w/4 +100, height-200, 10, width/2-50)); 
        }

        platform_gap += width;
    }
}

void create_floors(float shift) {
    //Defines the gap between the floors : Srijan 3rd March 2015
    float floor_gap = 0;
    //Create floors and adds to Arraylist : Srijan 3rd March 2015
    float floor_width = 0;
    //for (float w=0; w<game_width; w+=width/2) {
    for (float w=0; w<game_width; w+=width/2) {
        floors.add(new Box(shift+w+floor_gap, height-5, width/2, 10));
        floor_gap +=100;
        floor_width = w+floor_gap;
        if (floor_width >= game_width) {
            break;
        }
    }
}

void create_ceilings(float shift) {
      //Defines the gap between the ceilings : Srijan 3rd March 2015
      float ceiling_gap = 0;
      float ceiling_width = 0;
      //Create ceilings and adds to Arraylist : Srijan 3rd March 2015
      for (float w=0; w<game_width; w+=width) {  
        ceilings.add(new Box(shift+w+ceiling_gap, pad_top + 5, width, 10));
        ceiling_gap += 100;
        ceiling_width = w+ceiling_gap;
        if (ceiling_width >= game_width) {
            break;
        }
    }
}

// Creates Enemy Object in Playarea
void create_enemy_obj() {
    // adding enemies to the playarea
    float enemy_gap = 0;
    for (int w=0; w<enemySize.length; w++) {
        if(level == 0){
            enemy.add(new Enemy(enemy_gap+width*0.5, height*0.25, 8));
        }
        else if(level == 1) {
            enemy.add(new Enemy(enemy_gap+width*0.4, height*0.35, 8)); 
        }
        else if (level > 1) {
            enemy.add(new Enemy(enemy_gap+width*0.6, height*0.45, 8)); 
        }
        //enemy.add(new Enemy(enemy_gap+width*0.3, height*0.45, 8));
        //enemy.add(new Enemy(enemy_gap+width*0.5, height*0.65, 8));
        enemy_gap += 512;
        if(enemySize[w] == 0){
            enemy.get(w).kill();   
        }
    } 

}

/*
 * TODO: make Use of this function for other enemy objects and shield object
 * Enemy2 object create
 * April 15 2015 : Srijan
 *
 */
void create_enemy2_obj() {
    float enemy2_gap = 0;
    for (int w=0; w<enemy2Size.length; w++) {
        if(level == 0){
            enemy2.add(new Enemy2(enemy2_gap+width*0.65, height*0.93, 13));
        }
        else if(level > 0) {
            enemy2.add(new Enemy2(enemy2_gap+width*0.35, height*0.93, 13));
        }
        enemy2_gap += 512;
        if(enemy2Size[w] == 0){
            enemy2.get(w).kill();   
        }
    }

}

void create_shield_obj() {
    // adding shields to the playarea
    float shield_gap = 0;
    for (int w=0; w<shieldSize.length; w++) {
        //    if(shieldSize[w] == 1){
        if(w%2 == 0)
        {
            shield1.add(new Shield(shield_gap+width*1.5, height*0.20, 16));
        }
        else{
            shield1.add(new Shield(shield_gap+width*1.5, height*0.50, 16));
        }
        shield_gap += 640;
        if(shieldSize[w] == 0) {
            shield1.get(w).kill();
        }
    }
    //} 

}

void create_heart() {
    // adding hearts and coins to the playarea , Srijan : 21st April 2015
    // HEARTS
    float heart_gap = 0;
    for (int w=0; w<heartSize.length; w++) {
        //if(heartSize[w] == 1){
        heart.add(new Power(heart_gap+width*2, height*0.15, 8));
        heart_gap += 1200;
        //}
        if(heartSize[w] == 0) {
            heart.get(w).kill();
        }
    } 

}

void create_coin() {
    // COINS
    float coin_gap = 0;
    for (int w=0; w<coinSize.length; w++) {
        //if(coinSize[w] == 1){
        if(w%2 == 0)
        {
            coin.add(new Power(coin_gap+width*0.75, height*0.35, 8));
        }
        else{
            coin.add(new Power(coin_gap+width*0.75, height*0.75, 8));
        }
        coin_gap += 200;
        //}
        if(coinSize[w] == 0) {
            coin.get(w).kill();
        }
    }

}

// GUNS
void create_gun() {
    // adding guns, lasers and ammos to the playarea , Srijan : 22nd April 2015
    float gun_gap = 0;
    for (int w=0; w<gunSize.length; w++) {
        //if(gunSize[w] == 1){
        gun.add(new Weapon(gun_gap+width*0.43, height*0.53, 13));
        gun_gap += 1200;
        //}
        if(gunSize[w] == 0) {
            gun.get(w).kill();
        }
    } 

}

// LASERS
void create_laser() {
    float laser_gap = 0;
    for (int w=0; w<laserSize.length; w++) {
        //if(laserSize[w] == 1){
        laser.add(new Weapon(laser_gap+width*1.43, height*0.53, 15));
        laser_gap += 1200;
        //}
        if(laserSize[w] == 0) {
            laser.get(w).kill();
        }
    } 

}

// AMMOS Pack
void create_ammo() {
    float ammo_gap = 0;
    for (int w=0; w<ammoSize.length; w++) {
        //if(ammoSize[w] == 1){
        ammo.add(new Weapon(ammo_gap+width*2.5, height*0.53, 14));
        ammo_gap += 1200;
        //}
        if(ammoSize[w] == 0) {
            ammo.get(w).kill();
        }
    } 


}

// Bullets
void create_bullet(float x_pos, float y_pos) {
    gunbullet.add(new Bullet(x_pos, y_pos, 8));
    play_shootSound();
}

//Laser bullet
void create_laserbullet(float x_pos, float y_pos) {
    laserbullet.add(new LaserBullet(x_pos, y_pos, 30,2));
    play_shootSound();
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
                s.displayGreetings();
                displayGreetings.setText("Welcome " + playerName); 
                background(startupImg);


                if (isHelpDisplayed == 0) {
                    isHelpDisplayed = 1;
                    /* Removing GUI */
                    targetField.remove();
                    s.displayHelp();
                    gameScreen = 2;
                    
                }
                break;
            }
        case 3:
            {
                //Play audio - Bikram 
                player.play();
                //Check if game is restarting : Srijan 8th March 2015 
                if (game_over) {
                    endscreen.resetScoreBoard();
                    endscreen.hideScoreBoard();
                    t.showTimer();
                    _lifeCollected = 1;
                    game_over = false;
                }
                //scroll(0.05);
                //scroll(0);
                //Update score on top 
                 s.updateScoresOnTop(_coinsCollected, _lifeCollected, _shieldCollected, _totalScore);
                 s.showScoreOnTop();
                //Display Username: left
                //3/8/015: Bikram
                displayNameOnLeft.setVisible(true);
                s.hideGreetings();
                displayNameOnLeft.setText(playerName);
                
                s.hideHelp();
                //Display Timer on right
                //13/8/015: Bikram
                if (t.isTimeOver()==true){
                    if(life > 0){
                       life--; 
                       _lifeCollected = life;
                    }
                    t.resetTimer();
                    _reasonOfGameOver = "timeout";  
                                      // Reset objects on timeout
                                      ball.done();
                                      ball = new Ball(width*0.1, height*0.4, 10);
                                      // reset the shift value
                                      shift = 0;
                                      // create the floors, platforms, ceilings for new level
                                      scroll(0);
                                      // reset the background scroll value
                                      x_bg = 0;
                                      // reset got_shield flag
                                      got_shield = false;
                                      // reset got_gun flag
                                      got_gun = false;
                                      got_laser = false;
                                      got_ammo = false;

                                     
                                    //reset enemies and shields to initial position
                                      destroy_floors();
                                      destroy_platforms();
                                      destroy_ceilings();
                                      destroy_endbox();
                                      destroy_enemy(enemy, true);
                                      destroy_enemy2(enemy2, true);
                                      destroy_shield(shield1, true);
                                      destroy_power(heart, true);
                                      destroy_power(coin, true);
                                      destroy_weapon(gun, true);
                                      destroy_weapon(laser, true);
                                      destroy_weapon(ammo, true);
                    if(life <= 0){
                    gameScreen = 4;
                    }
                                      
                    
                    
                }
                else                   
                    timerRight.setText(""+t.getTimerValue());
                //Show Game Level
                _totalScore = _coinsCollected * 100 + _enemiesKilled * 10;

                gl.showLevel();
                gl.display();


                // We must always step through time!
                box2d.step();

                background(255, 204, 153);
                if (level == 0) {
                    image(sky, 0, 0);
                } 
                else if (level == 1) {
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
                        //println("index " + c + "element " + coinSize[c]);
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

                //display guns
                for(int g=0; g<gunSize.length; g++){
                    if(gunSize[g] == 1){
                        gun.get(g).display("gun");
                    } 
                }

                //display lasers
                for(int l=0; l<laserSize.length; l++){
                    if(laserSize[l] == 1){
                        laser.get(l).display("laser");
                    } 
                }

                //display ammos
                for(int a=0; a<ammoSize.length; a++){
                    if(ammoSize[a] == 1){
                        ammo.get(a).display("ammo");
                    } 
                }

                // display moving bullets
                if(fired_gunbullet != 0 ) {
                    for(int gb=0; gb<fired_gunbullet; gb++){
                        if(gunbulletSize[gb] == 1){ 
                            gunbullet.get(gb).display();
                            gunbullet.get(gb).shiftBody("l");
                        }
                        if(gunbulletSize[gb] == -1) {
                            gunbullet.get(gb).display();
                            gunbullet.get(gb).shiftBody("r");
                        }

                    } 
                }
                
                // display moving bullets
                if(fired_laserbullet != 0 ) {
                    for(int gb=0; gb<fired_laserbullet; gb++){
                        if(laserbulletSize[gb] == 1){ 
                            laserbullet.get(gb).display();
                            laserbullet.get(gb).shiftBody("l");
                        }
                        if(laserbulletSize[gb] == -1) {
                            laserbullet.get(gb).display();
                            laserbullet.get(gb).shiftBody("r");
                        }

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
                            }
                            else if (e.get_enemy2_pos("y") < 250) {
                                e.bounce(-10);
                            } 
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
                rect(0, 400, game_width, 60);   
               
               // images on the top bar
                image(powerOne, 0, -69);
                image(powerTwo, 60, -105); 
                if(got_shield){
                    image(shieldOnesmall, 270, -81); 
                }
                if(got_gun) {
                   image(gunsmall, 485, 4);
                   if(remaining_gunbullet != 0){
                    got_ammo = true;
                   } 
                   else { got_ammo = false; }
                }
                 if(got_laser) {
                   image(lasersmall, 515, 4);
                   if(remaining_laserbullet != 0){
                    got_ammo = true;
                   } 
                   else { got_ammo = false; }
                }
                if(got_ammo) {
                   image(ammosmall, 545, 4); 
                }

                // Kill the enemy if it collides with shielded ball
                if(enemy_collide_with_shield == true || enemy_collide_with_bullet == true || enemy_collide_with_laser == true) {

                    kill_enemy(acquired_enemy);
                    if(enemy_collide_with_shield){
                        println("Enemy Collide with shiel");
                        enemy_collide_with_shield = false;
                        got_shield = false;
                    } 
                    if(enemy_collide_with_bullet){
                        enemy_collide_with_bullet = false;
                    } 
                    if(enemy_collide_with_laser){
                        enemy_collide_with_laser = false;
                    } 


                }

                if(enemy2_collide_with_shield == true || enemy2_collide_with_bullet == true || enemy2_collide_with_laser == true) {

                    kill_enemy2(acquired_enemy2);
                    if(enemy2_collide_with_shield){
                        enemy2_collide_with_shield = false;
                        got_shield = false;
                    } 
                    if(enemy2_collide_with_bullet){
                        enemy2_collide_with_bullet = false;
                    } 
                    if(enemy2_collide_with_laser){
                        enemy2_collide_with_laser = false;
                    } 

                }


                //Kill the ball if ball goes through hole in floors or ceiling : Srijan 5th March 2015
                if (ball.get_ball_pos("y") > height + 16 || ball.get_ball_pos("y") < -16 + pad_top || collission_with_enemy == true) {
                    
                    ball.done(); 
                    ball = new Ball(width*0.1, height*0.4, 10);
                    // reset the shift value
                    shift = 0;
                    // create the floors, platforms, ceilings for new level
                    scroll(0);
                    // reset the background scroll value
                    x_bg = 0;
                    // reset got_shield flag
                    got_shield = false;
                    // reset got_gun flag
                    got_gun = false;
                    got_laser = false;
                    got_ammo = false;

                    

                    //reset collision flag
                    collission_with_enemy = false;
                    
                    if(life > 0){
                       life--; 
                       _lifeCollected = life;
                    }
                    //reset level to zero
                    if(life <= 0){
                        level = 0;
                    }
                    if(life == 0) {
                        life = 1;
                        _lifeCollected = life;
                        gameScreen = 4;
                        _reasonOfGameOver = "killed"; 
                        //reset enemies and shields to initial position
                        destroy_floors();
                        destroy_platforms();
                        destroy_ceilings();
                        destroy_endbox();
                        destroy_enemy(enemy, true);
                        destroy_enemy2(enemy2, true);
                        destroy_shield(shield1, true);
                        destroy_power(heart, true);
                        destroy_power(coin, true);
                        destroy_weapon(gun, true);
                        destroy_weapon(laser, true);
                        destroy_weapon(ammo, true);

                    } else {
                     //reset enemies and shields to initial position
                      destroy_floors();
                      destroy_platforms();
                      destroy_ceilings();
                      destroy_endbox();
                      destroy_enemy(enemy, false);
                      destroy_enemy2(enemy2, false);
                      destroy_shield(shield1, false);
                      destroy_power(heart, false);
                      destroy_power(coin, false);
                      destroy_weapon(gun, false);
                      destroy_weapon(laser, false);
                      destroy_weapon(ammo, false); 
                    }
                    
                }

                // Hiding the acquired shield
                if( collission_with_shield == true) {
                    get_shield(acquired_shield);
                    collission_with_shield = false; 
                }

                // Hiding the hit bullet
                if( collission_with_bullet == true) {
                    get_gunbullet(used_bullet);
                    collission_with_bullet = false; 
                }
                
                // Hiding the hit laser
                if( collission_with_laser == true) {
                    get_laserbullet(used_laser_bullet);
                    collission_with_laser = false; 
                }

                // Hiding the acquired heart and coin
                if( collission_with_power == true) {
                    if(heart.contains(acquired_power)){
                        get_heart(acquired_power);
                    }
                    else if(coin.contains(acquired_power)){
                        get_coin(acquired_power); 
                    }
                    collission_with_power = false; 
                }

                // Hiding the acquired gun, laser and ammo
                if( collission_with_weapon == true) {
                    if(gun.contains(acquired_weapon)){
                        get_gun(acquired_weapon);
                    }
                    else if(laser.contains(acquired_weapon)){
                        get_laser(acquired_weapon); 
                    }
                    else if(ammo.contains(acquired_weapon)){
                        get_ammo(acquired_weapon); 
                    }
                    collission_with_weapon = false; 
                }


                //Scrolling effect when the ball is moved : Srijan 8th March 2015
                current_pos = ball.get_ball_pos("x");


                if (old_pos != current_pos) {

                    left_scroll_state = false;
                    if (current_pos < 65) {
                        //println(x_bg);
                        if (keyRight == true && keyUp == false) {
                            ball.step(5, -10);
                        } else if (keyRight == true && keyUp == true) {
                            ball.step(5, 10);
                        } else if (keyLeft == true && keyUp == false) {
                            ball.step(-0.05, -10);
                        } else if (keyLeft == true && keyUp == true && x_bg < 0.25) {
                            ball.step(-0.05, 10);
                        } else if (keyLeft == true && keyUp == true && x_bg >= 0) {
                            //println(x_bg);
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
                                if (x_bg <=-320) {
                                    
                                    if(_totalScore > 500){
                                      // Level up and Increase scroll speed
                                      level++;
                                      if(level == 3){
                                        gameScreen = 4;
                                        level = 0;
                                        life = 1;
                                        _lifeCollected = life;
                                      }
                                      gl.increaseLevel(level);
                                      t.resetTimer();
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
                                      // reset got_shield flag
                                      got_shield = false;
                                      // reset got_gun flag
                                      got_gun = false;
                                      got_laser = false;
                                      got_ammo = false;

                                    // TODO: Currently resetting when level up
                                    //  Need to set different placement in the playarea for different level
                                    // reset shieldSize array
                                    /* COMMENTED OUT & USED in destroy_object Functions
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
                                    // reset gunSize array
                                    for(int g=0; g<gunSize.length; g++) {
                                    gunSize[g] = 1;
                                    } 
                                    // reset laserSize array
                                    for(int l=0; l<laserSize.length; l++) {
                                    laserSize[l] = 1;
                                    } 
                                    // reset ammoSize array
                                    for(int a=0; a<ammoSize.length; a++) {
                                    ammoSize[a] = 1;
                                    } 
                                    // reset enemy positions
                                    for(int e=0; e<enemySize.length; e++) {
                                    enemySize[e] = 1;
                                    } 
                                    for(int e2=0; e2<enemy2Size.length; e2++) {
                                    enemy2Size[e2] = 1;
                                    }
                                     */ 
                                    //reset enemies and shields to initial position
                                      destroy_floors();
                                      destroy_platforms();
                                      destroy_ceilings();
                                      destroy_endbox();
                                      destroy_enemy(enemy, true);
                                      destroy_enemy2(enemy2, true);
                                      destroy_shield(shield1, true);
                                      destroy_power(heart, true);
                                      destroy_power(coin, true);
                                      destroy_weapon(gun, true);
                                      destroy_weapon(laser, true);
                                      destroy_weapon(ammo, true);
                                    /*
TODO: Show Level up screen , Currently game over screen is used
:Srijan 11th March 2015
                                     */

                                    //gameScreen = 4;
                                    
                                    }
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
              background(startupImg);
              
              if (isEndScreenDisplayed == 0) {
                isEndScreenDisplayed = 1;
                  
                displayNameOnLeft.setVisible(false);   
                gameLevel.setVisible(false);  
                s.hideScoresOnTop();
                // Reset Timer and Remove it; Bikram 14th March 015
                t.resetTimer();
                t.hideTimer();  
                
                //Show Game over to user : Srijan 8th March 2015
                endscreen.display(playerName, _reasonOfGameOver, _gamelvl, _lifeCollected,  _coinsCollected, _shieldCollected, _enemiesKilled, _totalScore, _highestScore);
                close_bgMusic();
                play_GameEnd();
              }
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
void destroy_floors() {
    while (floors.size () > 0) {
        for (int i=0; i<floors.size (); i++) {
            Box b = floors.get(i);
            //b.update();
            if (b.kill()) {
                floors.remove(i);
            }
        }
    }
    println("floors killed");
   // return true;
   create_floors(0);
}

void destroy_ceilings() {
    while (ceilings.size () > 0) {
        for (int i=0; i<ceilings.size (); i++) {
            Box b = ceilings.get(i);
            //b.update();
            if (b.kill()) {
                ceilings.remove(i);
            }
        }
    }
    println("ceilings killed");
   // return true;
   create_ceilings(0);
}

void destroy_endbox() {
   endbox.kill();
   //endbox = new Box(shift+3000, -10, 200, 600);
   println("endbox killed");
   create_endbox(0);
}

void destroy_platforms() {
    while (platforms.size () > 0) {
        for (int i=0; i<platforms.size (); i++) {
            Box b = platforms.get(i);
            //b.update();
            if (b.kill()) {
                platforms.remove(i);
            }
        }
    }
    println("platforms killed");
   // return true;
   create_platforms(0);
}

/* 
   April 13th 2015 : Srijan
   Created destroy box function to destroy the enemy objects in the box2d area
 */
void destroy_enemy(ArrayList<Enemy> enemyobj, boolean levelStart) {
    while (enemyobj.size () > 0) {
        for (int i=0; i<enemyobj.size(); i++) {
            Enemy e = enemyobj.get(i);
            //b.update();
            if (e.kill()) {
                enemyobj.remove(i);
            }
        }
    }
    // reset enemy positions
    if(levelStart) {
        for(int e=0; e<enemySize.length; e++) {
            enemySize[e] = 1;
        }
    } 
    create_enemy_obj();
}

float enemy2_xpos = 0;
float enemy2_ypos = 0;

// destroys enemy2 arraylist in playarea
void destroy_enemy2(ArrayList<Enemy2> enemyobj, boolean levelStart) {
    while (enemyobj.size () > 0) {
        for (int i=0; i<enemyobj.size (); i++) {
            Enemy2 e = enemyobj.get(i);
            enemy2_xpos = e.get_enemy2_pos("x");
            enemy2_ypos = e.get_enemy2_pos("y");
            if (e.kill()) {
                enemyobj.remove(i);
            }
        }
    }
    if(levelStart) {
        for(int e2=0; e2<enemy2Size.length; e2++) {
            enemy2Size[e2] = 1;
        }
    }
    create_enemy2_obj();
}

// destroys shields  arrraylist in playarea
void destroy_shield(ArrayList<Shield> shieldobj, boolean levelStart) {
    while (shieldobj.size () > 0) {
        for (int i=0; i<shieldobj.size (); i++) {
            Shield s = shieldobj.get(i);
            //b.update();
            if (s.kill()) {
                shieldobj.remove(i);
            }
        }
    }
    // reset shieldSize array
    if(levelStart) {
        for(int shield=0; shield<shieldSize.length; shield++) {
            shieldSize[shield] = 1;
        }
    }  
    create_shield_obj();
}

// destroys powerups , Srijan : 21st April 2015
void destroy_power(ArrayList<Power> powerobj, boolean levelStart) {
    while (powerobj.size () > 0) {
        for (int i=0; i<powerobj.size(); i++) {
            Power p = powerobj.get(i);
            //b.update();
            if (p.kill()) {
                powerobj.remove(i);
            }
        }
    }
    if(powerobj == heart){
        // reset heartSize array
        if(levelStart) {
            for(int h=0; h<heartSize.length; h++) {
                heartSize[h] = 1;
            }
        } 
        create_heart();
    }
    else if(powerobj == coin){
        // reset coinSize array
        if(levelStart) {
            for(int c=0; c<coinSize.length; c++) {
                coinSize[c] = 1;
            }
        } 
        create_coin();
    }

}


// destroy bullets objects
void destroy_gunbullet() {
    gunbullet = new ArrayList<Bullet>(); 
    for(int gb=0; gb<gunbulletSize.length; gb++) {
        gunbulletSize[gb] = 2;
    }
    fired_gunbullet = 0;
}

// destroy laser bullets objects
void destroy_laserbullet() {
    laserbullet = new ArrayList<LaserBullet>(); 
    for(int gb=0; gb<laserbulletSize.length; gb++) {
        laserbulletSize[gb] = 2;
    }
    fired_laserbullet = 0;
}

// destroys weapons , Srijan : 22nd April 2015
void destroy_weapon(ArrayList<Weapon> weaponobj, boolean levelStart) {
    while (weaponobj.size () > 0) {
        for (int i=0; i<weaponobj.size (); i++) {
            Weapon w = weaponobj.get(i);
            //b.update();
            if (w.kill()) {
                weaponobj.remove(i);
            }
        }
    }
    if(weaponobj == gun){
        // reset gunSize array
        if(levelStart) {
            for(int g=0; g<gunSize.length; g++) {
                gunSize[g] = 1;
            } 
        }
        create_gun();
    }
    else if(weaponobj == laser){
        // reset laserSize array
        if(levelStart) {
            for(int l=0; l<laserSize.length; l++) {
                laserSize[l] = 1;
            }
        } 
        create_laser();
    }else if(weaponobj == ammo){
        // reset ammoSize array
        if(levelStart) {
            for(int a=0; a<ammoSize.length; a++) {
                ammoSize[a] = 1;
            }
        } 
        create_ammo();
    }
}

//Scroll function to scroll the floor, ceilings and platforms : Srijan 5th March 2015
void scroll(float value) {
    shift += value;

    // shifting the box and the end of the each level
    //endbox.kill();
    //endbox = new Box(shift+3000, -10, 200, 600);
    if(left_scroll_state == true){ 
            endbox.shiftBody("l");
        }
    else if(right_scroll_state == true) {
            endbox.shiftBody("r");
    } 

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

    for(i=0; i<ammo.size(); i++){
        if(left_scroll_state == true){ 
            ammo.get(i).shiftBody("l");
        }
        else if(right_scroll_state == true) {
            ammo.get(i).shiftBody("r");
        } 
    }

    for(i=0; i<gun.size(); i++){
        if(left_scroll_state == true){ 
            gun.get(i).shiftBody("l");
        }
        else if(right_scroll_state == true) {
            gun.get(i).shiftBody("r");
        } 
    }

    for(i=0; i<laser.size(); i++){
        if(left_scroll_state == true){ 
            laser.get(i).shiftBody("l");
        }
        else if(right_scroll_state == true) {
            laser.get(i).shiftBody("r");
        } 
    }
    
    for(i=0; i<floors.size(); i++){
        if(left_scroll_state == true){ 
            floors.get(i).shiftBody("l");
        }
        else if(right_scroll_state == true) {
            floors.get(i).shiftBody("r");
        } 
    }
    
    for(i=0; i<ceilings.size(); i++){
        if(left_scroll_state == true){ 
            ceilings.get(i).shiftBody("l");
        }
        else if(right_scroll_state == true) {
            ceilings.get(i).shiftBody("r");
        } 
    }
    
    for(i=0; i<platforms.size(); i++){
        if(left_scroll_state == true){ 
            platforms.get(i).shiftBody("l");
        }
        else if(right_scroll_state == true) {
            platforms.get(i).shiftBody("r");
        } 
    }
    
    /*
    // Shift Boxes  
    if (destroy_box(floors)){
        if(destroy_box(ceilings)){
            if(destroy_box(platforms)){
                create_boxes(shift);     
            }
        }
    }
    */
}

//float addT = 0;
void keyPressed() {
    if (key == 'r' || key == 'R') { // Shoot bullet by Pressing 'R' KEY : Srijan : 23rd April 2015
        boolean bullet_fired_right = false;
        boolean bullet_fired_left = false;
        print("R pressed\n");
        print(remaining_gunbullet);
        if(got_gun){
            if(remaining_gunbullet != 0) {
                remaining_gunbullet -= 1; // Decrease number of bullets fired
                if(keyRight == true){
                    println("Creating new bullet ");
                    create_bullet(ball.get_ball_pos("x")+30, ball.get_ball_pos("y"));
                    bullet_fired_right = true;
                    bullet_fired_left = false;
                } else if(keyLeft) {
                    println("Creating new bullet ");
                    create_bullet(ball.get_ball_pos("x")-30, ball.get_ball_pos("y"));
                    bullet_fired_left = true;
                    bullet_fired_right = false;
                }
                if(bullet_fired_right || bullet_fired_left){
                    println("Remaining bullets = ", remaining_gunbullet);                    
                    fired_gunbullet +=1;
                    println("Fired Bullets = ", fired_gunbullet);

                    for(int gb=0; gb<fired_gunbullet; gb++){
                        if(bullet_fired_right && gunbulletSize[gb] == 2){
                            gunbulletSize[gb] = 1;
                        } else if(bullet_fired_left && gunbulletSize[gb] == 2){
                            gunbulletSize[gb] = -1; 
                        }
                    }
                    println("Size of Bullet = ", gunbullet.size());
                } 

            }
            if(remaining_gunbullet == 0){

                boolean all_bullets_fired = true;
                for(int fb=0; fb<gunbulletSize.length; fb++){
                    println(gunbulletSize[fb]);
                    if(gunbulletSize[fb] != 0){
                        println("Inside remaining gunbullet == 0");
                        all_bullets_fired = false;    
                    } 
                }
                println(all_bullets_fired);
                if(all_bullets_fired){
                    println("All bullets fired");
                    fired_gunbullet = 0;
                    for(int rf=0; rf<gunbulletSize.length; rf++){
                        gunbulletSize[rf] = 2;
                    } 
                    gunbullet.clear();
                }
            }
        }
    }
    if (key == 'l' || key == 'L') {
        //scroll(-0.5);
        boolean bullet_fired_right = false;
        boolean bullet_fired_left = false;
        if(got_laser){
            if(remaining_laserbullet != 0) {
                remaining_laserbullet -= 1; // Decrease number of bullets fired
                if(keyRight == true){
                    println("Creating new laser bullet ");
                    create_laserbullet(ball.get_ball_pos("x")+30, ball.get_ball_pos("y"));
                    bullet_fired_right = true;
                    bullet_fired_left = false;
                } else if(keyLeft) {
                    println("Creating new laser bullet ");
                    create_laserbullet(ball.get_ball_pos("x")-30, ball.get_ball_pos("y"));
                    bullet_fired_left = true;
                    bullet_fired_right = false;
                }
                if(bullet_fired_right || bullet_fired_left){
                    println("Remaining laser bullets = ", remaining_laserbullet);                    
                    fired_laserbullet +=1;
                    println("Fired laser Bullets = ", fired_laserbullet);

                    for(int gb=0; gb<fired_laserbullet; gb++){
                        if(bullet_fired_right && laserbulletSize[gb] == 2){
                            laserbulletSize[gb] = 1;
                        } else if(bullet_fired_left && laserbulletSize[gb] == 2){
                            laserbulletSize[gb] = -1; 
                        }
                    }
                    println("Size of Laser Bullet = ", laserbullet.size());
                } 

            }
            if(remaining_laserbullet == 0){

                boolean all_bullets_fired = true;
                for(int fb=0; fb<laserbulletSize.length; fb++){
                    println(laserbulletSize[fb]);
                    if(laserbulletSize[fb] != 0){
                        println("Inside remaining laserbullet == 0");
                        all_bullets_fired = false;    
                    } 
                }
                println(all_bullets_fired);
                if(all_bullets_fired){
                    println("All bullets fired");
                    fired_laserbullet = 0;
                    for(int rf=0; rf<laserbulletSize.length; rf++){
                        laserbulletSize[rf] = 2;
                    } 
                    laserbullet.clear();
                }
            }
        }
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
        if(keyCode != UP || keyCode != DOWN || keyCode != RIGHT || keyCode != LEFT || keyCode != CONTROL) {
           println(keyCode); 
        }
    }
}

//Play button click event
public void checkName() {
    playerName = trim(targetField.getText());
    if (playerName.length() != 0) {
        gameScreen = 2;
        checkNameButton.setVisible(false);
    }
}

//OkPlay button click event
public void playGame() {
    gameScreen = 3;
    playButton.setVisible(false);
    helpTextarea.setVisible(false);
}

//Quit Button 
public void quitGame(){
    exit();
}

//Restart button 
public void restartGame() {
    println("Restarting game!");
    endscreen.hideScoreBoard();
    displayNameOnLeft.setVisible(false);
    gl.hideLevel();
    game_over = true;
    gameScreen = 3;
    isEndScreenDisplayed = 0;
}

// acquires the shield object that collides with ball 
boolean get_shield(Shield s) {
    for (int i=0; i<shieldSize.length; i++) {
        if (shield1.get(i) == s) {
            println("shield removed from playarea");
            s.kill();
            ++_shieldCollected;
            //if (s.kill()) {
            //  shield1.remove(i);
            //}
            shieldSize[i] = 0;
            got_shield = true;

        }
    }
    return true;
}

// acquires the bullet object that collides  
boolean get_gunbullet(Bullet b) {
    for (int i=0; i<gunbullet.size(); i++) {
        if (gunbullet.get(i) == b) {
            println("bullet number ", i);
            println("bullet removed from playarea");
            do{
                gunbulletSize[i] = 0;
            }while(!b.kill());

        }
    }
    return true;
}

boolean get_laserbullet(LaserBullet b) {
    for (int i=0; i<laserbullet.size(); i++) {
        if (laserbullet.get(i) == b) {
            println("laser bullet number ", i);
            println("laser bullet removed from playarea");
            do{
                laserbulletSize[i] = 0;
            }while(!b.kill());

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
            life++;
            _lifeCollected = life;
            heartSize[i] = 0;
            //got_shield = true;

        }
    }
    return true;
}

// acquires the coin that collides with ball, Srijan : 21st April 2015
boolean get_coin(Power p) {
    for (int i=0; i<coinSize.length; i++) {
        if (coin.get(i) == p) {
            println("coin removed from playarea");
            coin_collectedSound();
            p.kill();
            ++_coinsCollected;
            coinSize[i] = 0;
            //got_shield = true;
            for(int coin=0; coin<coinSize.length; coin++){
                //println(coinSize[coin]);
                //println(coinSize.length); 
            }

        }
    }
    return true;
}

// acquires the gun that collides with ball, Srijan : 22nd April 2015
boolean get_gun(Weapon w) {
    for (int i=0; i<gunSize.length; i++) {
        if (gun.get(i) == w) {
            println("gun removed from playarea");
            play_weaponCollected();
            w.kill();
            gunSize[i] = 0;
            got_gun = true;
        }
    }
    return true;
}

// acquires the laser that collides with ball, Srijan : 22nd April 2015
boolean get_laser(Weapon w) {
    for (int i=0; i<laserSize.length; i++) {
        if (laser.get(i) == w) {
            println("laser removed from playarea");
            w.kill();
            laserSize[i] = 0;
            got_laser = true;

        }
    }
    return true;
}

// acquires the laser that collides with ball, Srijan : 22nd April 2015
boolean get_ammo(Weapon w) {
    for (int i=0; i<ammoSize.length; i++) {
        if (ammo.get(i) == w) {
            println("ammo removed from playarea");
            w.kill();
            ammoSize[i] = 0;
            got_ammo = true;
            remaining_gunbullet = 5; // Reload the gun with 5 bullets
            remaining_laserbullet = 5;
            fired_gunbullet = 0;
            fired_laserbullet = 0;
            //println("Bullets count = ", remaining_gunbullet);
            //fired_gunbullet = 0;
            for(int rf=0; rf<gunbulletSize.length; rf++){
                gunbulletSize[rf] = 2;
            } 
            gunbullet.clear();
            for(int rf1=0; rf1<laserbulletSize.length; rf1++){
                laserbulletSize[rf1] = 2;
            } 
            laserbullet.clear();
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
            ++_enemiesKilled;
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
            ++_enemiesKilled;
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
    } else if (o1.getClass() == Ball.class && o2.getClass() == Weapon.class) { // Checks if ball hits the weapons , Srijan : 22nd April 2015
        println("collided with weapon");
        acquired_weapon = (Weapon) o2;
        //get_shield(s);
        collission_with_weapon = true;
    } else if (o2.getClass() == Ball.class && o1.getClass() == Weapon.class) {
        println("collided with weapon");
        acquired_weapon = (Weapon) o1;
        collission_with_weapon = true;
    }

    // check if enemy is hit by bullet 
    if (o1.getClass() == Bullet.class && (o2.getClass() == Enemy.class || o2.getClass() == Enemy2.class)) { 
        println("bullet hits enemy");
        if(o2.getClass() == Enemy.class){
            acquired_enemy = (Enemy) o2;
            enemy_collide_with_bullet = true; 
        }
        else{
            acquired_enemy2 = (Enemy2) o2;
            enemy2_collide_with_bullet = true;  
        }
        used_bullet = (Bullet) o1;
        collission_with_bullet = true;
    } else if (o2.getClass() == Bullet.class && (o1.getClass() == Enemy.class || o1.getClass() == Enemy2.class)) {
        println("bullet hits enemy");
        if(o1.getClass() == Enemy.class){
            acquired_enemy = (Enemy) o1;
            enemy_collide_with_bullet = true; 
        }
        else{
            acquired_enemy2 = (Enemy2) o1;
            enemy2_collide_with_bullet = true;  
        }
        used_bullet = (Bullet) o2;
        collission_with_bullet = true;
    } else if (o1.getClass() == Bullet.class &&  
            (o2.getClass() == Box.class || o2.getClass() == Shield.class || o2.getClass() == Surface.class || o2.getClass() == Weapon.class || o2.getClass() == Bullet.class || o2.getClass() == Power.class)) { 
        println("bullet used must disappear");
        used_bullet = (Bullet) o1;
        collission_with_bullet = true;
    } else if (o2.getClass() == Bullet.class && 
            (o1.getClass() == Box.class || o1.getClass() == Shield.class || o1.getClass() == Surface.class || o1.getClass() == Weapon.class || o1.getClass() == Bullet.class || o1.getClass() == Power.class)) {
        println("bullet used must disappear");
        used_bullet = (Bullet) o2;
        collission_with_bullet = true;
    }
    
    //check if laser hits enemy
    if (o1.getClass() == LaserBullet.class && (o2.getClass() == Enemy.class || o2.getClass() == Enemy2.class)) { 
        println("laser hits enemy");
        if(o2.getClass() == Enemy.class){
            acquired_enemy = (Enemy) o2;
            enemy_collide_with_laser = true; 
        }
        else{
            acquired_enemy2 = (Enemy2) o2;
            enemy2_collide_with_laser = true;  
        }
        used_laser_bullet = (LaserBullet) o1;
        collission_with_laser = true;
    } else if (o2.getClass() == LaserBullet.class && (o1.getClass() == Enemy.class || o1.getClass() == Enemy2.class)) {
        println("laser hits enemy");
        if(o1.getClass() == Enemy.class){
            acquired_enemy = (Enemy) o1;
            enemy_collide_with_laser = true; 
        }
        else{
            acquired_enemy2 = (Enemy2) o1;
            enemy2_collide_with_laser = true;  
        }
        used_laser_bullet = (LaserBullet) o2;
        collission_with_laser = true;
    } else if (o1.getClass() == LaserBullet.class &&  
            (o2.getClass() == Box.class || o2.getClass() == Shield.class || o2.getClass() == Surface.class || o2.getClass() == Weapon.class || o2.getClass() == Bullet.class || o2.getClass() == Power.class)) { 
        println("laser bullet used must disappear");
        used_laser_bullet = (LaserBullet) o1;
        collission_with_laser = true;
    } else if (o2.getClass() == LaserBullet.class && 
            (o1.getClass() == Box.class || o1.getClass() == Shield.class || o1.getClass() == Surface.class || o1.getClass() == Weapon.class || o1.getClass() == Bullet.class || o1.getClass() == Power.class)) {
        println("laser bullet used must disappear");
        used_laser_bullet = (LaserBullet) o2;
        collission_with_laser = true;
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

void close_bgMusic(){
     player.pause();
     player.rewind();
     //player.close();
     //minim1.stop();
     //super.stop();
}

void play_shootSound(){
     shootSound.play();
     shootSound.rewind();
}

void coin_collectedSound(){
     coinCollectedSound.play();
     coinCollectedSound.rewind();
     //minim3.stop(); 
     //super.stop(); 
}

void play_GameEnd(){
     GameEnd.play(); 
     GameEnd.rewind();
}

void play_heartCollected(){
     heartCollected.play();
     heartCollected.rewind();
}

void play_enemyKilled(){
     enemyKilled.play();
     enemyKilled.rewind();
}

void shieldCollected(){
    shieldCollected.play();
    shieldCollected.rewind();
}


void play_weaponCollected(){
    weaponCollected.play();
    weaponCollected.rewind();
}

void endContact(Contact cp) {
}
