class GameManager {
  int playerAScore = 0;
  int playerBScore = 0;
  Puck[] pucks;
  Bat batA, batB;
  
  int maxScore;

  Grid[][] itemGrid;
 
  public GameManager(int maxScore, Puck[] pucks, Bat batA, Bat batB) {
    this.maxScore = maxScore;
    this.pucks = pucks;
    this.batA = batA;
    this.batB = batB;

    // init item grid
    int gridSize = 64;

    itemGrid = this.createGrid(gridSize);
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
    // update for all pucks
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

    // handle random items
    if (random(1) < 0.3) {
      Item item = this.spawnItemInGrid(this.getRandomSpawnableGrid(), 1);
      item.drawObject();
    }
  }

  public boolean isGameOver() {
    return this.playerAScore >= this.maxScore || this.playerBScore >= this.maxScore;
  }

  public void resetGame() {
    this.playerAScore = 0;
    this.playerBScore = 0;
  }

  private Grid[][] createGrid(int gridSize) {
    Grid[][] grid = new Grid[int(width / gridSize)][int(height / gridSize)];
    // iterate through the grid
    for (int gridX = 0; gridX < grid.length; gridX++) {
      for (int gridY = 0; gridY < grid[0].length; gridY++) {
          // check if the grid position is not on the edge of the grid
          if (gridX < width - gridSize && gridY < height - gridSize) {
            int itemSize = gridSize;
            color itemColor = color(255, 255, 255);
            int itemX = gridX * gridSize;
            int itemY = gridY * gridSize;
            grid[gridX][gridY] = new Grid(itemX, itemY, itemSize);
          }
      }
    }
    return grid;
  }

  public Grid getRandomSpawnableGrid() {
    // grid divider to prevent spawning items on the edge of the grid closer to the bat
    int playSpaceGridDiv = (this.itemGrid.length - 1) / 3;

    int startCol = playSpaceGridDiv;
    int endCol = (this.itemGrid.length - 1) - playSpaceGridDiv;

    return this.itemGrid[(int)random(startCol, endCol)][(int)random(0, this.itemGrid[0].length - 1)];
  }

  public Item spawnItemInGrid(Grid grid, int itemType) {
    return new Item((float)grid.x, (float)grid.y, random(32, grid.size), itemType);
  }
}
