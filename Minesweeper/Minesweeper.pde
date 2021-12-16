boolean started = false;

int sizeX = 300;
int sizeY = 300;

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
    text(status, posX + 8, posY + 18);
  }
}

// click
void mousePressed() {
  
  if (started) {
    for (int sMP = 0; sMP < system.tiles.length; sMP++) {
      if (mouseX > system.tiles[sMP].posX && mouseX < system.tiles[sMP].posX + 25 && mouseY > system.tiles[sMP].posY && mouseY < system.tiles[sMP].posY + 25) {
        println("Tile " + (sMP + 1) + " has been clicked");

        system.tiles[sMP].renderStatus();
        
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
  
    started = true;
    
  }
}


class Functionality {
  tileSquare[] tiles = new tileSquare[(sizeX / 25) * (sizeY / 25)];
  
  int[] mines = new int[((sizeX / 25) * (sizeY / 25)) / 4];
  
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
}
