class Monster {
  //variables
  PImage image;
  String id;
  String type;
  float attack;
  float defense;
  float health;
  float chealth; //current health
  float speed;
  Moves move1, move2, move3, move4;
  
  PImage[] sprites; //monster sprites
  //private Timer keyTimer = new Timer(40);
  SpriteSheet animations;
  final int h = 16;
  final int w = 16;
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
  
  public Monster(String name){
    animations = new SpriteSheet(spritesHm.get(name), 500);
  }
  
  public void display(){
    
    color(0,0,200);
    rect(50,50,150,100); 
    //pop();
    if(animations.animationTimer.countDownUntil(animations.stoploop)){
      animations.changeDisplay(true);
    }
  }
  
}
