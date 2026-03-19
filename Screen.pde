
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
}
