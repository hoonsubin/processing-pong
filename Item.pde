class Item extends GameObject {
    int lifeTime = 5 * 1000;
    int spawnTime;
    
    public Item(float x, float y, float size, int effectIndex) {
        super(int(x), int(y), size);
        this.spawnTime = millis();

        // todo: convert the item effects into a class
        switch(effectIndex) {
            case 0:
                this.objectColor = color(124, 76, 107);
                this.lifeTime = 13 * 1000;
                break;
            case 1:
                this.objectColor = color(76, 124, 114);
                this.lifeTime = 17 * 1000;
                break;
            case 2:
                this.objectColor = color(53, 20, 76);
                this.lifeTime = 23 * 1000;
                break;
        }
    }

    public void drawObject() {
        fill(this.objectColor);
        rect(this.x, this.y, this.size, this.size);
    }

    public boolean isAlive() {
        return millis() - this.spawnTime < this.lifeTime;
    }

    public void update() {
    }
}