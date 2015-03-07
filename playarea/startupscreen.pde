class StartUpScreen{  
 
 void display(){
       PFont font = createFont("arial",20);
       PImage[] imgs = {loadImage("./images/button1.jpg"),loadImage("./images/button1.jpg"),loadImage("./images/button1.jpg")};

       targetField = cp5.addTextfield("YOU NAME")
                          .setPosition(280,120)
                          .setSize(200,40)
                          .setFont(font)
                          .setFocus(true)
                          .setColor(color(255,0,0))
                          ;
        
       displayGreetings = cp5.addTextlabel("displayUsername")
                          .setText("")
                          .setPosition(280,120)
                          .setColorValue(0xffffff00)
                          .setFont(createFont("Georgia",20))
                          ;
     
       bangButton      =  cp5.addButton("play")
                           .setValue(128)
                           .setPosition(280,180)
                           .setImages(imgs)
                           .updateSize()
                           ; 
 } 

 
}

