class Item extends GameObject {
    
    
    public Item(float x, float y, float size, int effectIndex) {
        super(int(x), int(y), size);

        switch(effectIndex) {
            case 0:
                this.objectColor = color(124, 76, 107);
                break;
            case 1:
                this.objectColor = color(76, 124, 114);
                break;
        }
    }

    public void drawObject() {
        fill(this.objectColor);
        rect(this.x, this.y, this.size, this.size);
    }
}