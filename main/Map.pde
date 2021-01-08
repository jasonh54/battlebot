class Map {
  //variables
  int x;
  int y;
  int speedx;
  int speedy;
  int colsize;
  int rowsize;
  int overlapint;
  
  final int tileh = 16;
  final int tilew = 16;
  final int tilehh = tileh/2;
  final int tileww = tilew/2;
  char currentKey = ' ';
  int framecounter = 0;
  boolean lock = false;
  
  final int mapscale = 2;
  private int[][] tileArray;
  private Tile [][] mapTiles;
  ArrayList<Tile> collidableTiles = new ArrayList<Tile>();
  ArrayList<Tile> portalTiles = new ArrayList<Tile>();
  ArrayList<Tile> grassTiles = new ArrayList<Tile>();

  //for default maps that need an overlay
  public Map(OverlayMap overlay) {
    
  }
  
  //for overlay maps
  public Map() {
  
  }

  //map generation v2 (working)
  void generateBaseMap(int[][] tileArray) {
    this.tileArray = tileArray;
    //counters for dimensions of tileArray AND mapTiles
    int incount1 = 0;
    int incount2 = 0;
    colsize = tileArray.length;
    rowsize = tileArray[0].length;
    mapTiles = new Tile[colsize][rowsize];
    //temporary tiles to store data
    //Tile prev = new Tile();
    //Tile current;
    //first loop: create first tile in a row
    for (int row = 0; row < rowsize; row++) {
      for(int col = 0; col < colsize; col++){
        if(tileArray[row][col]!=486){
          Tile current = new Tile((tilew * mapscale) * col + tileww * mapscale, (tileh * mapscale) * row + tilehh * mapscale, false, false, tiles[tileArray[row][col]], mapscale);
          current.collide = binarySearch(collidableSprites, tileArray[row][col], 0, collidableSprites.length - 1);
          loadCollide(current);
          current.portal = binarySearch(portalSprites, tileArray[row][col], 0, portalSprites.length - 1);
          loadPortal(current);
          current.grass = binarySearch(grassSprites, tileArray[row][col], 0, grassSprites.length - 1);
          loadGrass(current);
          mapTiles[row][col] = current;
        }
      }
    }
      
  }

  void draw() {
    for (int i = 0; i < colsize; i++) {
      for (int k = 0; k < rowsize; k++) {
        if(tileArray[i][k] != 486){
          mapTiles[i][k].draw();
        }  
      }
    }
  }

  //add tiles to various type-oriented arraylists
  /* void loadAll (Tile tile) {
    
  } */
  
  void loadCollide(Tile tile) {
    if (tile.collide == true) {
      collidableTiles.add(tile);
    }
  }
  
  void loadPortal(Tile tile) {
    if (tile.portal == true) {
      portalTiles.add(tile);
    }
  }
  
  void loadGrass(Tile tile) {
    if (tile.grass == true) {
      grassTiles.add(tile);
    }
  }
  

  //ALWAYS set min = 0 and max = [array].length - 1
  //for sorting tiles into types
  boolean binarySearch(int[] arr, int goal, int min, int max) {
    int index = (min + max)/2;
    if (min > max) {
      return false;
    }
    if (arr[index] == goal) {
      return true;
    } else if (arr[index] < goal) {
      return binarySearch(arr, goal, index + 1, max);
    } else if (arr[index] > goal) {
      return binarySearch(arr, goal, min, index - 1);
    }
    return false;
  }

  //update loop
  void update() {
    //draw
    this.draw();
    this.fullMovement();
    
  }

  //BASE MOVEMENT THINGS
  void fullMovement() {
    //reset collision
    collidemap.leftcollidetracker = false;
    collidemap.rightcollidetracker = false;
    collidemap.upcollidetracker = false;
    collidemap.downcollidetracker = false;
    //when key is first pressed
    if (keyPressed == true && lock == false) {
      //if it's a movement key
      if(((key == 'w' && collidemap.collideUp(testPlayer) == false) || (key == 's' && collidemap.collideDown(testPlayer) == false) || (key == 'a' && collidemap.collideLeft(testPlayer) == false) || (key == 'd' && collidemap.collideRight(testPlayer) == false))) {
        //if a new movement needs to start
        lock = true;
        newMove(key);
      }
    }
    
    //if movement is occuring
    if (lock == true) {
      framecounter++;
      if (getCurrentKey() == 'w') {
        moveUp();
      } else if (getCurrentKey() == 's') {
        moveDown();
      } else if (getCurrentKey() == 'a') {
        moveLeft();
      } else if (getCurrentKey() == 'd') {
        moveRight();
      }
      
      //when movement is finished
      if (framecounter == 8) {
        lock = false;
        framecounter = 0;
        //will need a checkoverlap for every type of important tiles (grass, portals(?), etc)

        if (checkOverlap(portalTiles, testPlayer, "portal underfoot") > 0) {
          //have a variable save portalTiles.get(overlapint);
          //figure out what map is associated with that tile and generate it
        }
        if (checkOverlap(grassTiles, testPlayer, "grass underfoot") > 0) {
          //random chance to activate a battle
          //if chance happens, activate battle state
        }
        stopMove();
      }
    }
  }
  
  void moveUp() {
    for (int i = 0; i < mapTiles.length; i++) {
      for (int k = 0; k < mapTiles[0].length; k++) {
        if(tileArray[i][k] != 486){
          mapTiles[i][k].moveUp();
        }  
      }
    }
  }

  void moveDown() {
    for (int i = 0; i < mapTiles.length; i++) {
      for (int k = 0; k < mapTiles[0].length; k++) {
        if(tileArray[i][k] != 486){
          mapTiles[i][k].moveDown();
        }  
      }
    }
  }

  void moveLeft() {
    for (int i = 0; i < mapTiles.length; i++) {
      for (int k = 0; k < mapTiles[0].length; k++) {
        if(tileArray[i][k] != 486){
          mapTiles[i][k].moveLeft();
        }  
      }
    }
  }

  void moveRight() {
    for (int i = 0; i < mapTiles.length; i++) {
      for (int k = 0; k < mapTiles[0].length; k++) {
        if(tileArray[i][k] != 486){
          mapTiles[i][k].moveRight();
        }  
      }
    }
  }

  void stopMove() {
    for (int i = 0; i < mapTiles.length; i++) {
      for (int k = 0; k < mapTiles[0].length; k++) {
        if(tileArray[i][k] != 486){
          mapTiles[i][k].stopMove();
        }  
      }
    }
  }

  void newMove(char currentKey) {
    this.currentKey = currentKey;
  }

  char getCurrentKey() {
    return currentKey;
  }
  
  //OVERLAP CODE
  int checkOverlap(ArrayList<Tile> array, Player player, String text) {
    for (int i = 0; i < array.size(); i++) {
      if (array.get(i).checkOverlap(player) == true) {
        println(text);
        overlapint = i;
        return overlapint;
      }
    }
    overlapint = -1;
    return overlapint;
  }
}
