class Puck extends GameObject {
  
  public Puck(int x, int y, int size){
    super(x, y, random(-10, 10), random(-10, 10), size, color(255, 0, 0));
  }
  
  public void drawObject(){
    fill(this.objectColor);
    circle(this.x, this.y, this.size);
  }

  public void move() {
    super.move();
  }

  public void reset() {
    this.x = width / 2;
    this.y = height / 2;
    this.speedX = random(-10, 10);
    this.speedY = random(-10, 10);
  }

  public boolean isCollidingWithGoal() {
    // when colliding with the goal, reset the puck
    if (this.x - this.size / 2 < 0 || this.x + this.size / 2 > width) {
      //this.speedX *= -1;
      //x = constrain(x, this.size, width - this.size);

      return true;
    }
    return false;
  }

  public void boarderCollision() {
    // bounce the puck off the boarder
    if (this.y - this.size / 2 < 0 || this.y + this.size / 2 > height) {
      
      this.speedY *= -1;
      y = constrain(y, this.size, height - this.size);
    }
  }

  public void ranBounce() {
    this.speedY *= -1;
    this.speedX *= -1;

    // add some randomness to the bounce
    this.speedX += random(0.1, 1);
    this.speedY += random(0.1, 1);
  }
}
