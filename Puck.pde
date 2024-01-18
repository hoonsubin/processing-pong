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

  public void boarderCollision() {
    // when colliding with the goal, reset the puck
    if (this.x - this.size / 2 < 0 || this.x + this.size / 2 > width) {
      //this.speedX *= -1;
      //x = constrain(x, this.size, width - this.size);
      x = width / 2;
    }
    
    
    // bounce the puck off the boarder
    if (this.y - this.size / 2 < 0 || this.y + this.size / 2 > height) {
      
      //this.speedY *= -1;
      this.bounce();
      y = constrain(y, this.size, height - this.size);
    }
  }

  public void bounce() {
    this.speedY *= -1;

    // add some randomness to the bounce
    this.speedX += random(-1, 1);
    this.speedY += random(-1, 1);
  }
}
