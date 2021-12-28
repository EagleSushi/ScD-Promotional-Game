
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
  int pointValue;

  int cooldown = 300; 
  int timer; 

  ArrayList<EnemyBullet> enemyBullets;

  Enemy() {
    timer = int(random(cooldown, cooldown*2));
    waveLvl();
    costume = int(random(0, maxCostume+1));
    determineHealth();
    determinePoints();

    int randX = int(constrain(random(0, width), 48, width-48));

    sprite = loadImage("data/visuals/enemies/enemy_"+costume+".png");
    pos = new PVector(randX, 0);

    tarX = int(constrain(random(pos.x-10, pos.x+10), 48, width-48));
    tarY = int(random(128, height/2));

    enemyBullets = new ArrayList<EnemyBullet>();
  }

  boolean dead() {

    if (costume != 0 && health <=0) {
      costume-=1;
      determineHealth();
      sprite = loadImage("data/visuals/enemies/enemy_"+costume+".png");
    }

    return health<=0 && costume == 0;
  }

  void display() {

    if (!dead()) {
      countEB();
      randomMove();
      pushMatrix();
      translate(pos.x, pos.y); 
      image(sprite, 0, 0);
      popMatrix();
      shootBullets();
      detectBomb(); 
      if (pos.y<tarY) {
        pos.y++;
      }
      
      damage();
    } else {

      gems.add(new Gem(pos, player.position, pointValue));
      clearBullets();
      enemies.remove(enemyCount);
    }
  }

  void clearBullets() {
    //println("active");
    for (int i = 0; i<enemyBullets.size(); i++) {
      EnemyBullet bullet = enemyBullets.get(i);
      PVector bulletPos = new PVector(bullet.x, bullet.y);

      gems.add(new Gem(bulletPos, player.position, 5));
      enemyBullets.remove(i);
    }
  }

  void detectBomb() {
    if (player.charge>=player.chargeCapacity && right) {
      clearBullets(); 
      player.charge=0;
      health = 0;
    }
  }


  void shootBullets() {

    if (timer>0) {
      timer--;
    } else {

      EnemyBullet temp = new EnemyBullet();
      temp.x = pos.x; 
      temp.y = pos.y;

      enemyBullets.add(temp);
      timer = cooldown;
    }
  }

  void waveLvl() {
    if (gameScreen.wave<10) {
      maxCostume = 0;
    } 
    if (gameScreen.wave<=20 && gameScreen.wave>=10) {
      maxCostume = 1;
    }
  }

  void determinePoints() {
    switch(costume) {
    case 0:
      pointValue = 10;
      break; 
    case 1: 
      pointValue = 50;
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

  class EnemyBullet {
    float x, y;
    PImage sprite; 
    float speed=3; 

    EnemyBullet() {
      sprite = loadImage("data/visuals/bullets/enemy_0.png");
    }

    void display() {
      if (!dead()) {
        pushMatrix();
        translate(x, y);
        image(sprite, 0, 0);
        move();
        popMatrix();
        damagePlayer();
      } else {
        enemyBullets.remove(EBCount);
      }
    }

    void damagePlayer() {
      PVector currentPos = new PVector(x, y);
      PVector dimensions = new PVector(32, 32);

      if (isDist(currentPos, player.position, 40)) {
        //println(player.health);
        player.health--;
        y=height;
      }
    }

    void move() {
      y+=speed;
    }

    boolean dead() {
      return y>=height;
    }
  }

  int EBCount; 

  void countEB() {
    for (EBCount = enemyBullets.size()-1; EBCount>=0; EBCount--) {


      EnemyBullet bullet = enemyBullets.get(EBCount);
      bullet.display();
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
