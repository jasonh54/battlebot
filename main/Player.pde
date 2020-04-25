//player class
class Player{
  
  PImage sprite; //character sprite
  
  ArrayList<Items> items = new ArrayList<Items>();
  ArrayList<Monster> monsters = new ArrayList<Monster>();
  
  public Player(PImage sprite){
    this.sprite = sprite; 
  }
  
}
