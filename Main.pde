Puck[] pucks;

Bat batA, batB;

GameManager gameManager;

JSONObject json;

// default bat speed
int batSpeed = 10;

// var init before rendering
void setup() {
  // set the size of the canvas
  size(1280, 720);

  // load the config file
  json = loadJSONObject("config.json");
  batSpeed = json.getInt("batSpeed");
  int batWidth = json.getInt("batWidth");
  int batHeight = json.getInt("batHeight");
  int maxScore = json.getInt("maxScore");
  int puckCount = json.getInt("puckCount");
  
  //puck = new Puck(width / 2, height / 2, 80);

  pucks = new Puck[puckCount];

  int i = 0;

  for (Puck p : pucks) {
    p = new Puck(width / 2, height / 2, random(50, 100));
    pucks[i] = p;
    i++;
  }

  batA = new Bat(true, 0, batWidth, batHeight, color(0, 255, 0));
  batB = new Bat(false, 0, batWidth, batHeight, color(0, 0, 255));

  gameManager = new GameManager(maxScore, pucks, batA, batB);
  
  // create the default font
  textFont(createFont("Roboto-Light.ttf", 36));
}

// draw app graphics
void draw() {
  background(0);
  gameManager.drawScore();
  gameManager.update();
  
  fill(255);
  textSize(16);
  text("Press \"R\" to restart the game", width / 2 - 100, 60);
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
    for (int i = 0; i < pucks.length; i++) {
      pucks[i].reset();
    }
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
