class Widget {
    int x, y, w, h;
    color backgroundColor = color(255);
    Widget(int x, int y, int w, int h, color backgroundColor) {
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
        this.backgroundColor = backgroundColor;
    }
    void drawWidget() {
        fill(backgroundColor);
        rect(x, y, w, h);
    }
}