
ArrayList<Enemy> enemies; 

class Enemy {
  PVector pos; 
  PImage sprite;
  int randTarget; 
  int tarY;
  int tarX; 
  int health;
  
  int maxCostume = 0;
  int costume;
  
  Enemy() {
    waveLvl();
    costume = int(random(0,maxCostume+1));
    determineHealth();
    
    int randX = int(constrain(random(0, width), 48, width-48));
  
    sprite = loadImage("data/visuals/enemies/enemy_"+costume+".png");
    pos = new PVector(randX, 0);

    tarX = int(constrain(random(pos.x-10, pos.x+10), 48, width-48));
    tarY = int(random(16, height/2));
  }

  boolean dead() {
    
    if(costume != 0 && health <=0) {
      costume-=1;
      determineHealth();
      sprite = loadImage("data/visuals/enemies/enemy_"+costume+".png");
    }
    
    return health<=0 && costume == 0;
  }

  void display() {
    
    if (!dead()) {
      randomMove();
      pushMatrix();
      translate(pos.x, pos.y); 
      image(sprite, 0, 0);
      popMatrix();
      if (pos.y<tarY) {
        pos.y++;
      }
      damage();
    } else {
      enemies.remove(enemyCount);
      
    }
  }
  
  void waveLvl() {
    switch(gameScreen.wave) {
    case 1: 
      maxCostume = 0;
    break; 
    case 2: 
      maxCostume = 1;
      break; 
    case 20: 
      break;
    }
  }
  
  void determineHealth() {
    switch(costume) {
      case 0:
        health = 100; 
      break; 
      case 1: 
        health = 250;
      break; 
    }
  }

  void randomMove() {
    if (pos.x<tarX) {
      pos.x+=1;
    } else if (pos.x>tarX) {
      pos.x-=1;
    } else {
      tarX = int(constrain(random(pos.x-20, pos.x+20), 32, width-32));
    }
  }

  void damage() {
    for (int i = 0; i<bullets.size(); i++) {
      Bullet bullet = bullets.get(i);
      PVector bulletPos = new PVector(bullet.x, bullet.y);


      if (isDist(pos, bulletPos, 32)) {
        bullet.lifetime = 0;
        health-=player.damage;
      }
    }
  }
}


int enemyCount; 

void countEnemies() {

  for (enemyCount = enemies.size()-1; enemyCount>=0; enemyCount--) {
    Enemy enemy = enemies.get(enemyCount);
    enemy.display();
  }
}
