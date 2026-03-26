// --- State Management ---
int gameState = 0; // 0 = Menu, 1 = Tables , 2 = Graph

// scene draw funcs.
void drawMenu() {
  fill(0);
  textAlign(CENTER);
  textSize(15);
  text("Main menu", width/2, 80);
  
  btn1.display();
  btn2.display();
}

void drawSceneA() {
  background(100, 150, 250);
  fill(255);
  text("Tables LOADED", width/2, height/2);
  text("Press 'M' to return to menu", width/2, height/2 + 30);
}

void drawSceneB() {
  background(250, 150, 100);
  fill(255);
  text("Graphs LOADED", width/2, height/2);
  text("Press 'M' to return to menu", width/2, height/2 + 30);
}


void keyPressed() {
  if (key == 'm' || key == 'M') {
    gameState = 0; // back to menu
  }
}

// button class
class Button {
  float x, y, w, h;
  String label;
  
  Button(float x, float y, float w, float h, String label) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.label = label;
  }
  
  void display() {
    stroke(0);
    fill(255);
    if (isHovering()) fill(200); // highlight effect
    rect(x, y, w, h, 10);
    
    fill(0);
    textAlign(CENTER, CENTER);
    text(label, x + w/2, y + h/2);
  }
  
  boolean isHovering() {
    return mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h;
  }
  
  boolean isClicked() {
    return isHovering() && mousePressed;
  }
}





