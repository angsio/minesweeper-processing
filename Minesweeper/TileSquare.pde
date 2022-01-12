// tile
class tileSquare {
  // mmm
  int posX = 0;
  int posY = 0;
  
  // empty
  int status = 0;
  
  // rendered
  boolean rendered = false;
  
  // flagged
  boolean flagged = false;
  
  // 0 = empty
  // 1 = 1 mines around
  // ...
  // 8 = 8 mines around (rare)
  // -1 = MINE AHHH
  
  // render unclicked, PURE tile
  void renderPure() {  
    fill(175);
    rect(posX, posY, 25, 25);   
  }
  
  void renderMine() {
    fill(255);
    square(posX, posY, 25);
    fill(0);
    ellipse(posX + 12.5, posY + 12.5, 20, 20);
  }
  
  // renders an open tile with its status. If 0, draws blank instead. If -1, draws mine instead
  void renderStatus() {
    fill(255);
    square(posX, posY, 25);
    fill(0);
    if (status != 0) {
      text(status, posX + 8, posY + 18);
    }
    
    rendered = true;
  }
}
