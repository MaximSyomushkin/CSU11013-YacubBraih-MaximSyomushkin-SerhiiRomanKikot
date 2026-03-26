
class Screen {
    ArrayList<Widget> widgets;
    Screen() {
        widgets = new ArrayList<Widget>();
    }
    void addWidget(Widget widget) {
        widgets.add(widget);
    }
    void drawScreen() {
        for (Widget widget : widgets) {
            widget.drawWidget();
        }
    }
    void handleMousePressed(int mx, int my) {
        for (Widget widget : widgets) {
            widget.handleMousePressed(mx,my);
        }
    }
    void handleMouseReleased(int mx, int my) {
        for (Widget widget : widgets) {
            widget.handleMouseReleased(mx,my);
        }
    }
    void handleMouseDragged(int mx, int my) {
        for (Widget widget : widgets) {
            widget.handleMouseDragged(mx,my);
        }
    }
    void handleKeyPressed(char key, int keyCode) {
        for (Widget widget : widgets) {
            widget.handleKeyPressed(key, keyCode);
        }
    }
}
