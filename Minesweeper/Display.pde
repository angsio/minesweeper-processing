class Display {
  
  boolean toggledFR = true;
  boolean toggledTime = true;
  
  boolean update = false;
  
  int time = millis();
  
  void toggleFR() {
    
    if (toggledFR) { toggledFR = false; }
    else { toggledFR = true; }
    
  }
  
  void toggleTime() {
  
    if (toggledTime) { toggledTime = false; }
    else { toggledTime = true; }
    
  }
  
  void updateDisplays(int minesInt) {
    if (update) {
      fill(175);
      stroke(0);
      strokeWeight(1);
      rect(0, sizeY, sizeX, sizeY + 21);
      
      
      if (toggledFR) {
        fill(0);
        text("Flags: " + (minesInt - howManyFlags), 25, sizeY + 15);
      }
      
      if (toggledTime) {
        fill(0);
        text("Time: " + ((millis() - time) / 1000), sizeX - 75, sizeY + 15);
      }
    }
  }
}
