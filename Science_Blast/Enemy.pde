
ArrayList<Enemy> enemies; 

class Enemy {
  PVector pos; 
  PImage sprite;
  int randTarget; 
  int tarY;
  int tarX; 
  int health;

  Enemy() {
    health = 250;
    int randX = int(constrain(random(0, width), 48, width-48));

    sprite = loadImage("data/visuals/enemies/enemy_0.png");
    pos = new PVector(randX, 0);

    tarX = int(constrain(random(pos.x-10, pos.x+10), 48, width-48));
    tarY = int(random(16, height/2));
  }

  boolean dead() {
    return health<=0;
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
