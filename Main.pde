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

  gameManager = new GameManager(3);
  
  // create the default font
  textFont(createFont("Roboto-Light.ttf", 36));
}

// draw app graphics
void draw() {
  background(0);

  if (!gameManager.isGameOver()) {
    puck.update();
    batA.update();
    batB.update();
  }

  textFont(createFont("Roboto-Light.ttf", 36));
  gameManager.drawScore();

  textFont(createFont("Roboto-Light.ttf", 16));
  text("Press \"R\" to restart the game", width / 2 - 100, 60);

  // handle bat collisions
  if (batA.isColliding(puck) || batB.isColliding(puck)) {
    puck.ranBounce();
  }

  // handle points
  if (!gameManager.isGameOver() && puck.isCollidingWithGoal())
  {
    if (puck.x >= width / 2) {
      gameManager.playerAScore++;
    }
    else {
      gameManager.playerBScore++;
    }
    puck.reset();
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

  if (key == 'r') {
    gameManager.resetGame();
    puck.reset();
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