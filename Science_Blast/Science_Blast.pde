Player player; 
PFont font;

void setup() {
  size(700,1000);
  imageMode(CENTER); 
  rectMode(CENTER); 
  
  font = createFont("data/visuals/font/pirulen.otf",64);
  textFont(font);
  
  gameState = 1; 
  initClasses(); 
}

void draw() {
  background(0);
  gameStateChooser(); 
  renderCharacters(); 
  
}



//renders enemies and main character 
void renderCharacters() {
  player.display();
}

//initialize classes with one function
void initClasses() {
  player = new Player(); 
  
  startScreen = new Start(); 
  selectionScreen = new Selection(); 
  gameScreen = new Game(); 
  endScreen = new End(); 
}

//improved functions

float dist(PVector first, PVector second) {
  return dist(first.x,first.y,second.x,second.y);
}

boolean isDist(PVector first, PVector second, float tarDist) {
  return dist(first,second)<=tarDist;
}

//key and mousePressed 

void keyPressed() {
  GSKeys(); 
}

void mousePressed() {
  GSMouse();
}
