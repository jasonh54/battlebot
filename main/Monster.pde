class Monster {
  //variables
  String id;
  String type;
  float attack;
  float defense;
  float health;
  float speed;
  Moves move1, move2, move3, move4;
  
  PImage[] sprites; //character sprites
  //private Timer keyTimer = new Timer(40);
  SpriteSheet animations;
  final int h = 16;
  final int w = 16;
  int steps = 0; //steps taken during gameplay
  int x = 400;
  int y = 400;
  final int scale = 2;
  
  //constructor
  public Monster(String id, String type, float attack, float defense, float health, float speed) {
    this.id = id;
    this.type = type;
    this.attack = attack;
    this.defense = defense;
    this.health = health;
    this.speed = speed;
  }
  
  public void display(){
    
  }
  
}
