/*
    Implemented by: Serhii-Roman Kikot
    Dropdown widget for selecting one option from a list
*/
class Select extends Widget {
    ArrayList<Button> buttons;
    boolean isOpen = false;
    String label;
    String selectedOption;

    // Initializes select widget with default selected option
    Select(int x, int y, int w, int h, color bgColor, String selectedOption) {
        super(x, y, w, h, bgColor);
        buttons = new ArrayList<Button>();
        this.selectedOption = selectedOption;
    }

    // Adds a new option button to the dropdown list
    void addOption(String label) {
        float x = this.x;
        float y = this.y + this.h + buttons.size() * (textAscent() + textDescent() + 10);
        int w = this.w;
        int h = (int) (textAscent() + textDescent() + 10);
        Button button = new Button(x, y, w, h, color(180), label);
        buttons.add(button);
    }

    // Draws the select box and visible options if opened
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

    // Opens dropdown or selects option on mouse press
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

    // Finalizes option selection and closes dropdown on mouse release
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

    // Checks click on select box or option buttons when opened
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

    // Checks whether any dropdown option was clicked
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
