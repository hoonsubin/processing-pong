class Puck extends GameObject {
  
  public Puck(int x, int y, float size){
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
    this.x = width / 2 + random(-100, 100);
    this.y = height / 2 + random(-100, 100);
    this.speedX = random(-10, 10);
    this.speedY = random(-10, 10);
  }

  public boolean isCollidingWithGoal() {
    // when colliding with the goal, reset the puck
    if (this.x - this.size / 2 < 0 || this.x + this.size / 2 > width) {

      return true;
    }
    return false;
  }

  public boolean isCollidingWithOtherPuck(Puck puck) {
    // check if the puck is colliding with the paddle
    float distance = dist(this.x, this.y, puck.x, puck.y);
    return distance < size / 2 + puck.size / 2;
  }

  public boolean isCollidingWithItem(Item item) {
    // check if the puck is colliding with an item
    if (this.x + this.size / 2 > item.x && this.x - this.size / 2 < item.x + item.size) {
      if (this.y + this.size / 2 > item.y && this.y - this.size / 2 < item.y + item.size) {
        return true;
      }
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

  public void batCollision() {
    this.speedX *= -1;

    // add some randomness to the bounce
    this.speedX += random(0.1, 1);
  }
}
