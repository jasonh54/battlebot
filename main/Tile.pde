class Tile {
  //variables
  PImage img;
  boolean collide;
  boolean portal;
  float x;
  float y;
  int scale;
  float speedx;
  float speedy;
  int counting = 0;

  //build with scale
  public Tile(float x, float y, boolean c, boolean p, PImage img, int sc) {
    this.x = x;
    this.y = y;
    this.scale = sc;
    this.img = img;
    collide = c;
    portal = p;
    speedx = 0;
    speedy = 0;
  }
  
  
  //default build
  public Tile() {
  
  }
  
  void printInfo() {
    println(this.x + ", " + this.y);
    println(this.collide);
  }
  
  void moveUp() {
    speedy = 1 * scale;
    this.y += speedy;
  }
  
  void moveDown() {
    speedy = -1 * scale;
    this.y += speedy;
  }
  
  void moveLeft() {
    speedx = 1 * scale;
    this.x += speedx;
  }
  
  void moveRight() {
    speedx = -1 * scale;
    this.x += speedx;
  }
  
  void stopMove() {
    speedx = 0;
    //this.x = speedx;
    speedy = 0;
    //this.y = speedy;
  }
  
  //draw with scales
  void draw() {
    image(this.img, this.x, this.y, this.img.width * this.scale, this.img.height * this.scale);
  }
  
}
