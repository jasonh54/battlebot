class Layer {
  int colsize;
  int rowsize;
  Maps parent;

  //variables for the movement
  final int tileh = 16;
  final int tilew = 16;
  final int tilehh = tileh/2;
  final int tileww = tilew/2;
  char currentKey = ' ';
  int framecounter = 0;

  //variables for the layer code
  private int[][] tileArray;
  private Tile [][] layerTiles;
  final int layerscale = 2;
  boolean lock = false;

  //arraylists for types of tiles within a layer
  ArrayList<Tile> collidableTiles = new ArrayList<Tile>();
  ArrayList<Tile> portalTiles = new ArrayList<Tile>();
  ArrayList<Tile> grassTiles = new ArrayList<Tile>();

  //constructor
  public Layer() {
  
  }
  
  void draw() {
    //loops through all tiles and draws, skipping transparent tiles because lag
    for (int i = 0; i < rowsize; i++) {
      for (int k = 0; k < colsize; k++) {
        if(tileArray[i][k] != 486){
          layerTiles[i][k].draw();
        }  
      }
    }
  }
  
  Tile getTile(int lx, int ly){
    return layerTiles[lx][ly];
  }
  
  //layer generation
  void generateBaseLayer(int[][] tileArray) {
    //prepping the tile array for use
    this.tileArray = tileArray;
    rowsize = tileArray.length;
    colsize = tileArray[0].length;
    //layerTiles logs all tiles in the layer as a 2d array
    layerTiles = new Tile[rowsize][colsize];
    //navigating the rows
    for (int row = 0; row < rowsize; row++) {
      //navigating the columns
      for(int col = 0; col < colsize; col++) {
        //skips transparent tiles
        if(tileArray[row][col] != 486) {
          //creates a new tile and assigns values
          Tile current = new Tile((tilew * layerscale) * col + tileww * layerscale, (tileh * layerscale) * row + tilehh * layerscale, false, false, tilesprites[tileArray[row][col]], layerscale);
          //these code sets all check if the tile fits a certain archetype, as listed
          current.collide = tileTypeCheck(collidableSprites, tileArray, row, col);
          current.portal = tileTypeCheck(portalSprites, tileArray, row, col);
          current.grass = tileTypeCheck(grassSprites, tileArray, row, col);
          //loads tile into all relevant arrays
          loadAll(current);
          //saves the tile to the layerTiles and moves on
          layerTiles[row][col] = current;
        }
      }
    }
      
  }

  //generic check for whether a tile matches a type
  boolean tileTypeCheck (int[] spriteArray, int[][] arrayoftiles, int row, int col) {
    return binarySearch(spriteArray, arrayoftiles[row][col], 0, spriteArray.length - 1);
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

  //add tiles to various type-oriented arraylists
  void loadAll (Tile tile) {
    loadCollide(tile);
    loadPortal(tile);
    loadGrass(tile);
  }

  //functions that save the archetypical tiles to their respective special arrays
  //these arrays are used later when checking if the player is near/touching a type of tile
  void loadCollide(Tile tile) {
    if (tile.collide) {collidableTiles.add(tile);}
  }
  
  void loadPortal(Tile tile) {
    if (tile.portal) {portalTiles.add(tile);}
  }
  
  void loadGrass(Tile tile) {
    if (tile.grass) {grassTiles.add(tile);}
  }

  //update loop
  void update() {
    this.draw();
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
    int overlapint;
    //loops through each iteration in array
    for (int i = 0; i < array.size(); i++) {
      //if they're overlapping, return an associated string
      if (array.get(i).checkOverlap(player) == true) {
        //returns the index if true, returns -1 if false
        overlapint = i;
        return overlapint;
      }
    }
    overlapint = -1;
    return overlapint;
  }
}
