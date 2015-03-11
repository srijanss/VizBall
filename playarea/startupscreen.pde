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
                          .setPosition(90,30)
                          //.setColorValue(0xffffff00)
                          .setFont(createFont("Georgia",20))
                          ;
      displayNameOnLeft = cp5.addTextlabel("displayUsernameOnLeft")
                          .setText("")
                          .setPosition(20,0)
                          .setFont(createFont("Georgia",13))
                          ;
     
       bangButton      = cp5.addButton("play")
                           .setValue(128)
                           .setPosition(280,180)
                           .setImages(imgs)
                           .updateSize()
                             ; 
}

void displayHelp(){      
      PImage[] imgs = {loadImage("./images/button1.jpg"),loadImage("./images/button1.jpg"),loadImage("./images/button1.jpg")};
      helpTextarea = cp5.addTextarea("txt")
                  .setPosition(100,60)
                  .setSize(450,160)
                  .setFont(createFont("arial",16))
                  .setLineHeight(14)
                  .setColor(color(128))
                  .setColorBackground(color(00, 00))
                  .setColorForeground(color(255,255));
                  ;
                  
      helpTextarea.setText("Lorem Ipsum is simply dummy text of the printing and typesetting"
                      +" industry. Lorem Ipsum has been the industry's standard dummy text"
                      +" ever since the 1500s, when an unknown printer took a galley of type"
                      +" and scrambled it to make a type specimen book. It has survived not"
                      +" only five centuries, but also the leap into electronic typesetting,"
                      +" remaining essentially unchanged. It was popularised in the 1960s"
                      +" with the release of Letraset sheets containing Lorem Ipsum passages,"
                      +" and more recently with desktop publishing software like Aldus"
                      +" PageMaker including versions of Lorem Ipsum."
                      );
     playButton        =  cp5.addButton("play_Game")
                           .setValue(128)
                           .setPosition(120,240)
                           .setImages(imgs)
                           .updateSize()
                             ; 
}
}

