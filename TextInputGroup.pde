class TextInputGroup extends Widget {

    ArrayList<TextInput> inputs;
    int currentFocusedIndex = -1;
    TextInputGroup(float x, float y, int w, int h, color backgroundColor) {
        super(x, y, w, h, backgroundColor);
        this.inputs = new ArrayList<>();
    }
    void addTextInput(TextInput input) {
        this.inputs.add(input);
    }
    @Override
    void drawWidget() {
        for (int i = 0; i < inputs.size(); i++) {
            inputs.get(i).drawWidget();
        }
    }
    void handleMousePressed(int mx, int my) {
        for (int i = 0; i < inputs.size(); i++) {
            TextInput input = inputs.get(i);
            if (input.isClicked(mx, my)) {
                input.setFocused(true);
                currentFocusedIndex = i;
            } else {
                input.setFocused(false);
            }
        }
    }
    void handleKeyPressed(char key, int keyCode) {
        if (currentFocusedIndex != -1) {
            inputs.get(currentFocusedIndex).handleKeyPressed(key, keyCode);
        }
    }
}
