class Tile {
  //variables
  PImage img;
  boolean collide;
  boolean portal;
  float x;
  float y;
  int scale;

  //build with scale
  public Tile(float x, float y, boolean c, boolean p, PImage img, int sc) {
    this.x = x;
    this.y = y;
    this.scale = sc;
    this.img = img;
    collide = c;
    portal = p;
  }
  
  
  //default build
  public Tile() {
  
  }
  
  void printInfo() {
    println(this.x + ", " + this.y);
    println(this.collide);
  }
  
  //draw with scales
  void draw() {
    image(this.img, this.x, this.y, this.img.width * this.scale, this.img.height * this.scale);
  }
  
}
