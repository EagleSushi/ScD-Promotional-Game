
ArrayList<Bullet> bullets;


class Bullet {
  PVector startPos, targetPos; 
  int x,y;
  PImage[] bulletImg = new PImage[4];
  int lifetime=70; 
  int speed = 10; 
  int damage;
  
  Bullet(PVector startPos_) {
    startPos = startPos_; 
    x = int(startPos.x); y = int(startPos.y);
    targetPos = new PVector(startPos.x,0);
    
    for(int i = 0; i<bulletImg.length;i++) {
      bulletImg[i] = loadImage("data/visuals/bullets/bullet_" +i+".png");
    }
  }
  
  void display() {
    if(!dead()) {
      lifetime--; 
      
      y-=speed;
      pushMatrix();
      translate(x,y);
      image(bulletImg[player.character],0,0);
      
      popMatrix();
    } else {
      bullets.remove(bulletCount);
    }
  }
  
  boolean dead() {
    return lifetime<=0 || y<=0 ;
  }
  
  
  
  
  
  
}

int bulletCount; 

void countBullets() {
  
  for(bulletCount = bullets.size()-1; bulletCount>=0; bulletCount--) {
    Bullet bullet = bullets.get(bulletCount);
    bullet.display();
  }
}
