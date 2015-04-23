/**
Class that defines the Game Over Screen
**/
class EndScreen{  
 
 void display(){
       PFont font = createFont("arial",20);
       PImage[] imgs = {loadImage("./images/button1.jpg"),loadImage("./images/button1.jpg"),loadImage("./images/button1.jpg")};

      
       displayGameOver = cp5.addTextlabel("displayGameOver")
                          .setText("")
                          .setPosition(140,120)
                          .setColorValue(0xffffff00)
                          .setFont(createFont("Georgia",20))
                          ;
       game_Lvl = cp5.addTextlabel("game_Lvl")
                          .setText("Game Level Reached ")
                          .setPosition(140,120)
                          .setColorValue(0xffffff00)
                          .setFont(createFont("Georgia",40))
                          ;
       coins_collected = cp5.addTextlabel("coins_collected")
                          .setText("Coins Collected ")
                          .setPosition(140,120)
                          .setColorValue(0xffffff00)
                          .setFont(createFont("Georgia",60))
                          ;
                          
       shield_collected = cp5.addTextlabel("shield_collected")
                          .setText("Shield Collected ")
                          .setPosition(140,120)
                          .setColorValue(0xffffff00)
                          .setFont(createFont("Georgia",80))
                          ;
                          
       enemies_killed = cp5.addTextlabel("enemies_killed")
                          .setText("Enemies Killed ")
                          .setPosition(140,120)
                          .setColorValue(0xffffff00)
                          .setFont(createFont("Georgia",100))
                          ;
                          
       total_points = cp5.addTextlabel("total_points")
                          .setText("Total Points ")
                          .setPosition(140,120)
                          .setColorValue(0xffffff00)
                          .setFont(createFont("Georgia",120))
                          ;
                          
       highest_points = cp5.addTextlabel("highest_points")
                          .setText("Highest Points ")
                          .setPosition(140,120)
                          .setColorValue(0xffffff00)
                          .setFont(createFont("Georgia",140))
                          ;


       bangButton      =  cp5.addButton("restart")
                           .setValue(128)
                           .setPosition(1400,180)
                           .setImages(imgs)
                           .updateSize()
                           ;
 
  }
  void hideScoreBoard(){
         game_Lvl = cp5.addTextlabel("game_Lvl")
                          .setText("")
                          .setPosition(140,120)
                          .setColorValue(0xffffff00)
                          .setFont(createFont("Georgia",20))
                          ;
       coins_collected = cp5.addTextlabel("coins_collected")
                          .setText("")
                          .setPosition(140,120)
                          .setColorValue(0xffffff00)
                          .setFont(createFont("Georgia",20))
                          ;
                          
       shield_collected = cp5.addTextlabel("shield_collected")
                          .setText("")
                          .setPosition(140,120)
                          .setColorValue(0xffffff00)
                          .setFont(createFont("Georgia",20))
                          ;
                          
       enemies_killed = cp5.addTextlabel("enemies_killed")
                          .setText("")
                          .setPosition(140,120)
                          .setColorValue(0xffffff00)
                          .setFont(createFont("Georgia",20))
                          ;
                          
       total_points = cp5.addTextlabel("total_points")
                          .setText("")
                          .setPosition(140,120)
                          .setColorValue(0xffffff00)
                          .setFont(createFont("Georgia",20))
                          ;
                          
       highest_points = cp5.addTextlabel("highest_points")
                          .setText("")
                          .setPosition(140,120)
                          .setColorValue(0xffffff00)
                          .setFont(createFont("Georgia",20))
                          ;

  
  
  }
  
  
}
