class Select extends Widget {
    ArrayList<Button> buttons;
    boolean isOpen = false;
    String label;
    String selectedOption;

    Select(int x, int y, int w, int h, color bgColor, String selectedOption) {
        super(x, y, w, h, bgColor);
        buttons = new ArrayList<Button>();
        this.selectedOption = selectedOption;
    }
    void addOption(String label) {
        float x = this.x;
        float y = this.y + this.h + buttons.size() * (textAscent() + textDescent() + 10);
        int w = this.w;
        int h = (int) (textAscent() + textDescent() + 10);
        Button button = new Button(x, y, w, h, color(180), label);
        buttons.add(button);
    }
    
    void drawWidget() {
        if (isOpen) {
            for (Button button : buttons) {
                button.drawWidget();
            }
        }
        fill(this.backgroundColor);
        rect(x, y, w, h);
        fill(0);
        textAlign(CENTER, CENTER);
        text(this.selectedOption, x + w/2, y + h/2);
    }

    void handleMousePressed(int mouseX, int mouseY) {
        if (isOpen) {
            for (Button button : buttons) {
                if (button.isClicked(mouseX, mouseY)) {
                    selectedOption = button.getLabel();
                    return;
                }
            }
        } else {
            if (isClicked(mouseX, mouseY)) {
                isOpen = true;
            }
        }
    }
    void handleMouseReleased(int mouseX, int mouseY) {
        if (isOpen) {
            for (Button button : buttons) {
                if (button.isClicked(mouseX, mouseY)) {
                    selectedOption = button.getLabel();
                    isOpen = false;
                    return;
                }
            }
        }
    }
    @Override
    boolean isClicked(int mouseX, int mouseY) {
        if (isOpen) {
            for (Button button : buttons) {
                if (button.isClicked(mouseX, mouseY)) {
                    return true;
                }
            }
        }
        return super.isClicked(mouseX, mouseY);
    }
    boolean isOptionClicked(int mouseX, int mouseY) {
        if (isOpen) {
            for (Button button : buttons) {
                if (button.isClicked(mouseX, mouseY)) {
                    return true;
                }
            }
        }
        return false;
    }
}
