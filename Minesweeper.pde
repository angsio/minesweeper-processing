boolean started = false;

int sizeX = 100;
int sizeY = 100;

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
  
  // grey tile
  int status = -2;
  
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
  
  void mineOrNot() {
    if (int(random(0, 10)) == 9) {
      status = 9;
    }
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
    
    // MAKE MINES BABY
    for (int makeMines = 0; makeMines < system.tiles.length; makeMines ++) {
      system.tiles[makeMines].status = int(random(-2, 1));
      println(system.tiles[makeMines].status);
    }
    
    //system.makeMines();
  
    started = true;
    
  }
}


class Functionality {
  tileSquare[] tiles = new tileSquare[(sizeX / 25) * (sizeY / 25)];
  
  // add tile objects to tiles array
  void addTileSquares() {
    for (int indexOfTiles = 0; indexOfTiles < tiles.length; indexOfTiles++) {
      tiles[indexOfTiles] = new tileSquare();
    }
    
    println(tiles.length);
  }
  
  //void makeMines() {
    
  //  // # of mines is half of squares
  //  int[] mines = new int[((sizeX / 25) * (sizeY / 25)) / 2];
    
  //  // 4x4 is 8 mines.
    
  //  // random number between 0 and however many tiles there are
  //  int rand;
    
  //  // What To Choose From. Array of available tiles, all to choose from in the start.
  //  int[] wTCF = new int[(sizeX / 25) * (sizeY / 25)];
    
  //  // choose from 16 tiles
    
  //  // adds actual numbers to declared array.
  //  for (int m = 0; m < wTCF.length; m ++) {
  //    wTCF[m] = m;
  //  }
    
  //  // wTCF = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15};
    
  //  for (int L = 0; L < mines.length; L++) {
      
  //    // chooses random tile, ex 9
  //    rand  = int(random(0, wTCF.length - 1));
      
  //    // chooses 9th index (10th tile)
  //    mines[L] = wTCF[rand];
      
  //    // creates new array thats one shorter in length
  //    int[] newWtcf = new int[wTCF.length - 1];
      
  //    // What I need:
  //    // wTCF = {0, 1, 2, 3, 4, 5, 6, 7, 8, (SKIPS 9 BECAUSE IT WAS CHOSEN) 10, 11, 12, 13, 14, 15}
      
  //    for (int h = 0; h < newWtcf.length; h++) {
  //      if (h == rand) {
  //        continue;
  //      }
  //        // wTCF = {0, 1, 2, 3};
          
  //        // newWtcf
  //        newWtcf[h] = wTCF[h];
  //    }
      
  //    wTCF = newWtcf;
  //  }

  //  println(mines);
  //}
}

//void test(int nMines, int n) {
//  int[] allSquares = new int[n];
//  for (int i = 0; i < n; i++) {
     
//  }
//}
