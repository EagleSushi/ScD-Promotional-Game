
boolean castBomb;

class Player {
  int character; 
  PImage[] avatar = new PImage[4]; 
  PVector position; 
  boolean left; 

  int cooldown=10;
  int abilityCD;
  int currentCD=0;
  int damage;

  int health;
  int chargeCapacity = 10; 
  int charge; 
  
  boolean ability;

  Player() {
    charge = 0;
    health = 10;
    avatar[0] = loadImage("data/visuals/characters/EagleSushi.png");
    avatar[1] = loadImage("data/visuals/characters/director_dylan.png");
    avatar[2] = loadImage("data/visuals/characters/Feuerfly.png");
    avatar[3] = loadImage("data/visuals/characters/SuperMartian.png");

    character = 0;
    position = new PVector(width/2, 600);
  }

  void display() {
    noCursor();
    //println(player.charge);
    pushMatrix(); 
    translate(position.x, position.y);
    image(avatar[character], 0, 0);
    popMatrix();

    move();

    if (left && currentCD<=0) {
      shoot();
      currentCD = cooldown;
    } 

    if (currentCD>0) {
      currentCD--;
    }
  }

  void shoot() {
    bullets.add(new Bullet(position));
  }



  void move() {
    ellipse(mouseX, mouseY, 10, 10);

    position.x = constrain(mouseX, 64, width-64);
    position.y = constrain(mouseY, height/2+100, height-64);
  }

  void mousePressed() {
    if (mouseButton == LEFT) {
      left = true;
    }

    if (mouseButton == RIGHT) {
      if (charge==chargeCapacity) {
        ability = true; 
      }
    }
  }


  void mouseReleased() {
    if (mouseButton == LEFT) {
      left = false;
    }
  }
}
