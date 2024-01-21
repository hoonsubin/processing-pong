class GameManager {
  int playerAScore = 0;
  int playerBScore = 0;
  Puck[] pucks;
  Bat batA, batB;
  
  int maxScore;
 
  public GameManager(int maxScore, Puck[] pucks, Bat batA, Bat batB) {
    this.maxScore = maxScore;
    this.pucks = pucks;
    this.batA = batA;
    this.batB = batB;
  }

  public void addScore(boolean addForPlayerA) {
    if (this.playerAScore > this.maxScore || this.playerBScore > this.maxScore) {
      return;
    }
    if (addForPlayerA) {
      this.playerAScore++;
    } else {
      this.playerBScore++;
    }
  }

  public void drawScore() {
    fill(255);
    textSize(64);
    if (playerAScore >= this.maxScore) {
      text("Player A wins!", width / 2 - 200, height / 2);
    } else if (playerBScore >= this.maxScore) {
      text("Player B wins!", width / 2 - 200, height / 2);
    }
    else {
      text(this.playerAScore, 64, 60);
      text(this.playerBScore, width - 128, 60);
    }
    
  }

  public void update() {
    for (int i = 0; i < pucks.length; i++) {
      // update pucks and bat update
      if (!this.isGameOver()) {
        pucks[i].update();
        batA.update();
        batB.update();
      }

      // handle bat collisions
      if (batA.isColliding(pucks[i]) || batB.isColliding(pucks[i])) {
        pucks[i].batCollision();
      }

      // handle puck collisions
      for (int j = i + 1; j < pucks.length; j++) {
        if (pucks[i].isCollidingWithOtherPuck(pucks[j])) {
          // Perform collision response between pucks[i] and pucks[j]
          pucks[i].batCollision();
          pucks[j].batCollision();
        }
      }

      // handle points
      if (!this.isGameOver() && pucks[i].isCollidingWithGoal())
      {
        if (pucks[i].x >= width / 2) {
          this.playerAScore++;
        }
        else {
          this.playerBScore++;
        }
        pucks[i].reset();
      }
    }
  }

  public boolean isGameOver() {
    return this.playerAScore >= this.maxScore || this.playerBScore >= this.maxScore;
  }

  public void resetGame() {
    this.playerAScore = 0;
    this.playerBScore = 0;
  }
  
}
