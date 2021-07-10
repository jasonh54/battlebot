class Monster {
  //variables
  PImage image;
  String id;
  String type;
  float attack;
  float defense;
  float chealth; //current health
  float maxhealth;
  float speed;
  Moves move1, move2, move3, move4;
  Moves[] moveset = {move1, move2, move3, move4};
  
  PImage[] sprites; //monster sprites
  //private Timer keyTimer = new Timer(40);
  SpriteSheet animations;
  final int h = 16;
  final int w = 16;
  int x = 400;
  int y = 400;
  final int scale = 2;
  
  //constructor
  public Monster(String id) {
    animations = new SpriteSheet(spritesHm.get(id), 500);
    this.id = id;
    type = monsterDatabase.get(id).getString("type");
    attack = monsterDatabase.get(id).getFloat("attack");
    defense = monsterDatabase.get(id).getFloat("defense");
    maxhealth = monsterDatabase.get(id).getFloat("maxhealth");
    speed = monsterDatabase.get(id).getFloat("speed");
    image = spritesHm.get(monsterDatabase.get(id).getString("image"));

    move1 = new Moves(monsterDatabase.get(id).getString("move1"));
    move2 = new Moves(monsterDatabase.get(id).getString("move2"));
    move3 = new Moves(monsterDatabase.get(id).getString("move3"));
    move4 = new Moves(monsterDatabase.get(id).getString("move4"));
    println(id + type + attack + defense + maxhealth + speed + monsterDatabase.get(id).getString("image"));

  }
  
  public void display(){
    
    color(0,0,200);
    rect(50,50,150,100); 
    //pop();
    if(animations.animationTimer.countDownUntil(animations.stoploop)){
      animations.changeDisplay(true);
    }
  }
  public void addHp(int hp){
    if (this.chealth + hp >= this.maxhealth) {
      this.chealth = this.maxhealth;
    }else{
      this.chealth += hp;
    }
  }
  
}
