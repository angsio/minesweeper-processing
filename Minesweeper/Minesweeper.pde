boolean started = false;

boolean playing = true;

String result;

int sizeX = 300;
int sizeY = 300;

int howManyFlags = 0;

int howManyRendered = 0;

int gameState = 0;

PImage flag;

// the MAINFRAME has been INITIALIZED, WOOOO
Functionality system = new Functionality();

// Display to show important information
Display display = new Display();

// size
void settings() {
  size(sizeX + 1, sizeY + 21);
  
}

void setup() {
  
  flag = loadImage("minesweeperflag.png");
  
  system.gameSetup();
  
  
}

// draw
void draw() {

  display.updateDisplays(system.mines.length);
  
}

// click
void mousePressed() {
  
  // IF IN-GAME
  if (playing) {
    if (mouseButton == LEFT) {
      for (int sMP = 0; sMP < system.tiles.length; sMP++) {
        if (mouseX > system.tiles[sMP].posX && mouseX < system.tiles[sMP].posX + 25 && mouseY > system.tiles[sMP].posY && mouseY < system.tiles[sMP].posY + 25 && system.tiles[sMP].flagged == false) {
        
          if (!system.tiles[sMP].rendered) {
            
            // if click on  mine, exit the app (temporary, will implement game states later)
            if (system.tiles[sMP].status == -1) {
              system.tiles[sMP].renderMine();
              result = "lose!";
              system.endGame();
            }
            
            // if clicked on blank, use recursion to clear all blanks around it up until a number
            else if (system.tiles[sMP].status == 0) {
              system.scanTiles(sMP, "blanks");
            }
            
            // if clicked on anything but a mine, a tile was clicked and the counter increases
            else {
              system.tiles[sMP].renderStatus();
            }
            
                        
          }
          
          // scans for non-flags to reveal tiles around a square
          else {
            system.scanTiles(sMP, "non-flags");
          }
          
          break;
          
        }
      }
      // counts how many rendered to then match
      howManyRendered = 0;
      
      // always counts if the goal of the game is met
      for (int renders = 0; renders < system.tiles.length; renders++) {
        if (system.tiles[renders].rendered) {
          howManyRendered++;
        }
      }
      // if clicked on all non-mines, temporary win screen
      if (howManyRendered >= system.tiles.length - system.mines.length) {
        result = "win!";
        system.endGame();
      }
      
    }
    
    else if (mouseButton == RIGHT) {
      
      // which tile was clicked mechanic
      for (int m = 0; m < system.tiles.length; m++) {
        if (mouseX > system.tiles[m].posX && mouseX < system.tiles[m].posX + 25 && mouseY > system.tiles[m].posY && mouseY < system.tiles[m].posY + 25) {

          
          // flag a tile
          // tile must not be flagged and must be unrendered
          if (!system.tiles[m].rendered && !system.tiles[m].flagged) {
            image(flag, system.tiles[m].posX + 5, system.tiles[m].posY + 5); // places flag image at tile
            system.tiles[m].flagged = true; // makes it flagged
            howManyFlags++;
          }
          
          
          // unflag a tile
          // tile must be flagged already and unrendered
          else if (system.tiles[m].flagged && !system.tiles[m].rendered) {
            fill(175);
            system.tiles[m].renderPure(); // draws it pure again, hiding status
            system.tiles[m].flagged = false; // turns it into unflagged
            howManyFlags--;
          }
          
          break;
          
        }
      }
    }
    
  }
  
  // IF IN END-SCREEN
  else {
    system.gameSetup();
    playing = true;
  
  }
}
