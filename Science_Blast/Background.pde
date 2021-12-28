class Background {
  PImage background, waveIndicator;
  PVector position; 
  PImage[] healthBar = new PImage[11];
  
  Background() {
    background = loadImage("data/visuals/backdrop/backdrop.png");
    waveIndicator = loadImage("data/visuals/gui/wave.png");
    position = new PVector(width/2,height/2);
    
    for(int i = 0;i<healthBar.length;i++) {
      healthBar[i] = loadImage("data/visuals/gui/health_"+i+".png");
    }
  }
  
  void display() {
    //println(1);
    //pushMatrix();
    //translate(position.x,position.y); 
    ////decidePos();
    //image(background,0,0);
    //popMatrix();
    displayWaves(); 
    displayHealth(); 
    
  }
  
  void displayHealth() {
    image(healthBar[player.health],540,30);
    
    pushStyle();
    fill(255);
    textSize(32);
    text("Score: " + gameScreen.score,400,80);
    popStyle();
  }
  
  void displayWaves() {
    image(waveIndicator,width/2,height/2);
    pushStyle();
    fill(0);
    textSize(48);
    textMode(CENTER);
    text(gameScreen.wave,120,80);
    popStyle();
  }
  
  
}
