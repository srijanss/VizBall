/**
Class that defines the Game Over Screen
BIkram : 20:04:2015
**/
class EndScreen{  
 //FUnction to display top labels of score, life, coins collected et.
 void display(String player_name, String reasonOfGameOver, int gamelvl, int lifeCollected, int coinsCollected, int shieldCollected, int enemiesKilled, int totalScore, int highestScore){
       PFont font = createFont("arial",20);
       PImage restartImg = loadImage("./images/restart.jpg");
       PImage quitImg = loadImage("./images/quit.jpg");
       String str;
       if(reasonOfGameOver =="timeout"){
            str = "Timeout ";
       }else{
            str = "Game Over ";
       }
       if(_totalScore > _highestScore)
         _highestScore = _totalScore;

      if (displayGameOver != null) {
        displayGameOver.setText(str + player_name);
        displayGameOver.setVisible(true);
      }
      else {
       displayGameOver = cp5.addTextlabel("displayGameOver")
                          .setText(str + player_name)
                          .setPosition(160,20)
                          .setColorValue(000)
                          .setFont(createFont("Georgia",20));
      }
      
      if (game_Lvl != null) { 
        game_Lvl.setText("Game Level Reached "+gamelvl);
        game_Lvl.setVisible(true);
      }
      else {
       game_Lvl = cp5.addTextlabel("game_Lvl")
                          .setText("Game Level Reached "+gamelvl)
                          .setPosition(160,60)
                          .setColorValue(000)
                          .setFont(createFont("Georgia",20));
       }
       
       if (coins_collected != null) { 
        coins_collected.setText("Coins Collected "+coinsCollected);
        coins_collected.setVisible(true);
      }
      else {
       coins_collected = cp5.addTextlabel("coins_collected")
                          .setText("Coins Collected "+coinsCollected)
                          .setPosition(160,80)
                          .setColorValue(000)
                          .setFont(createFont("Georgia",20))
                          ;
      }
      
      if (shield_collected != null) { 
        shield_collected.setText("Shield Collected "+shieldCollected);
        shield_collected.setVisible(true);
      }
      else {
       shield_collected = cp5.addTextlabel("shield_collected")
                          .setText("Shield Collected "+shieldCollected)
                          .setPosition(160, 100)
                          .setColorValue(000)
                          .setFont(createFont("Georgia",20));
      }
      
      if (life_collected != null) { 
        life_collected.setText("Life Collected "+lifeCollected);
        life_collected.setVisible(true);
      }
      else {
       life_collected = cp5.addTextlabel("life_collected")
                          .setText("Life Collected "+lifeCollected)
                          .setPosition(160, 120)
                          .setColorValue(000)
                          .setFont(createFont("Georgia",20));
      }
      
      if (enemies_killed != null) { 
        enemies_killed.setText("Enemies Killed "+enemiesKilled);
        enemies_killed.setVisible(true);
      }
      else {
       enemies_killed = cp5.addTextlabel("enemies_killed")
                          .setText("Enemies Killed "+enemiesKilled)
                          .setPosition(160,140)
                          .setColorValue(000)
                          .setFont(createFont("Georgia",20));
      }
               
      if (total_points != null) { 
        total_points.setText("Total Points "+totalScore);
        total_points.setVisible(true);
      }
      else {           
       total_points = cp5.addTextlabel("total_points")
                          .setText("Total Points "+totalScore)
                          .setPosition(160,160)
                          .setColorValue(000)
                          .setFont(createFont("Georgia",20));
      }             
      
      if (highest_points != null) { 
        highest_points.setText("Highest Points "+_highestScore);
        highest_points.setVisible(true);
      }
      else {    
       highest_points = cp5.addTextlabel("highest_points")
                          .setText("Highest Points "+_highestScore)
                          .setPosition(160,180)
                          .setColorValue(000)
                          .setFont(createFont("Georgia",20));
      }
      
      if (restartButton != null) { 
        restartButton.setVisible(true);
      }
      else {  
      restartButton    =  cp5.addButton("restartButton")
                          .setPosition(160,220)
                          .setImage(restartImg)
                          .updateSize()
                          .addCallback(new CallbackListener() {
                              public void controlEvent(CallbackEvent event) {
                                println("Event was " + event.getAction());
                                if (event.getAction() == ControlP5.ACTION_RELEASED) {
                                  restartGame();
                                  restartButton.setVisible(false);
                                }
                              }
                            }
                          );
      }
      
      if (quitButton != null) { 
        quitButton.setVisible(true);
      }
      else { 
      quitButton       =  cp5.addButton("quitButton")
                           .setPosition(350,220)
                           .setImage(quitImg)
                           .updateSize()
                           .addCallback(new CallbackListener() {
                              public void controlEvent(CallbackEvent event) {
                                println("Event was " + event.getAction());
                                if (event.getAction() == ControlP5.ACTION_RELEASED) {
                                  quitGame();
                                  quitButton.setVisible(false);
                                }
                              }
                            }
                          );
      }
  }
  
  
  //Hide the top socre information 
  void hideScoreBoard(){
       displayGameOver.setVisible(false);
       game_Lvl.setVisible(false);
       coins_collected.setVisible(false);        
       shield_collected.setVisible(false);
       life_collected.setVisible(false);       
       enemies_killed.setVisible(false);
       total_points.setVisible(false);                          
       highest_points.setVisible(false);
       restartButton.setVisible(false);
       quitButton.setVisible(false);
  }
  

  
  // REset the scoreboard
  void resetScoreBoard(){ 
      _coinsCollected =0;
      _shieldCollected =0;
      _enemiesKilled =0;
      _totalScore =0; 
      _gamelvl = 0;
      _lifeCollected =0;
  }
}
