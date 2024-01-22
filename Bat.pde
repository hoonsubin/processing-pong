class Bat extends GameObject {
  float thickness;
  
  public Bat(boolean isRight, int y, float size, int w, color objectColor) {
    // size means the length (height) of the bat
    super(isRight ? 0 : width - w, y, size, objectColor);
    this.thickness = w;
  }
  
  public void borderCollision() {
    if (this.y < 0) {
      this.y = 0;
    }
    
    if (this.y + this.size > height) {
      this.y = height - this.size;
    }
  }

  public void move() {
    super.move();
  }
  
  public void drawObject(){
    fill(this.objectColor);
    rect(this.x, this.y, this.thickness, this.size);
  }

  public boolean isColliding(Puck puck) {
    if (puck.x + puck.size / 2 > this.x && puck.x - puck.size / 2 < this.x + this.thickness) {
      if (puck.y + puck.size / 2 > this.y && puck.y - puck.size / 2 < this.y + this.size) {
        return true;
      }
    }
    return false;
  }
  
}
