class Timer {
  int savedTime;
  int totalTime = 1000;
  int game_TotalTime = 90;
  int passedTime;
  
  void initializeTimer(){
                savedTime = millis();
                timerRight = cp5.addTextlabel("timer_label")
                          .setPosition(600, 0)
                          .setValue("")
                          .setFont(createFont("Georgia",14))
                          ;
  }
  
  int getTimerValue(){
              passedTime = millis() - savedTime;
              if (passedTime > totalTime) {
                game_TotalTime = game_TotalTime - 1;
                savedTime = millis();
              }
             return game_TotalTime;
   }
   
   void resetTimer(){
           game_TotalTime = 90;
   }
   
   void hideTimer(){
         timerRight.setVisible(false);
   }
   
   void showTimer(){
         timerRight.setVisible(true);
   }
   
   boolean isTimeOver(){
         if (game_TotalTime <= 0)
         return true; 
         else
         return false;
   } 
          
}
