class Button extends Widget {
    private String label;
    Button(float x, float y, int w, int h, color backgroundColor, String label) {
        super(x, y, w, h, backgroundColor);
        this.label = label;
    }
    
    @Override
    public void drawWidget() {
        fill(backgroundColor);
        rect(x, y, w, h);
        fill(0);
        textAlign(CENTER, CENTER);
        text(label, x + w / 2, y + h / 2);
    }
}