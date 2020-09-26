class Tile {
  //variables
  PImage img;
  boolean collide;
  boolean portal;
  boolean grass;
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
  
  
  //BASE MOVEMENT THINGS
  void moveUp() {
    speedy = 2 * scale;
    this.y += speedy;
  }
  
  void moveDown() {
    speedy = -2 * scale;
    this.y += speedy;
  }
  
  void moveLeft() {
    speedx = 2 * scale;
    this.x += speedx;
  }
  
  void moveRight() {
    speedx = -2 * scale;
    this.x += speedx;
  }
  
  void stopMove() {
    speedx = 0;
    //this.x = speedx;
    speedy = 0;
    //this.y = speedy;
  }
  
  //checking if player is overlapping
  boolean checkOverlap(Player player) {
    if (this.x == player.x && this.y == player.y) {
      return true;
    }
    return false;
  }
  
  //draw with scales
  void draw() {
    image(this.img, this.x, this.y, this.img.width * this.scale, this.img.height * this.scale);
  }
  
}
