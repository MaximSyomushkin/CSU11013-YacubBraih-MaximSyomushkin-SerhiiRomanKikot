/*
    Implemented by: Serhii-Roman Kikot
    Group widget for managing multiple text inputs and focus state
*/
class TextInputGroup extends Widget {

    ArrayList<TextInput> inputs;
    int currentFocusedIndex = -1;

    // Initializes the text input group container
    TextInputGroup(float x, float y, int w, int h, color backgroundColor) {
        super(x, y, w, h, backgroundColor);
        this.inputs = new ArrayList<>();
    }

    // Adds a text input to the group
    void addTextInput(TextInput input) {
        this.inputs.add(input);
    }

    // Draws all text inputs in the group
    @Override
    void drawWidget() {
        for (int i = 0; i < inputs.size(); i++) {
            inputs.get(i).drawWidget();
        }
    }

    // Updates focus based on mouse click position
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

    // Forwards key input to the currently focused text input
    void handleKeyPressed(char key, int keyCode) {
        if (currentFocusedIndex != -1) {
            inputs.get(currentFocusedIndex).handleKeyPressed(key, keyCode);
        }
    }
}
