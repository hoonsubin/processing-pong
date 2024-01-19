Puck puck;

Bat batA, batB;

GameManager gameManager;

int batSpeed = 10;

// var init before rendering
void setup() {
  // set the size of the canvas
  size(1280, 720);
  
  puck = new Puck(width / 2, height / 2, 80);

  batA = new Bat(true, 0, 200, 60, color(0, 255, 0));
  batB = new Bat(false, 0, 200, 60, color(0, 0, 255));

  gameManager = new GameManager(10);
  
  // Create the font
  textFont(createFont("Roboto-Light.ttf", 36));
}

// draw app graphics
void draw() {
  background(0);
  
  puck.update();
  batA.update();
  batB.update();

  gameManager.drawScore();

  // handle bat collisions
  if (batA.isColliding(puck) || batB.isColliding(puck)) {
    puck.speedX *= -1;
    puck.speedY *= -1;
  }
}

// controls
void keyPressed() {
  // player A controls
  if (key == 'w') {
    batA.speedY -= batSpeed;
  }
  else if (key == 's') {
    batA.speedY += batSpeed;
  }
  else {
    batA.speedY = 0;
  }

  // player B controls
  if (keyCode == UP) {
    batB.speedY -= batSpeed;
  }
  if (keyCode == DOWN) {
    batB.speedY += batSpeed;
  }
}

void keyReleased() {
  // player A controls
  if (key == 'w' || key == 's') {
    batA.speedY = 0;
  }

  // player B controls
  if (keyCode == UP || keyCode == DOWN) {
    batB.speedY = 0;
  }
}