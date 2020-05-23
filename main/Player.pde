//player class
class Player{
  
  PImage sprite; //character sprite
  int direction = 0; //0 = north, 1 = east, 2 = south, 3 = west;
  
  ArrayList<Items> items = new ArrayList<Items>();
  ArrayList<Monster> monsters = new ArrayList<Monster>();
  
  public Player(PImage sprite){
    this.sprite = sprite; 
  }
  
}

//controls
//work on player aniamtion, tile guide .png
//23 - 26 and so on are player sprites
//make a seperate animation tool, uses an array of images than a spritesheet
