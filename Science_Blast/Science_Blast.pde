Player player; 
PFont font;

void setup() {
  size(700, 1000);
  imageMode(CENTER); 
  rectMode(CENTER); 
  cursor();
  font = createFont("data/visuals/font/pirulen.otf", 64);
  textFont(font);

  gameState = 1; 
  initClasses(); 

  bullets = new ArrayList<Bullet>();
  enemies = new ArrayList<Enemy>();
}

void draw() {
  background(0);
  gameStateChooser();
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
  return dist(first.x, first.y, second.x, second.y);
}

boolean isDist(PVector first, PVector second, float tarDist) {
  return dist(first, second)<=tarDist;
}

float perlin(float minX, float maxX, int time) {
  return map(noise(time),0,1,minX,maxX);
  
}

//key and mousePressed 

void keyPressed() {
  GSKeys();
}

void mousePressed() {
  GSMouse();
}

void mouseReleased() {
  if (gameState == 3) {
    player.mouseReleased();
  }
}
