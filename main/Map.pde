class Map {
  //variables
  int columnsize;
  int rowsize;
  int x;
  int y;
  int speedx;
  int speedy;
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
    //temporary tiles to store data
    Tile prev = new Tile();
    Tile current;
    //first loop: create first tile in a row
    for (int i = 0; i < 3; i++) {
      incount2 = 0;
      if (incount1 == 0) {
        //for top left tile
        Tile topleft = new Tile(8, 8, false, false, tiles[tileArray[0][0]]);
        mapTiles[0][0] = topleft;
        print(tileArray[0][0]);
        prev = topleft;
      } else {
        //for other first-of-row tiles
        current = new Tile(8, prev.y + 16, false, false, tiles[tileArray[incount1][incount2]]);
        mapTiles[incount1][incount2] = current;
        print(", " + tileArray[incount1][incount2]);
        prev = current;
      }
      //second loop: create rest of row
      for (int k = 0; k < 2; k++) {
        incount2++;
        current = new Tile(prev.x + 16, prev.y, false, false, tiles[tileArray[incount1][incount2]]);
        mapTiles[incount1][incount2] = current;
        print(tileArray[incount1][incount2]);
        prev = current;
      }
      incount1++;
    }
  }
  
  void draw() {
    for (int i = 0; i < 3; i++) {
      for (int k = 0; k < 3; k++) {
        mapTiles[i][k].draw();
        k++;
      }
      i++;
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
