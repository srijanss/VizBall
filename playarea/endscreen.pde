/**
Class that defines the Game Over Screen
**/
class EndScreen{  
 
 void display(String player_name, String reasonOfGameOver, int gamelvl, int lifeCollected, int coinsCollected, int shieldCollected, int enemiesKilled, int totalScore, int highestScore){
       PFont font = createFont("arial",20);
       PImage[] imgs = {loadImage("./images/button1.jpg"),loadImage("./images/button1.jpg"),loadImage("./images/button1.jpg")};
       
       if(_totalScore > _highestScore)
         _highestScore = _totalScore;
       if(_totalScore == 0)
          _highestScore = _totalScore;
       displayGameOver = cp5.addTextlabel("displayGameOver")
                          .setText("GAME OVER, " + player_name)
                          .setPosition(160,20)
                          .setColorValue(000)
                          .setFont(createFont("Georgia",20))
                          ;
       game_Lvl = cp5.addTextlabel("game_Lvl")
                          .setText("Game Level Reached "+gamelvl)
                          .setPosition(160,60)
                          .setColorValue(000)
                          .setFont(createFont("Georgia",20))
                          ;
       coins_collected = cp5.addTextlabel("coins_collected")
                          .setText("Coins Collected "+coinsCollected)
                          .setPosition(160,80)
                          .setColorValue(000)
                          .setFont(createFont("Georgia",20))
                          ;
                          
       shield_collected = cp5.addTextlabel("shield_collected")
                          .setText("Shield Collected "+shieldCollected)
                          .setPosition(160, 100)
                          .setColorValue(000)
                          .setFont(createFont("Georgia",20))
                          ;
                          
       life_collected = cp5.addTextlabel("life_collected")
                          .setText("Life Collected "+shieldCollected)
                          .setPosition(160, 120)
                          .setColorValue(000)
                          .setFont(createFont("Georgia",20))
                          ;
       enemies_killed = cp5.addTextlabel("enemies_killed")
                          .setText("Enemies Killed "+enemiesKilled)
                          .setPosition(160,140)
                          .setColorValue(000)
                          .setFont(createFont("Georgia",20))
                          ;
                          
       total_points = cp5.addTextlabel("total_points")
                          .setText("Total Points "+totalScore)
                          .setPosition(160,160)
                          .setColorValue(000)
                          .setFont(createFont("Georgia",20))
                          ;
                          
       highest_points = cp5.addTextlabel("highest_points")
                          .setText("Highest Points "+_highestScore)
                          .setPosition(160,180)
                          .setColorValue(000)
                          .setFont(createFont("Georgia",20))
                          ;


       bangButton      =  cp5.addButton("restart")
                           .setValue(128)
                           .setPosition(160,220)
                           .setImages(imgs)
                           .updateSize()
                           ;
 
  }
  void hideScoreBoard(){
       game_Lvl. setVisible(false);
       coins_collected.setVisible(false);        
       shield_collected.setVisible(false);
       life_collected.setVisible(false);       
       enemies_killed.setVisible(false);
       total_points.setVisible(false);                          
       highest_points.setVisible(false);
  }
  
  void resetScoreBoard(){ 
      _coinsCollected =0;
      _shieldCollected =0;
      _enemieskilled =0;
      _totalScore =0; 
      _gamelvl = 0;
      _lifeCollected =0;
  }
  
  
}
