//player class
class Player{
  
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
