class Map {
  //variables
  int x;
  int y;
  int speedx;
  int speedy;
  int colsize;
  int rowsize;
  final int tileh = 16;
  final int tilew = 16;
  final int tilehh = tileh/2;
  final int tileww = tilew/2;
  int counter = 0;

  final int mapscale = 2;

  Tile [][] mapTiles;
  
  public Map() {
    
  }
  
  //map generation v2 (working)
  void generateBaseMap(int[][] tileArray) {
    //counters for dimensions of tileArray AND mapTiles
    int incount1 = 0;
    int incount2 = 0;
    colsize = tileArray.length;
    rowsize = tileArray[0].length;
    mapTiles = new Tile[colsize][rowsize];
    //temporary tiles to store data
    Tile prev = new Tile();
    Tile current;
    //first loop: create first tile in a row
    for (int i = 0; i < colsize; i++) {
      incount2 = 0;
      if (incount1 == 0) {
        //for top left tile
        Tile topleft = new Tile(tileww * mapscale, tilehh * mapscale, false, false, tiles[tileArray[0][0]], mapscale);
        topleft.collide = binarySearch(collidableSprites, tileArray[0][0], 0, collidableSprites.length - 1);
        topleft.printInfo();
        mapTiles[0][0] = topleft;
        print(tileArray[0][0]);
        prev = topleft;
      } else {
        //for other first-of-row tiles
        current = new Tile(tileww * mapscale, prev.y + tileh * mapscale, false, false, tiles[tileArray[incount1][incount2]], mapscale);
        current.collide = binarySearch(collidableSprites, tileArray[incount1][incount2], 0, collidableSprites.length - 1);
        current.printInfo();
        mapTiles[incount1][incount2] = current;
        print(", " + tileArray[incount1][incount2]);
        prev = current;
      }
      //second loop: create rest of row
      for (int k = 0; k < rowsize - 1; k++) {
        incount2++;
        current = new Tile(prev.x + tilew * mapscale, prev.y, false, false, tiles[tileArray[incount1][incount2]], mapscale);
        current.collide = binarySearch(collidableSprites, tileArray[incount1][incount2], 0, collidableSprites.length - 1);
        current.printInfo();
        mapTiles[incount1][incount2] = current;
        print(tileArray[incount1][incount2]);
        prev = current;
      }
      incount1++;
    }
  }
  
  void draw() {
    for (int i = 0; i < colsize; i++) {
      for (int k = 0; k < rowsize; k++) {
        mapTiles[i][k].draw();
      }
    }
  }
  
  //ALWAYS set min = 0 and max = [array].length - 1
  boolean binarySearch(int[] arr, int goal, int min, int max) {
    int guess = (min + max)/2;
    if (guess == goal) {
      return true;
    } else if (guess < goal) {
      binarySearch(arr, goal, guess + 1, max);
    } else if (guess > goal) {
      binarySearch(arr, goal, min, guess - 1);
    }
    return false;
  }
  
  //update loop
  void update() {
    
  }
  
  void moveUp() {
    for (int i = 0; i < mapTiles.length; i++) {
      for (int k = 0; k < mapTiles[0].length; k++) {
        mapTiles[i][k].moveUp();
      }
    }
    counter++;
  }
  
  void moveDown() {
    for (int i = 0; i < mapTiles.length; i++) {
      for (int k = 0; k < mapTiles[0].length; k++) {
        mapTiles[i][k].moveDown();
      }
    }
    counter++;
  }
  
  void moveLeft() {
    for (int i = 0; i < mapTiles.length; i++) {
      for (int k = 0; k < mapTiles[0].length; k++) {
        mapTiles[i][k].moveLeft();
      }
    }
    framecounter++;
  }
  
  void moveRight() {
    for (int i = 0; i < mapTiles.length; i++) {
      for (int k = 0; k < mapTiles[0].length; k++) {
        mapTiles[i][k].moveRight();
      }
    }
    framecounter++;
  }
  
  char newMove(char currentkey) {
    println("movingshaking: " + framecounter);
    if (currentkey == 'w') {
      moveUp();
    } else if (currentkey == 's') {
      moveDown();
    } else if (currentkey == 'a') {
      moveLeft();
    } else if (currentkey == 'd') {
      moveRight();
    }
    return currentkey;
  }


}
