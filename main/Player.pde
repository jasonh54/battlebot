//player class
class Player{
  

  int direction = 0; //0 = north, 1 = east, 2 = south, 3 = west;

  PImage[] sprites; //character sprites

  
  ArrayList<Items> items = new ArrayList<Items>();
  ArrayList<Monster> monsters = new ArrayList<Monster>();
  
  public Player(PImage[] sprites){
    this.sprites = sprites; 
  }
  
  public void display(){
    image(sprites[4], 400,400);
  }
  
  
}

//controls
//work on player aniamtion, tile guide .png
//23 - 26 and so on are player sprites
//make a seperate animation tool, uses an array of images than a spritesheet
