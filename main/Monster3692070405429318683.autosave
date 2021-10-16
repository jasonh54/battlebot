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
  
  //PImage[] sprites; //monster sprites
  //private Timer keyTimer = new Timer(40);
  final int h = 16;
  final int w = 16;
  float x = 400;
  float y = 400;
  final int scale = 2;
  Spritesheet animations;
  Timer time;
  float speedX = 0;
  float speedY = 0;
  
  //constructor




    


  public Monster(String id, Monster enemy, float x, float y) {

    this.id = id;
    type = monsterDatabase.get(id).getString("type");
    attack = monsterDatabase.get(id).getFloat("attack");
    defense = monsterDatabase.get(id).getFloat("defense");
    maxhealth = monsterDatabase.get(id).getFloat("maxhealth");
    chealth = maxhealth;
    speed = monsterDatabase.get(id).getFloat("speed");
    image = spritesHm.get(monsterDatabase.get(id).getString("image"));
    animations = new Spritesheet(this.image, 120);
    animations.setxywh(x, y, w*scale, h*scale);
    int frameNum = image.width/16;
    int[] frameNums = new int[frameNum];
    for(int i = 0; i < frameNum; i++){
      frameNums[i] = i;
    }
    animations.createAnimation("default", frameNums);
    time = new Timer();
    
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
    this.x = x;
    this.y = y;
  }
  

  public void display(){
    color(0,0,200);
    fill(250, 229, 127);
    rect(x-60,y-100,170,60);
    fill(158,0,0);
    rect(x-55,y-75,150,25);
    fill(0,158,0);
    rect(x-55,y-75,(chealth/maxhealth)*150,25);
    fill(0,0,0);
    textAlign(LEFT, UP);
    text(id,x-54,y-80);
    textAlign(CENTER, CENTER);
    text(chealth + "/" + maxhealth, x+20, y-62);
    //pop();
    //if(animations.animationTimer.countDownUntil(animations.stoploop)){
    //  animations.changeDisplay(true);
    //}
    animations.play("default");
  }
  
  public void addHp(int hp){
    if (this.chealth + hp >= this.maxhealth) {
      this.chealth = this.maxhealth;
    }else{
      this.chealth += hp;
    }
  }
  
  public void modStats(float healthMod, float attackMod, float speedMod, float defenseMod){
    chealth = chealth + healthMod;
    if(chealth < 0){
      chealth = 0;
    }
    this.attack = this.attack * attackMod;
    this.speed = this.speed * speedMod;
    this.defense = this.defense * defenseMod;
  }
  
  public void setEnemy(Monster enemy){
    move1.target = enemy;
    move2.target = enemy;
    move3.target = enemy;
    move4.target = enemy;
  }
  
  public void moveToEnemyStart(Monster target){
    time.timeStampNow();
    speedX = target.x - this.x;
    speedY = target.y - this.y;
    time.setTimeInterval(75);
  }
  
  public boolean moveToEnemy(Monster target){
    if(time.intervals()){
      animations.x += speedX/10;
      animations.y += speedY/10;
      if(speedX < 0 && speedY < 0){
        if(animations.x <= target.x && animations.y <= target.y){
          speedX *= -1;
          speedY *= -1;
        }
        if(animations.x <= this.x && animations.y <= this.y){
          animations.x = this.x;
          animations.y = this.y;
          speedX = 0;
          speedY = 0;
          return true;
        }
      } else {
        if(animations.x >= target.x && animations.y >= target.y){
          speedX *= -1;
          speedY *= -1;
        }
        if(animations.x >= this.x && animations.y >= this.y){
          animations.x = this.x;
          animations.y = this.y;
          speedX = 0;
          speedY = 0;
          return true;
        }
      }
    }
    return false;
  }
}
