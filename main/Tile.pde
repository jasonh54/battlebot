class Tile {
  //variables
  PImage img;
  boolean collide;
  boolean portal;
  float x;
  float y;
  
  public Tile(float x, float y, boolean c, boolean p) {
    //this.img = img;
    this.x = x;
    this.y = y;
    collide = c;
    portal = p;
    h = 50;
    w = 50;
  }
  
}
