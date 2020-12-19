class OverlayMap extends Map {
  //variables
  boolean leftcollidetracker;
  boolean rightcollidetracker;
  boolean upcollidetracker;
  boolean downcollidetracker;
  //constructor
  public OverlayMap() {
    super();
  }
  
  //update loop
  void update() {
    this.draw();
    this.fullMovement();
  }

  //these funcs each check collision in a different direction
  public boolean collideLeft(Player player) {
    for (int i = 0; i < collidableTiles.size(); i++) {
      if (collidableTiles.get(i).y == player.y) {
        if (collidableTiles.get(i).x <= player.x - 8 && collidableTiles.get(i).x >= player.x - 32) {
          leftcollidetracker = true;
          return leftcollidetracker;
        }
      }
    }
    return leftcollidetracker;
  }

  public boolean collideRight(Player player) {
    for (int i = 0; i < collidableTiles.size(); i++) {
      if (collidableTiles.get(i).y == player.y) {
        if (collidableTiles.get(i).x >= player.x + 8 && collidableTiles.get(i).x <= player.x + 32) {
          rightcollidetracker = true;
          return rightcollidetracker;
        }
      }
    }
    return rightcollidetracker;
  }

  public boolean collideDown(Player player) {
    for (int i = 0; i < collidableTiles.size(); i++) {
      if (collidableTiles.get(i).x == player.x) {
        if (collidableTiles.get(i).y >= player.y + 8 && collidableTiles.get(i).y <= player.y + 32) {
          downcollidetracker = true;
          return downcollidetracker;
        }
      }
    }
    return downcollidetracker;
  }

  public boolean collideUp(Player player) {
    for (int i = 0; i < collidableTiles.size(); i++) {
      if (collidableTiles.get(i).x == player.x) {
        if (collidableTiles.get(i).y <= player.y - 8 && collidableTiles.get(i).y >= player.y - 32) {
          upcollidetracker = true;
          return upcollidetracker;
        }
      }
    }
    return upcollidetracker;
  }
}
