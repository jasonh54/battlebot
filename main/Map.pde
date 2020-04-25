//Map objects will be multiple tiles
//basically the full Map will contain multiple objects in an array to be drawn
//we require a map generator that would parse through a string and depending what characters are in the string create tile objects into the array of objects in the Map class
class Map {
  //variables
  int columnsize;
  int rowsize;
  int x;
  int y;
  int speedx;
  int speedy;
  
  public Map() {
    speedx = 0;
    speedy =0;
  }
  
  //UNFINISHED MAP CREATION
  void generateBaseMap() {
    //generate tiles, columns left to right
    int coordx = 1;
    int coordy = 1;
    Tile topleft = new Tile(8, 8, false, false, 1, 1);
    Tile prev = topleft;
    Tile current;
    //row: create new tile to the right once column is down
    for (int i = 0; i < rowsize; i++) {
      //column: new tiles below
      for (int k = 0; k < columnsize; k++) {
        coordy++;
        current = new Tile(prev.x, prev.y + 16, false, false, coordx, coordy);
        prev = current;
      }
      coordx++;
      current = new Tile(prev.x + 16, 8, false, false, coordx, 1);
      prev = current;
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
