class GameManager {
  int playerAScore = 0;
  int playerBScore = 0;
  Puck[] pucks;
  Bat batA, batB;
  
  int maxScore;

  Grid[][] itemGrid;

  int lastSpawnTime;

  int itemSpawnInterval = 5000;

  ArrayList<Item> activeItems;
 
  public GameManager(int maxScore, Puck[] pucks, Bat batA, Bat batB) {
    this.maxScore = maxScore;
    this.pucks = pucks;
    this.batA = batA;
    this.batB = batB;

    this.lastSpawnTime = millis();

    // init item grid
    int gridSize = 64;

    itemGrid = this.createGrid(gridSize);

    activeItems = new ArrayList<Item>();
    activeItems.add(this.spawnItemInGrid(this.getRandomSpawnableGrid(), 0));
  }

  public void drawScore() {
    textSize(64);
    fill(random(255), random(255), random(255));
    if (playerAScore >= this.maxScore) {
      
      text("Player A wins!", width / 2 - 200, height / 2);
    } else if (playerBScore >= this.maxScore) {
      text("Player B wins!", width / 2 - 200, height / 2);
    }
    else {
      fill(255);
      text(this.playerAScore, 64, 60);
      text(this.playerBScore, width - 128, 60);
    }
    
  }

  public void update() {
    if (this.isGameOver()) {
      return;
    }
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

    // handle random item spwaning
    int maxItems = 5;
    int now = millis();

    for (int i = 0; i < maxItems; i++) {
      if (activeItems.size() < maxItems && now - this.lastSpawnTime >= this.itemSpawnInterval) {
        if (random(1) < 0.3) {
          activeItems.add(this.spawnItemInGrid(this.getRandomSpawnableGrid(), (int)random(0, 2)));
          this.lastSpawnTime = now;
        }
      }
    }

    if (activeItems.size() <= 0) {
      return;
    }
    // update item behavior
    for (int i = 0; i < activeItems.size(); i++) {
      Item item = activeItems.get(i);
      item.update();
      item.drawObject();
      if (!item.isAlive()) {
        activeItems.remove(i);
      }

      // I know this is repeating from the previous section, but simple is better for now
      for (int j = 0; j < pucks.length; j++) {
        // handle puck collisions
        if (pucks[j].isCollidingWithItem(item)) {
          pucks[j].batCollision();
          activeItems.remove(i);
        }
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
    int gridIndexX = (int)random(startCol, endCol);
    int gridIndexY = (int)random(0, this.itemGrid[0].length - 1);

    // prevent items from spawning in the same grid
    while (!this.isGridFree(gridIndexX, gridIndexY)) {
      gridIndexX = (int)random(startCol, endCol);
      gridIndexY = (int)random(0, this.itemGrid[0].length - 1);
    }

    return this.itemGrid[gridIndexX][gridIndexY];
  }

  public Item spawnItemInGrid(Grid grid, int itemType) {
    return new Item((float)grid.x, (float)grid.y, random(32, grid.size), itemType);
  }

  private boolean isGridFree(int gridX, int gridY) {
    for (int i = 0; i < activeItems.size(); i++) {
      Item item = activeItems.get(i);
      if (item.x == gridX && item.y == gridY) {
        return false;
      }
    }
    return true;
  }
}
