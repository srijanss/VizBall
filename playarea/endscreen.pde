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
 
       bangButton      =  cp5.addButton("restart")
                           .setValue(128)
                           .setPosition(280,180)
                           .setImages(imgs)
                           .updateSize()
                           ;
      

 
  }
}
