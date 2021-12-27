/**
 This is where gameStates mainly are
 As of writing this, there are only 4 gameStates, start, selection, game, and end.
 **/


int gameState; 
Start startScreen; 
Selection selectionScreen; 
Game gameScreen; 
End endScreen; 


//constantly selects which class to display depending on the current game state 
void gameStateChooser() {

  switch(gameState) {
  case 1: 
    startScreen.display(); 
    break; 
  case 2: 
    selectionScreen.display();
    break;
  case 3: 
    gameScreen.display();
    break; 
  case 4:
    endScreen.display(); 
    break;
  }
}

//mouse and keyPressed for gameStates

void GSKeys() {
  switch(gameState) {
  case 1: 
    startScreen.keyPressed(); 
    break; 
  case 2: 
    selectionScreen.keyPressed(); 
    break;
  case 3: 
    gameScreen.keyPressed(); 
    break; 
  case 4:
    endScreen.keyPressed(); 
    break;
  }
}

void GSMouse() {

  switch(gameState) {
  case 1: 
    startScreen.mousePressed();
    break; 
  case 2: 
    selectionScreen.mousePressed();
    break;
  case 3: 
    gameScreen.mousePressed();
    break; 
  case 4:
    endScreen.mousePressed();
    break;
  }
}


// start screen class
class Start {
  PVector playButton = new PVector(width/2, height/2);
  PVector exitButton = new PVector(width/2, height/2+250);

  void display() {
    renderSelection();
    renderPlay();
    renderExit();
  }

  void renderPlay() {
    int w = 400;
    int h = 100;
    fill(255);
    rect(playButton.x, playButton.y, w, h);

    fill(0);
    text("PLAY", playButton.x-110, playButton.y+20);
  }

  void renderExit() {
    int w = 400;
    int h = 100;
    fill(255);
    rect(exitButton.x, exitButton.y, w, h);

    fill(0);
    text("EXIT", exitButton.x-90, exitButton.y+20);
  }

  void renderSelection() {
    int w = 400;
    int h = 100;

    int ew = 10;

    if (selection() == 1) {
      fill(100);
      rect(playButton.x, playButton.y, w+ew, h+ew);
    } else if (selection() == 2) {
      fill(100);
      rect(exitButton.x, exitButton.y, w+ew, h+ew);
    }
  }

  int selection() {
    PVector mousePos = new PVector(mouseX, mouseY);


    if (mouseX>playButton.x-200 && mouseX<playButton.x+200 && mouseY>playButton.y-50 && mouseY<playButton.y+50) {
      return 1;
    } else if (mouseX>exitButton.x-200 && mouseX<exitButton.x+200 && mouseY>exitButton.y-50 && mouseY<exitButton.y+50) {
      return 2;
    } else {
      return 0;
    }
  }

  void mousePressed() {
    if (mouseButton == LEFT) {
      switch(selection()) {
      case 1: 
        gameState = 2; 
        break; 
      case 2: 
        exit(); 
        break;
      }
    }
  }

  void keyPressed() {
  }
}

// select screen class
class Selection {
  PImage[] characters = new PImage[4];
  PImage[] names = new PImage[4]; 
  int selection; 

  Selection() {
    selection = 0; 

    characters[0] = loadImage("data/visuals/characters/EagleSushi.png");
    characters[1] = loadImage("data/visuals/characters/director_dylan.png");
    characters[2] = loadImage("data/visuals/characters/Feuerfly.png");
    characters[3] = loadImage("data/visuals/characters/SuperMartian.png");

    for (int i = 0; i<names.length; i++) {
      names[i] = loadImage("data/visuals/gui/name_"+i+".png");
    }

    for (int i = 0; i<characters.length; i++) {
      characters[i].resize(128, 128);
    }
  }

  void display() {
    image(characters[selection], width/2, height/2);
    mouseSector();
    fill(255);
    renderName();
  }

  int mouseSector() {

    fill(#858586);
    if (mouseY<=height/2-100) {
      triangle(width/2, height/2-150, width/2-60, height/2-100, width/2+60, height/2-100);
      return 1;
    } else if (mouseY>=height/2+100) {
      triangle(width/2, height/2+200, width/2-60, height/2+150, width/2+60, height/2+150);
      return 3;
    } else {
      return 2;
    }
  }

  void renderName() {
    fill(255); 
    rect(width/2, height/2-250, 400, 100);
    image(names[selection], width/2, height/2-250);
  }

  void mousePressed() {
    PVector mousePos = new PVector(mouseX, mouseY); 
    PVector tarPos = new PVector(width/2, height/2);
    if (mouseButton == LEFT) {

      if (isDist(mousePos, tarPos, 64)) {
        player.character = selection;

        switch(selection) {
        default: 
          player.cooldown = 20;
          player.damage = 10;
          break;
        case 0: 
          player.cooldown = 15;
          player.damage = 40;
          break;
        case 1: 
          player.cooldown = 7;
          player.damage = 20;
          break;
        case 2:
          player.cooldown = 7;
          player.damage = 20;
          break;
        case 3:
          player.cooldown = 15;
          player.damage = 40;
          break;
        }

        gameState=3;
      }

      switch(mouseSector()) {
      case 1: 

        if (selection == 0 ) {
          selection = 3;
        } else {
          selection-=1;
        }
        break;
      case 3:
        if (selection == 3 ) {
          selection = 0;
        } else {
          selection+=1;
        }
        break;
      }
    }
  }

  void keyPressed() {
  }
}

// game screen class
class Game {
  
  int cd=10;
  int enemyCD=0; 
  //int currentEnemies = 0; 

  Game() {
  }

  void display() {
    player.display(); 
    countBullets();
    countEnemies();
    
    
    if(enemies.size()<=0) {
      spawnEnemies(int(random(5,40))); 
    }
    
    
  }
  
  void spawnEnemies(int number) {
    for(int i = 0; i<number;i++) {
      enemies.add(new Enemy());
      
    }
  }
  
  void mousePressed() {
    player.mousePressed();
  }

  void keyPressed() {
  }
}

// end screen class
class End {

  void display() {
  }

  void mousePressed() {
  }

  void keyPressed() {
  }
}
