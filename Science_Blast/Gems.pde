
ArrayList<Gem> gems;
ArrayList<Health> healthArray;

class Gem {
  PVector startPos, tarPos; 
  float x, y; 
  PImage sprite; 
  int pointValue;

  Gem(PVector startPos_, PVector endPos_, int pointValue_) {

    sprite = loadImage("data/visuals/gems/gem_"+pointValue_+".png");
    pointValue = pointValue_;
    startPos = startPos_; 
    tarPos = endPos_; 
    x = startPos_.x; 
    y = startPos_.y;
  }

  void display() {
    move();
    pushMatrix();
    translate(x, y); 
    image(sprite, 0, 0); 
    popMatrix();

    addPoint();
  }

  void move() {
    float lerp = 0.03;

    x = lerp(x, tarPos.x, lerp);
    y = lerp(y, tarPos.y, lerp);
  }

  void addPoint() {
    PVector currentPos = new PVector(x, y); 

    if (isDist(currentPos, player.position, 60)) {

      gameScreen.score+=pointValue;
      //println(gameScreen.score);
      player.charge++;

      gems.remove(gemCount);
    }
  }
}

int gemCount; 

void countGems() {
  for (gemCount = gems.size()-1; gemCount >=0; gemCount--) {
    Gem gem = gems.get(gemCount); 

    gem.tarPos=player.position;
    gem.display();
  }
}

class Health {
  PVector tarPos;
  float x, y; 
  PImage sprite; 

  Health(PVector startPos_, PVector tarPos_) {
    tarPos = tarPos_;
    x = int(startPos_.x); 
    y = (startPos_.y);

    sprite = loadImage("data/visuals/gems/health.png");
  }

  void display() {
    move();
    addHealth();
    pushMatrix();
    translate(x, y);
    image(sprite, 0, 0);
    popMatrix();
  }

  void addHealth() {
    PVector currentPos = new PVector(x, y); 

    if (isDist(currentPos, player.position, 60) && player.health < 10) {
      player.health++;
      healthArray.remove(healthCount);
    } else if(isDist(currentPos, player.position, 60)) {
      healthArray.remove(healthCount);
    }
  }

  void move() {
    float lerp = 0.02; 

    x = lerp(x, tarPos.x, lerp);
    y = lerp(y, tarPos.y, lerp);
  }
}

int healthCount;

void countHealth() {
  for (healthCount = healthArray.size()-1; healthCount>=0; healthCount--) {
    Health h = healthArray.get(healthCount);
    h.display();
  }
}
