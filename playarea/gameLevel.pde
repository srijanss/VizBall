class GameLevel{
  int level;
 
   GameLevel(){
             level = 1;
             gameLevel = cp5.addTextlabel("game_level")
                          .setPosition(70, 0)
                          .setValue(level)
                          .setFont(createFont("Georgia",14))
                          ;
   
    } 
  
    void display(){
            gameLevel.setText("| Level : "+level);
    }
    
    int getLevel(){
          return level;
    }
    
    void increaseLevel(){
          ++level;
     }
     
     void hideLevel(){
         gameLevel.setVisible(false);
     }
     
     void showLevel(){
         gameLevel.setVisible(true);
     }
     
     void resetGameLevel(){
         level = 1;
     }
    
}
