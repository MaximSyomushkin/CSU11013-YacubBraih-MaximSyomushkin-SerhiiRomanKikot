/*
    Implemented by: Maxim Syomushkin
    Vertical scrollbar widget for scrolling content vertically
*/
class VScrollbar extends Widget {

  float spos, newspos;
  float sposMin, sposMax;
  int loose;
  boolean over;
  boolean locked;
  float ratio;

  VScrollbar (float xp, float yp, int sw, int sh, int l) {
    super(xp, yp, sw, sh, color(50));

    int heighttowidth = sh - sw;
    ratio = (heighttowidth > 0) ? (float)sh / (float)heighttowidth : 1.0;

    sposMin = y;
    sposMax = y + h - w; // квадратный ползунок высотой w

    spos = sposMin;
    newspos = spos;

    loose = max(1, l);
  }

  void update() {
    sposMin = y;
    sposMax = y + h - w;
    spos = constrain(spos, sposMin, sposMax);
    newspos = constrain(newspos, sposMin, sposMax);

    over = overEvent();

    if (locked) {
      newspos = constrain(mouseY - w / 2.0, sposMin, sposMax);
    }

    if (abs(newspos - spos) > 0.1) {
      spos += (newspos - spos) / loose;
    } else {
      spos = newspos;
    }
  }

  float constrain(float val, float minv, float maxv) {
    return min(max(val, minv), maxv);
  }

  boolean overEvent() {
    return (mouseX > x && mouseX < x + w &&
            mouseY > y && mouseY < y + h);
  }

  void drawWidget() {
    noStroke();
    fill(204);
    rect(x, y, w, h);

    if (over || locked) fill(0);
    else fill(102);

    rect(x, spos, w, w);
  }

  void handleMousePressed(int mouseX, int mouseY) {
    if (isClicked(mouseX, mouseY)) {
      locked = true;
    }
  }

  void handleMouseReleased(int mouseX, int mouseY) {
    locked = false;
  }

  void handleMouseDragged(float mouseX, float mouseY) {
    if (locked) {
      newspos = constrain(mouseY - w / 2.0, sposMin, sposMax);
    }
  }

  void scrollByWheel(float deltaSteps) {
    newspos = constrain(newspos + deltaSteps * 20, sposMin, sposMax);
  }
}