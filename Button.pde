class Button extends Widget {
    private String label;
    Button(float x, float y, int w, int h, color backgroundColor, String label) {
        super(x, y, w, h, backgroundColor);
        this.label = label;
    }
    
    @Override
    public void drawWidget() {
        if (isHovered(mouseX, mouseY)) {
            stroke(204, 20, 20);
            fill(100);
            rect(x, y, w, h);            
            fill(0);
            textAlign(CENTER, CENTER);
            text(label, x + w / 2, y + h / 2);
        }
        else
        {
            fill(backgroundColor);
            rect(x, y, w, h);
            fill(0);
            stroke(204, 102, 0);
            textAlign(CENTER, CENTER);
            text(label, x + w / 2, y + h / 2);
        }
    }

    public boolean isHovered(int mx, int my) {
        return mx >= x && mx <= x + w && my >= y && my <= y + h;
    }

}