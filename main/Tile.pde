class Tile {
  //variables
  PImage img;
  boolean collide;
  boolean portal;
  float x;
  float y;
  int coordx;
  
  public Tile(float x, float y, boolean c, boolean p, int chx, int chy) {
    //this.img = img;
    this.x = x;
    this.y = y;
    collide = c;
    portal = p;
    coordx = chx;
    coordy = chy;
  }
  
}
