class Tile {
  //variables
  PImage img;
  boolean collide;
  boolean portal;
  boolean grass;
  private float x;
  private float y;
  int counting = 0;


  //build with scale
  public Tile(float x, float y, boolean c, boolean p, PImage img, int sc) {
    this.x = x;
    this.y = y;
    this.img = img;
    collide = c;
    portal = p;
  }
  
  
  //default build
  public Tile() {
  
  }
  
  //checking if player is overlapping w the given tile
  boolean checkOverlap(Player player) {
    return this.x == player.x && this.y == player.y;
  }
  
  //draw with scales
  void draw() {
    image(this.img, this.x, this.y, this.img.width*2, this.img.height*2);
    
  }
}
