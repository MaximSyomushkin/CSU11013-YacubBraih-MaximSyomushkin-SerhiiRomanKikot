/*
    Implemented by: Serhii-Roman Kikot
    Screen container for managing and rendering UI widgets
*/
class Screen {
    ArrayList<Widget> widgets;

    // Initializes an empty widget list
    Screen() {
        widgets = new ArrayList<Widget>();
    }

    // Adds a widget to the screen
    void addWidget(Widget widget) {
        widgets.add(widget);
    }

    // Draws all widgets on the screen
    void drawScreen() {
        for (Widget widget : widgets) {
            widget.drawWidget();
        }
    }

    // Passes mouse pressed event to all widgets
    void handleMousePressed(int mx, int my) {
        for (Widget widget : widgets) {
            widget.handleMousePressed(mx, my);
        }
    }

    // Passes mouse released event to all widgets
    void handleMouseReleased(int mx, int my) {
        for (Widget widget : widgets) {
            widget.handleMouseReleased(mx, my);
        }
    }

    // Passes mouse dragged event to all widgets
    void handleMouseDragged(int mx, int my) {
        for (Widget widget : widgets) {
            widget.handleMouseDragged(mx, my);
        }
    }

    // Passes key pressed event to all widgets
    void handleKeyPressed(char key, int keyCode) {
        for (Widget widget : widgets) {
            widget.handleKeyPressed(key, keyCode);
        }
    }
}
