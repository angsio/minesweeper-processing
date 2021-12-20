boolean started = false;

int sizeX = 100;
int sizeY = 100;

int howManyRendered = 0;

int gameState = 0;

// the MAINFRAME has been INITIALIZED, WOOOO
Functionality system = new Functionality();

// size
void settings() {
  size(sizeX + 1, sizeY + 1);
  
}

void setup() {
  
}

// draw
void draw() {

}

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
  
  // its empteh, or is it?
  void renderStatus() {
    fill(255);
    rect(posX, posY, 25, 25);
    fill(0);
    if (status != 0) {
      text(status, posX + 8, posY + 18);
      
      if (status == -1) {
        ellipse(posX + 12.5, posY + 12.5, 20, 20);
      }
    }
    
    rendered = true;
  }
}

// click
void mousePressed() {
  
  if (started) {
    for (int sMP = 0; sMP < system.tiles.length; sMP++) {
      if (mouseX > system.tiles[sMP].posX && mouseX < system.tiles[sMP].posX + 25 && mouseY > system.tiles[sMP].posY && mouseY < system.tiles[sMP].posY + 25 && system.tiles[sMP].flagged == false && system.tiles[sMP].rendered == false) {
        println("Tile " + (sMP + 1) + " has been clicked");
        
        // if click on  mine, exit the app (temporary, will implement game states later)
        if (system.tiles[sMP].status == -1) {
          system.tiles[sMP].renderStatus();
          
        }
        
        //else if (system.tiles[sMP].status == 0) {
        
        //}
        
        // if clicked on anything but a mine, a tile was clicked and the counter increases
        else {
          system.tiles[sMP].renderStatus();
          howManyRendered++;
        }

        // if clicked on all non-mines, temporary win screen
        if (howManyRendered == system.tiles.length - system.mines.length) {
          background(255);
          text("nice you win bruvva", 25, 25);
        }
        
        break;
      }
    }
  }
  
  else {
    
    // add the objects to array to use below
    system.addTileSquares();
    
    for (int i = 0; i < sizeX/25; i++) {
      
      for (int  j = 0; j < sizeY/25; j++) {
        
        int wtf = ( j + (i * (sizeY / 25)) );
        
        system.tiles[wtf].posX = i*25;
        system.tiles[wtf].posY = j*25;
        system.tiles[wtf].renderPure();
      }
    }
    
    system.makeMines();
    
    system.primeMines();
    
    system.setTiles();
  
    started = true;
    
  }
}


class Functionality {
  tileSquare[] tiles = new tileSquare[(sizeX / 25) * (sizeY / 25)];
  
  int[] mines = new int[4];
  
  // add tile objects to tiles array
  void addTileSquares() {
    for (int indexOfTiles = 0; indexOfTiles < tiles.length; indexOfTiles++) {
      tiles[indexOfTiles] = new tileSquare();
    }
  }
  
  void makeMines() {
    
    // 2x2 is 4 mines.
    
    // random number between 0 and however many tiles there are
    int rand;
    
    // What To Choose From. Array of available tiles, all to choose from in the start.
    int[] wTCF = new int[(sizeX / 25) * (sizeY / 25)];
    
    // EX: choose from 4 tiles
    
    // adds actual numbers to declared array.
    for (int m = 0; m < wTCF.length; m ++) {
      wTCF[m] = m;
    }
    
    // wTCF = {0, 1, 2, 3};
    
    for (int L = 0; L < mines.length; L++) {
      
      // chooses random index
      rand  = int(random(0, wTCF.length));
      
      // sets mine tile in array as index
      mines[L] = wTCF[rand];
      
      // creates new array thats one shorter in length
      int[] newWtcf = new int[wTCF.length - 1];
      
      // What I need:
      // wTCF = {0, 1, 2, 3};
      
      // starts at first index, goes up until the length of the new array
      for (int h = 0, t = 0; h < wTCF.length; h++) {
        
        // if the index was the index that was chosen last time, skip it
        
        // if h == 1
        if (h == rand) {
          continue;
        }
        
        // wTCF = {0, 1, 2, 3};
          
        // newWtcf
        newWtcf[t++] = wTCF[h];
      }
      
      wTCF = newWtcf;
    }
    println(sort(mines));
  }
  
  void primeMines() {
    for (int g = 0; g < mines.length; g++) {
      tiles[ (mines[g]) ].status = -1;
    }  
  }
  
  void setTiles() {
    
    for (int f = 0; f < tiles.length; f++) {
      if (tiles[f].status == -1) {
        continue;
      }
      
      scanTiles(f, "mines");
    }
  }
  
  // WTSF = mines means to scan for mines
  // WTSF = blanks means to scan for blank tiles
  void scanTiles(int tileIndex, String wTSF) {
    int scanner = tileIndex - (sizeY/25) - 1;
      
      // dont even question it, simply accept it
      
      // example if 5, goes while less than 14 
      for (int i = scanner; i < scanner + (2*(sizeY/25) + 1); i += sizeY/25) {
        
        // scales from 0 to 2
        for (int j = 0; j < 3; j++) {
          
          if (i + j < 0 || i + j > tiles.length - 1 || ((tileIndex + 1) % (sizeY/25) == 0 && j == 2) || (tileIndex % (sizeY/25) == 0 && j == 0)) {
            continue;
          }
          
          if (wTSF == "mines" && tiles[i + j].status == -1) {
            tiles[tileIndex].status++;
          }
          else if (wTSF == "blanks" && tiles[i + j].status == 0) {
            tiles[i + j].renderStatus();
          }
        }
      }
  }
}


void keyPressed() {
  
  if (keyCode == TAB) {
    for (int m = 0; m < system.tiles.length; m++) {
      if (mouseX > system.tiles[m].posX && mouseX < system.tiles[m].posX + 25 && mouseY > system.tiles[m].posY && mouseY < system.tiles[m].posY + 25) {
        
        
        // flag a tile
        if (system.tiles[m].rendered == false && system.tiles[m].flagged == false) {
          fill(0);
          square(system.tiles[m].posX + 6, system.tiles[m].posY + 6, 12.5);
          system.tiles[m].flagged = true;
        }
        
        
        // unflag a tile
        else if (system.tiles[m].flagged && system.tiles[m].rendered == false) {
          fill(175);
          system.tiles[m].renderPure();
          system.tiles[m].flagged = false;
        }
      }
    }
  }
}
