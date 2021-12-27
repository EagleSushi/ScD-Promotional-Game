int gameState; 
Start startScreen; Selection selectionScreen; Game gameScreen; End endScreen; 


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
      
    break; 
    case 2: 
      
    break;
    case 3: 
      
    break; 
    case 4:
      
    break; 
  }
}

void GSMouse() {
  
  switch(gameState) {
    case 1: 
      startScreen.mousePressed();
    break; 
    case 2: 
      
    break;
    case 3: 
      
    break; 
    case 4:
      
    break; 
  }
  
}


// start screen class
class Start {
  PVector playButton = new PVector(width/2,height/2);
  PVector exitButton = new PVector(width/2,height/2+250);
  
  void display() {
    renderSelection();
    renderPlay();
    renderExit();
    
  }
  
  void renderPlay() {
    int w = 400;
    int h = 100;
    fill(255);
    rect(playButton.x,playButton.y,w,h);
    
    fill(0);
    text("PLAY",playButton.x-110,playButton.y+20);
  }
  
  void renderExit() {
    int w = 400;
    int h = 100;
    fill(255);
    rect(exitButton.x,exitButton.y,w,h);
    
    fill(0);
    text("EXIT",exitButton.x-90,exitButton.y+20);
  }
  
  void renderSelection() {
    int w = 400;
    int h = 100;
    
    int ew = 10;
    
    if(selection() == 1) {
      fill(100);
      rect(playButton.x,playButton.y, w+ew,h+ew);
    } else if (selection() == 2) {
      fill(100);
      rect(exitButton.x,exitButton.y, w+ew,h+ew);
    }
  }
  
  int selection() {
    PVector mousePos = new PVector(mouseX,mouseY);
    
    
    if(mouseX>playButton.x-200 && mouseX<playButton.x+200 && mouseY>playButton.y-50 && mouseY<playButton.y+50) {
      return 1;
    } else if(mouseX>exitButton.x-200 && mouseX<exitButton.x+200 && mouseY>exitButton.y-50 && mouseY<exitButton.y+50) {
      return 2;
    } else {
      return 0;
    }
  }
  
  void mousePressed() {
    if(mouseButton == LEFT) {
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
  
  
}

// select screen class
class Selection {
  void display() {
  }
}

// game screen class
class Game {
  void display() {
  }
}

// end screen class
class End {
  void display() {
  }
}
