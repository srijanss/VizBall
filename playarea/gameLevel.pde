/* Game level countdown class - Bikram  
*/
class GameLevel{
 /* Initialize the Game Level */
   GameLevel(int level){
             gameLevel = cp5.addTextlabel("game_level")
                          .setPosition(70, 5)
                          .setValue(level)
                          .setFont(createFont("Georgia",14))
                          ;
   
    } 
  /* Display the game level */
    void display(){
            gameLevel.setText("| Level : "+level);
    }
    /* get the current game level */
    int getLevel(){
          return level;
    }
    /*increase the game level*/
    void increaseLevel(int level){
          ++level;
          gameLevel.setText("| Level : "+level);
     }
     /*Hide game level */
     void hideLevel(){
         gameLevel.setVisible(false);
     }
     /*Show game level */
     void showLevel(){
         gameLevel.setVisible(true);
     }
     /* REset game level */
     void resetGameLevel(){
         level = 1;
     }
    
}
