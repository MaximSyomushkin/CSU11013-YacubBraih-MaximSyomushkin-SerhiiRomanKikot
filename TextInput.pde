class TextInput extends Widget {
    private String text;
    private boolean isFocused;
    private String label;
    TextInput(float x, float y, int w, int h, color backgroundColor, String label) {
        super(x, y, w, h, backgroundColor);
        this.text = "";
        this.isFocused = false;
        this.label = label;
    }
    
    @Override
    public void drawWidget() {
        fill(backgroundColor);
        rect(x, y, w, h);
        fill(0);
        textAlign(TOP, LEFT);
        text(label, x + 5, y - 10);
        textAlign(LEFT, CENTER);
        text(text + (isFocused ? "|" : ""), x + 5, y + h / 2);
    }
    
    public void setFocused(boolean focused) {
        this.isFocused = focused;
    }
    
    public void addCharacter(char c) {
        if (isFocused) {
            text += c;
        }
    }
    
    public void removeLastCharacter() {
        if (isFocused && text.length() > 0) {
            text = text.substring(0, text.length() - 1);
        }
    }

    public String getText() {
        return text;
    }
    void handleMousePressed(int mx, int my) {
        if (isClicked(mx, my)) {
            setFocused(true);
        } else {
            setFocused(false);
        }
    }
    void handleKeyPressed(char key, int keyCode) {
        if (isFocused) {
            if (key == BACKSPACE) {
                removeLastCharacter();
            } else if (key != CODED) {
                addCharacter(key);
            }
        }
    }
}