class Monster {
  //variables
  PImage image;
  String id;
  String type;
  JSONObject stats;
  Move moveset[] = new Move[4];
  
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
  int moveCount = 0;
  
  //constructor
  public Monster(String id, float x, float y) {
    this.id = id;
    this.type = monsterDatabase.get(id).getString("type");
    this.stats = JSONCopy(monsterDatabase.get(id)).setFloat("chealth",monsterDatabase.get(id).getFloat("maxhealth")).setFloat("agility",1.0f); // JSONCopy(monsterDatabase.get(id))
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
    
    moveset[0] = new Move(this,monsterDatabase.get(id).getString("move1"));
    moveset[1] = new Move(this,monsterDatabase.get(id).getString("move2"));
    moveset[2] = new Move(this,monsterDatabase.get(id).getString("move3"));
    moveset[3] = new Move(this,monsterDatabase.get(id).getString("move4"));
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
    rect(x-55,y-75,(this.stats.getFloat("chealth")/this.stats.getFloat("maxhealth"))*150,25);
    fill(0,0,0);
    textAlign(LEFT, UP);
    text(id,x-54,y-80);
    textAlign(CENTER, CENTER);
    text(this.stats.getFloat("chealth") + "/" + this.stats.getFloat("maxhealth"), x+20, y-62);
    //pop();
    //if(animations.animationTimer.countDownUntil(animations.stoploop)){
    //  animations.changeDisplay(true);
    //}
    animations.play("default");
  }
  
  public void addHp(int hp){
    this.stats.setFloat("chealth",this.stats.getFloat("chealth")+hp>this.stats.getFloat("maxhealth") ? this.stats.getFloat("maxhealth") : (this.stats.getFloat("chealth")+hp < 0 ? 0 : this.stats.getFloat("chealth")+hp));
  }
  public void modStats(JSONObject mod){
    addHp((int)mod.getFloat("health"));
    if (mod.getFloat("attack")  != 1.0f) this.stats.setFloat("attack" ,this.stats.getFloat("attack") *mod.getFloat("attack") );
    if (mod.getFloat("speed")   != 1.0f) this.stats.setFloat("speed"  ,this.stats.getFloat("speed")  *mod.getFloat("speed")  );
    if (mod.getFloat("defense") != 1.0f) this.stats.setFloat("defense",this.stats.getFloat("defense")*mod.getFloat("defense"));
    if (mod.getFloat("agility") != 1.0f) this.stats.setFloat("agility",this.stats.getFloat("agility")*mod.getFloat("agility"));
    //System.out.printf("Modifying Stats of %s:\nHP: +%f | Atk: x%f | Spd: x%f | Def: x%f | Agl: x%f\n",this.id,mod.getFloat("health"),mod.getFloat("attack"),mod.getFloat("speed"),mod.getFloat("defense"),mod.getFloat("agility"));
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
  
  public void healStart(){
    time.timeStampNow();
    speedX = 4;
    time.setTimeInterval(100);
    moveCount = 0;
  }
  
  public boolean healAnimation(){
    animations.x += speedX;
    if(time.intervals()){
      speedX *= -1;
      if(moveCount == 6){
        animations.x = this.x;
        return true; 
      }
      moveCount++;
    }
    return false;
  }
  
  public void defendStart(){
    time.timeStampNow();
    speedY = 4;
    time.setTimeInterval(300);
    moveCount = 0;
  }
  
  public boolean defendAnimation(){
    animations.y += speedY;
    if(time.intervals()){
      if(moveCount == 3){
        animations.y = this.y;
        return true;
      }
      speedY *= -1;
      moveCount++;
    }
    return false;
  }
  
  public void dodgeStart(){
    time.timeStampNow();
    speedX = 4;
    speedY = 4;
    time.setTimeInterval(150);
    moveCount = 0;
  }
  
  public boolean dodgeAnimation(){
    animations.x += speedX;
    animations.y += speedY;
    if(time.intervals()){
      if(moveCount == 3){
        speedX = -4;
        speedY = -4;
      } else if(moveCount == 5){
        animations.x = this.x;
        animations.y = this.y;
        return true;
      } else {
        speedX = 0;
        speedY = 0;
      }
      moveCount++;
    }
    return false;
  }
}
