// handles most processes
class Functionality {
  
  // GAME START FUNCTION
  void gameSetup() {
    
    strokeWeight(1);
    stroke(0);
    
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
    
    
    // MAKE, PRIME, SET <-- how to be dangerous with mines
    system.makeMines();
    
    system.primeMines();
    
    system.setTiles();
  
    started = true;
    
  }
  
  // LITTLE END SCREEN
  void endGame() {
    
    // STOPS FUNCTIONALITY OF GAME
    playing = false;
    
    int rectANGLE_X = (sizeX/2) - (sizeX/5);
    int rectANGLE_Y = (sizeY/2) - (sizeY/5);
    
    // aesthetic
    fill(25, 200, 255, 130);
    stroke(150, 100, 255, 130);
    strokeWeight(4);
    
    // semi-transparent rectangle
    rect(rectANGLE_X, rectANGLE_Y, sizeX/5*2, sizeY/5*2);
    
    fill(0);
    // text in the rectangle
    text("You " + result, rectANGLE_X + 10, rectANGLE_Y + 20);
    if (result == "win!") {
      text("Mines Cleared: " + mines.length, rectANGLE_X + 10, rectANGLE_Y + 40);
    }
    
    
    
   text ("Click to play again.", rectANGLE_X + 10, rectANGLE_Y + 100);
    
    
  }
  
  
  
  
  
  tileSquare[] tiles = new tileSquare[(sizeX / 25) * (sizeY / 25)];
  
  // how many mines you want, put in the second pair of square brackets
  int[] mines = new int[10];
  
  // add tile objects to tiles array
  void addTileSquares() {
    for (int indexOfTiles = 0; indexOfTiles < tiles.length; indexOfTiles++) {
      tiles[indexOfTiles] = new tileSquare();
    }
  }
  
  // updates the mines array to random tiles
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
  }
  
  // sets mines to whatever the array has
  void primeMines() {
    for (int g = 0; g < mines.length; g++) {
      tiles[(mines[g])].status = -1;
    }  
  }
  
  // sets the tiles that are not mines to numbers that match the surrounding quantity of mines
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
    
    int flagChecker = 0;
      
    // dont even question it, simply accept it
      
    // example if 5, goes while less than 14 
    for (int i = scanner; i < scanner + (2*(sizeY/25) + 1); i += sizeY/25) {
      
      // scales from 0 to 2
      for (int j = 0; j < 3; j++) {
        
        if (i + j < 0 || i + j > tiles.length - 1 || ((tileIndex + 1) % (sizeY/25) == 0 && j == 2) || (tileIndex % (sizeY/25) == 0 && j == 0)) {
          continue;
        }
        
        // if scanning for mines and the status of the tile being scanned is -1 (mine) then it will increase the tileIndexes status by 1
        if (wTSF == "mines" && tiles[i + j].status == -1) {
          tiles[tileIndex].status++;
        }
        
        // if scanning for blanks
        
        // i cant even explain this it just works
        else if (wTSF == "blanks") {
          if (tiles[i + j].status == 0 && tiles[i + j].rendered == false) {
            tiles[i + j].renderStatus();
            system.scanTiles(i + j, "blanks");
          }
          tiles[i + j].renderStatus();
          
        }
        
        // SCANS FOR NON-FLAGS TO REVEAL SURROUNDINGS OF A TILE
        else if (wTSF == "non-flags") {
          
          if (tiles[i + j].flagged) { flagChecker++; }
          
          
          if (flagChecker == tiles[tileIndex].status) {
            
            
            // checks again
            for (int h = scanner; h < scanner + (2*(sizeY/25) + 1); h += sizeY/25) {
      
              // scales from 0 to 2
              for (int o = 0; o < 3; o++) {
                
                // doesn't scan out of bounds
                if (h + o < 0 || h + o > tiles.length - 1 || ((tileIndex + 1) % (sizeY/25) == 0 && o == 2) || (tileIndex % (sizeY/25) == 0 && o == 0)) {
                  continue;
                }
            
                // if not flagged and not rendered, reveal it!
                if (!tiles[h + o].flagged && !tiles[h + o].rendered) {
                  
                  // scans tiles if finds a blank after revealing
                  if (tiles[h + o].status == 0) {
                    scanTiles(h + o, "blanks");
                  }
                  
                  else if (tiles[h + o].status != -1) {
                    tiles[h + o].renderStatus();
                  }
                  
                  else {
                    tiles[h + o].renderMine();
                    result = "lose!";
                    endGame();
                  }     
                }
              }
            }      
          }
        }
      }
    }
  }
}
