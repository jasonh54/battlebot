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
  Moves moveset[] = new Moves[4];
  
  PImage[] sprites; //monster sprites
  //private Timer keyTimer = new Timer(40);
  SpriteSheet animations;
  final int h = 16;
  final int w = 16;
  int x = 400;
  int y = 400;
  final int scale = 2;
  
  //constructor

  public Monster(String id, Monster enemy) {

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
    moveset[0] = move1;
    moveset[1] = move2;
    moveset[2] = move3;
    moveset[3] = move4;
    
    move1.target = enemy;
    move2.target = enemy;
    move3.target = enemy;
    move4.target = enemy;
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
  
}
