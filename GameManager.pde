class GameManager {
  int playerAScore = 0;
  int playerBScore = 0;
  
  int maxScore;
 
  public GameManager(int maxScore) {
    this.maxScore = maxScore;
  }

  public void drawScore() {
    fill(255);
    textSize(64);
    text(this.playerAScore, 64, 60);
    text(this.playerBScore, width - 128, 60);
  }
  
}
