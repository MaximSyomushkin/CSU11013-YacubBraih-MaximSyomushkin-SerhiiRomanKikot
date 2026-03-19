class HScrollbar extends Widget {

  float spos, newspos;
  float sposMin, sposMax;
  int loose;
  boolean over;
  boolean locked;
  float ratio;
  boolean firstMousePress;
  boolean prevMousePressed;

  HScrollbar (float xp, float yp, int sw, int sh, int l) {
    super(xp, yp - sh/2, sw, sh, color(50));

    int widthtoheight = sw - sh;
    ratio = (widthtoheight > 0) ? (float)sw / (float)widthtoheight : 1.0;

    sposMin = x;
    sposMax = x + w - h;

    spos = sposMin;
    newspos = spos;

    loose = max(1, l);
    prevMousePressed = false;
  }

  void update() {
    sposMin = x;
    sposMax = x + w - h;
    spos = constrain(spos, sposMin, sposMax);
    newspos = constrain(newspos, sposMin, sposMax);

    over = overEvent();

    firstMousePress = mousePressed && !prevMousePressed;

    if (firstMousePress && over) {
      locked = true;
    }
    if (!mousePressed) {
      locked = false;
    }

    if (locked) {
      newspos = constrain(mouseX - h / 2.0, sposMin, sposMax);
    }

    if (abs(newspos - spos) > 0.1) {
      spos += (newspos - spos) / loose;
    } else {
      spos = newspos;
    }

    prevMousePressed = mousePressed;
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

    rect(spos, y, h, h);
  }

  float getPos() {
    return (spos - sposMin) * ratio;
  }

  float getPos01() {
    float range = sposMax - sposMin;
    if (range <= 0) return 0;
    return (spos - sposMin) / range;
  }

  void setPos01(float p) {
    p = constrain(p, 0, 1);
    spos = lerp(sposMin, sposMax, p);
    newspos = spos;
  }
}