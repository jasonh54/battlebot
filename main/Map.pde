class Map {
  //generic variables
  int x;
  int y;
  int speedx;
  int speedy;
  int colsize;
  int rowsize;
  int overlapint;

  //variables for the movement
  final int tileh = 16;
  final int tilew = 16;
  final int tilehh = tileh/2;
  final int tileww = tilew/2;
  char currentKey = ' ';
  int framecounter = 0;

  //variables for the map code
  private int[][] tileArray;
  private Tile [][] mapTiles;
  final int mapscale = 2;
  boolean lock = false;

  //arraylists for types of tiles within a map
  ArrayList<Tile> collidableTiles = new ArrayList<Tile>();
  ArrayList<Tile> portalTiles = new ArrayList<Tile>();
  ArrayList<Tile> grassTiles = new ArrayList<Tile>();

  //constructor
  public Map() {
  
  }
  Tile getTile(int lx, int ly){
    return mapTiles[lx][ly];
  }
  
  //map generation
  void generateBaseMap(int[][] tileArray) {
    //prepping the tile array for use
    this.tileArray = tileArray;
    colsize = tileArray.length;
    rowsize = tileArray[0].length;
    //maptiles logs all tiles in the map as a 2d array
    mapTiles = new Tile[colsize][rowsize];
    //navigating the rows
    for (int row = 0; row < rowsize; row++) {
      //navigating the columns
      for(int col = 0; col < colsize; col++){
        //skips transparent tiles
        if(tileArray[row][col]!=486){
          //creates a new tile and assigns values
          Tile current = new Tile((tilew * mapscale) * col + tileww * mapscale, (tileh * mapscale) * row + tilehh * mapscale, false, false, tiles[tileArray[row][col]], mapscale);
          //these code sets all check if the tile fits a certain archetype, as listed
          current.collide = genericCheck(collidableSprites, tileArray, row, col);
          current.portal = genericCheck(portalSprites, tileArray, row, col);
          current.grass = genericCheck(grassSprites, tileArray, row, col);
          //loads tile into all relevant arrays
          loadAll(current);
          //saves the tile to the maptiles and moves on
          mapTiles[row][col] = current;
        }
      }
    }
      
  }

  void draw() {
    //loops through all tiles and draws, skipping transparent tiles because lag
    for (int i = 0; i < colsize; i++) {
      for (int k = 0; k < rowsize; k++) {
        if(tileArray[i][k] != 486){
          mapTiles[i][k].draw();
        }  
      }
    }
  }

  //generic check for whether a tile matches a type
  boolean genericCheck (int[] spriteArray, int[][] arrayoftiles, int row, int col) {
    return binarySearch(spriteArray, arrayoftiles[row][col], 0, spriteArray.length - 1);
  }

  //add tiles to various type-oriented arraylists
  void loadAll (Tile tile) {
    loadCollide(tile);
    loadPortal(tile);
    loadGrass(tile);
  }

  //functions that save the archetypical tiles to their respective special arrays
  //these arrays are used later when checking if the player is near/touching a type of tile
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
  //for sorting tiles into types such as collidable, grass, etc
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
    this.draw();
    this.fullMovement();
    
  }

  //BASE MOVEMENT THINGS
  //all collision tracking is based around the sensing of the collidemap
  //all "default" (non-colliding) maps simply read the collidemap's information and follow its directions
  //there's no reason for any default map to check its own collisions; it only causes problems
  void fullMovement() {
    //resetting each direction's sensor
    collidemap.leftcollidetracker = false;
    collidemap.rightcollidetracker = false;
    collidemap.upcollidetracker = false;
    collidemap.downcollidetracker = false;
    //activates when a key is first pressed
    //the lock is to keep movements contained/not overlapping
    if (keyPressed == true && lock == false) { 
      //activates if it's a movement key
      //makes sure there is no collidable tile in the desired direction
      if(((key == 'w' && collidemap.collideUp(testPlayer) == false) || (key == 's' && collidemap.collideDown(testPlayer) == false) || (key == 'a' && collidemap.collideLeft(testPlayer) == false) || (key == 'd' && collidemap.collideRight(testPlayer) == false))) {
        //locks and begins a new movement
        lock = true;
        newMove(key);
      }
    }
    
    //if movement is occurring at the moment
    if (lock == true) {
      //increases framecounter so this can only occur a certain number of times
      framecounter++;
      //calling movement funcs for tiles
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
        //unlocks movement and resets counter so a new movement can begin
        lock = false;
        framecounter = 0;
        //checking special tile-related conditions and activating events if they are met
        if (checkOverlap(portalTiles, testPlayer, "portal underfoot") >= 0) {
          //have a variable save portalTiles.get(overlapint);
          //figure out what map is associated with that tile and generate it
        }
        if (checkOverlap(grassTiles, testPlayer, "grass underfoot") >= 0) {
          println(GameState.currentState);
          Random r = new Random();
          int t = r.nextInt(7) + 1;
          if (t == 1) {
            GameState.currentState = GameStates.COMBAT;
            GameState.combatState = CombatStates.ENTRY;
            println("battle time!");
          }
          
          //if chance happens, activate battle state
        }
        stopMove();
      }
    }
  }
  
  //individual movement functions - these activate movement funcs in each tile of the map
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

  //ends movement in each tile
  void stopMove() {
    for (int i = 0; i < mapTiles.length; i++) {
      for (int k = 0; k < mapTiles[0].length; k++) {
        if(tileArray[i][k] != 486){
          mapTiles[i][k].stopMove();
        }  
      }
    }
  }

  //start a new movement by returning a key
  void newMove(char currentKey) {
    this.currentKey = currentKey;
  }

  //returns the related key for the movement
  char getCurrentKey() {
    return currentKey;
  }
  
  //code for checking overlap w/ archetypical tiles
  int checkOverlap(ArrayList<Tile> array, Player player, String text) {
    //loops through each iteration in array
    for (int i = 0; i < array.size(); i++) {
      //if they're overlapping, return an associated string
      if (array.get(i).checkOverlap(player) == true) {
        println(text);
        //returns the index if true, returns -1 if false
        overlapint = i;
        return overlapint;
      }
    }
    overlapint = -1;
    return overlapint;
  }
}
