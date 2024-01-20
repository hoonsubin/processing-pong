class GameManager {
  int playerAScore = 0;
  int playerBScore = 0;
  
  int maxScore;
 
  public GameManager(int maxScore) {
    this.maxScore = maxScore;
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

  public boolean isGameOver() {
    return this.playerAScore >= this.maxScore || this.playerBScore >= this.maxScore;
  }

  public void resetGame() {
    this.playerAScore = 0;
    this.playerBScore = 0;
  }
  
}
