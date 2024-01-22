class GameObject {
    float x;
    float y;
    float size;
    float speedX;
    float speedY;
    color objectColor;

    public GameObject(int x, int y, float size) {
        this.x = x;
        this.y = y;
        this.speedX = 0;
        this.speedY = 0;
        this.size = size;
        this.objectColor = color(255, 255, 255);
    }

    public GameObject(int x, int y, float size, color c) {
        this.x = x;
        this.y = y;
        this.speedX = 0;
        this.speedY = 0;
        this.size = size;
        this.objectColor = c;
    }

    public GameObject(int x, int y, float speedX, float speedY, float size, color c) {
        if (x < 0 || x > width) {
            this.x = 0;
        }
        else {
            this.x = x;
        }
        if (y < 0 || y > height) {
            this.y = y;
        }
        else {
            this.y = y;
        }
        this.size = size;
        this.speedX = speedX;
        this.speedY = speedY;
        this.objectColor = c;
    }

    public void borderCollision() {}

    public void drawObject() {}

    public void move() {
        this.x += this.speedX;
        this.y += this.speedY;
    }

    public void update() {
        this.move();
        this.borderCollision();
        this.drawObject();
    }
}