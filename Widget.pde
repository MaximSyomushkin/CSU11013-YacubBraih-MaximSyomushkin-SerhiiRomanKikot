/*
    Implemented by: Serhii-Roman Kikot
    Base UI widget class with common drawing and event methods
*/
class Widget {
    float x, y;
    int w, h;
    color backgroundColor = color(255);

    // Initializes widget position, size, and background color
    Widget(float x, float y, int w, int h, color backgroundColor) {
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
        this.backgroundColor = backgroundColor;
    }

    // Draws widget as a rectangle
    void drawWidget() {
        fill(backgroundColor);
        rect(x, y, w, h);
    }

    // Handles mouse press event (default: no action)
    void handleMousePressed(int mx, int my) {
        return;
    }

    // Handles mouse release event (default: no action)
    void handleMouseReleased(int mx, int my) {
        return;
    }

    // Handles mouse drag event (default: no action)
    void handleMouseDragged(int mx, int my) {
        return;
    }

    // Handles key press event (default: no action)
    void handleKeyPressed(char key, int keyCode) {
        return;
    }

    // Checks if mouse coordinates are inside widget bounds
    boolean isClicked(int mx, int my) {
        return mx >= x && mx <= x + w && my >= y && my <= y + h;
    }

    // Updates widget position
    void setPosition(float newX, float newY) {
        this.x = newX;
        this.y = newY;
    }
}
