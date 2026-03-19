/**
 * Scrollbar.
 *
 * Move the scrollbars left and right to change the positions of the images.
 */

//True if a mouse button was pressed while no other button was.
class VScrollbar extends Widget {

  float spos, newspos;    // x position of slider
  float sposMin, sposMax; // max and min values of slider
  int loose;              // how loose/heavy
  boolean over;           // is the mouse over the slider?
  boolean locked;
  float ratio;
  boolean firstMousePress;

  VScrollbar (float xp, float yp, int sw, int sh, int l) {
    super (xp, yp-sh/2, sw, sh, color (50));
    int heighttowidth = sh - sw;
    ratio = (float)sh / (float)heighttowidth;
    spos = y + h/2 - w/2;
    newspos = spos;
    sposMin = y;
    sposMax = y + h - w;
    loose = l;
  }

  void update() {
    if (overEvent()) {
      over = true;
    } else {
      over = false;
    }
    if (firstMousePress && over) {
      locked = true;
    }
    if (!mousePressed) {
      locked = false;
    }
    if (locked) {
      newspos = constrain(mouseY-w/2, sposMin, sposMax);
    }
    if (abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos)/loose;
    }
  }

  float constrain(float val, float minv, float maxv) {
    return min(max(val, minv), maxv);
  }

  boolean overEvent() {
    if (mouseX > x && mouseX < x+w &&
      mouseY > y && mouseY < y+h) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    noStroke();
    fill(204);
    rect(x, y, w, h);
    if (over || locked) {
      fill(0, 0, 0);
    } else {
      fill(102, 102, 102);
    }
    rect(x, spos, w, w);
  }

  float getPos() {
    // Convert spos to be values between
    // 0 and the total width of the scrollbar
    return spos * ratio;
  }
}
