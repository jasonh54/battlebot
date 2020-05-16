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
  final int scale = 1;
  Tile [][] mapTiles;
  
  public Map() {
    speedx = 0;
    speedy = 0;
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
        Tile topleft = new Tile(tileww * scale, tilehh * scale, false, false, tiles[tileArray[0][0]]);
        mapTiles[0][0] = topleft;
        print(tileArray[0][0]);
        prev = topleft;
      } else {
        //for other first-of-row tiles
        current = new Tile(tileww * scale, prev.y + tileh * scale, false, false, tiles[tileArray[incount1][incount2]]);
        mapTiles[incount1][incount2] = current;
        print(", " + tileArray[incount1][incount2]);
        prev = current;
      }
      //second loop: create rest of row
      for (int k = 0; k < rowsize - 1; k++) {
        incount2++;
        current = new Tile(prev.x + tilew * scale, prev.y, false, false, tiles[tileArray[incount1][incount2]]);
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
  
  void update() {
    keyPressed();
    keyReleased();
    x += speedx;
    y += speedy;
  }
  
  void keyPressed() {
    if (key == 'w') {
      speedy = -5;
    } else if (key == 'd') {
      speedy = 5;
    } else if (key == 'a') {
      speedx = -5;
    } else if (key == 's') {
      speedx = 5;
    }
  }
  
  void keyReleased() {
    if (key == 'w' || key == 'd') {
      speedy = 0;
    } else if (key == 'a' || key == 's') {
      speedx = 0;
    }
  }
  
}
