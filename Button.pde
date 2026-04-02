class Button extends Widget {
    private String label;
    color defaultStroke;

    Button(float x, float y, int w, int h, color backgroundColor, String label) {
        super(x, y, w, h, backgroundColor);
        this.label = label;
        color defaultStroke = color(100, 100, 100);
    }
    
    @Override
    public void drawWidget() {
        textAlign(CENTER, CENTER);
        if (isHovered(mouseX, mouseY)) {
            stroke(204, 20, 20);
            fill(100);
            rect(x, y, w, h);            
            fill(0);
            text(label, x + w/2, y + h/2);
            stroke(defaultStroke);
        }
        else
        {
            fill(backgroundColor);
            rect(x, y, w, h);
            fill(0);
            stroke(defaultStroke);
            strokeWeight(0.75);
            text(label, x + w/2, y + h/2);
        }
    }

    public boolean isHovered(int mx, int my) {
        return mx >= x && mx <= x + w && my >= y && my <= y + h;
    }

}