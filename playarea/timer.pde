/*Timer class to control the time of game and used over to 
  end the game when time up  - BIkram  
  */

class Timer {
  int savedTime;
  int totalTime = 1000;
  int game_TotalTime = 90;
  int passedTime;
  /*TImer constructor */
  void initializeTimer(){
                savedTime = millis();
                timerRight = cp5.addTextlabel("timer_label")
                          .setPosition(600, 0)
                          .setValue("")
                          .setFont(createFont("Georgia",14))
                          ;
  }
  /*Get the timer current value*/
  int getTimerValue(){
              passedTime = millis() - savedTime;
              if (passedTime > totalTime) {
                game_TotalTime = game_TotalTime - 1;
                savedTime = millis();
              }
             return game_TotalTime;
   }
   /*Reset the timer when level complete or when it needs to be reset */
   void resetTimer(){
           game_TotalTime = 90;
   }
   /*Hide the timer */
   void hideTimer(){
         timerRight.setVisible(false);
   }
   /*SHow time coundown on frame */
   void showTimer(){
         timerRight.setVisible(true);
   }
   /*check if time set is over */
   boolean isTimeOver(){
         if (game_TotalTime <= 0)
         return true; 
         else
         return false;
   } 
          
}
