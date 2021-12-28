class Background {
  PImage background;
  PVector position; 
  
  Background() {
    background = loadImage("data/visuals/backdrop/backdrop.png");
    position = new PVector(width/2,height/2);
  }
  
  void display() {
    pushMatrix();
    translate(position.x,position.y); 
    //decidePos();
    image(background,0,0);
    popMatrix();
  }
  
  void decidePos() {
    position.x = map(mouseX,0,width,width/2-50,width/2+50);
  }
  
  
}
