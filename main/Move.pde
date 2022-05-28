class Move {
  private String name;
  private HashMap<Stat,Float> stats;
  private MoveType movetype;
  private Type type;
  private Monster parent;
  MoveAnimation anim;
  Monster target;
  
  //constructor for everyday use
  public Move(Monster parent, String name) {
    this.name = name;
    this.parent = parent;
    JSONObject basestats = moveDatabase.get(name);
    this.stats = new HashMap<Stat,Float>();
    for (Stat stat : Stat.values()) {
      String sstat = stat.name().toLowerCase();
      this.stats.put(stat,basestats.getFloat(sstat));
    }
    if (this.stats == null) throw new Error("Move '"+name+"' was not in the moves databse.");
    this.type = Type.valueOf(basestats.getString("type").toUpperCase());
    this.movetype = MoveType.valueOf(basestats.getString("movetype").toUpperCase());
    anim = new MoveAnimation();
  }
  
  void useMove(Monster target){
    float hpmod = this.stats.get(Stat.MAXHEALTH);
    if (hpmod < 0) {hpmod = moveEfficency(target);}
    HashMap<Stat,Float> statmod = ((HashMap<Stat,Float>)this.stats.clone());
    statmod.put(Stat.MAXHEALTH,hpmod);
    target.modStats(statmod);
    this.target = target;
  }
  
  //various moves - just one for now
  private float moveEfficency(Monster target) {
    //determine values of coefficients: type advantage, type efficiency, random value
    Random r = new Random();
    float ranval = r.nextInt(10) + 90;
    ranval = ranval/100;
    //determine if move hits
    if (r.nextInt(100) < this.stats.get(Stat.ACCURACY)) {
      //calculate total power
      //System.out.printf("Monster Damage: %f | Move Damage: %f | Target Defense: %f",this.parent.stats.getFloat("attack"),(float)this.stats.getInt("health"),target.stats.getFloat("defense"));
      float power = (this.parent.stats.get(Stat.ATTACK) * this.stats.get(Stat.MAXHEALTH))/target.stats.get(Stat.DEFENSE) * ranval * typeEfficency(target);
      return power;
    } else {
      return 0;
    }
  }
  
  private float typeEfficency(Monster target) {
    float moveEfficency = this.type.equals(this.parent.type) ? 1.5 : 1.0;
    float monsterEfficency = efficencies.get(this.type).get(target.type);
    return moveEfficency*monsterEfficency;
  }
  public boolean playAnimation(){
    
    switch(movetype){
      case ATTACK:
        return anim.moveToEnemy(parent, target);
      case DEFEND:
        return anim.defendAnimation(parent);
      case HEAL:
        return anim.healAnimation(parent);
      case DODGE:
        return anim.dodgeAnimation(parent);
      default:
        return false;
    }
  }
}

class MoveAnimation{
  
  Timer time;
  float speedX;
  float speedY;
  
  Monster target;
  Monster user;

  int moveCount = 0;
  
  boolean start;
  
  public MoveAnimation(){
    time = new Timer();
    speedX = 0;
    speedY = 0;
    start = true;
  }
  
  
  public void moveToEnemyStart(Monster user, Monster target){
    time.timeStampNow();
    speedX = target.x - user.x;
    speedY = target.y - user.y;
    time.setTimeInterval(75);
  }
  
  public boolean moveToEnemy(Monster user, Monster target){
    if(start){
      moveToEnemyStart(user, target);
      start = false;
      return false;
    }
    if(time.intervals()){
      user.animations.x += speedX/10;
      user.animations.y += speedY/10;
      if(speedX < 0 && speedY < 0){
        if(user.animations.x <= target.x && user.animations.y <= target.y){
          speedX *= -1;
          speedY *= -1;
        }
        if(user.animations.x <= user.x && user.animations.y <= user.y){
          user.animations.x = user.x;
          user.animations.y = user.y;
          speedX = 0;
          speedY = 0;
          start = true;
          return true;
        }
      } else {
        if(user.animations.x >= target.x && user.animations.y >= target.y){
          speedX *= -1;
          speedY *= -1;
        }
        if(user.animations.x >= user.x && user.animations.y >= user.y){
          user.animations.x = user.x;
          user.animations.y = user.y;
          speedX = 0;
          speedY = 0;
          start = true;
          return true;
        }
      }
    }
    return false;
  }
  
  public void healStart(Monster user){
    time.timeStampNow();
    speedX = 4;
    time.setTimeInterval(100);
    moveCount = 0;
  }
  
  public boolean healAnimation(Monster user){
    if(start){
      healStart(user);
      start = false;
      return false;
    }
    user.animations.x += speedX;
    if(time.intervals()){
      speedX *= -1;
      if(moveCount == 6){
        user.animations.x = user.x;
        start = true;
        return true; 
      }
      moveCount++;
    }
    return false;
  }
  
  public void defendStart(Monster user){
    time.timeStampNow();
    speedY = 4;
    time.setTimeInterval(300);
    moveCount = 0;
  }
  
  public boolean defendAnimation(Monster user){
    if(start){
      defendStart(user);
      start = false;
      return false;
    }
    user.animations.y += speedY;
    if(time.intervals()){
      if(moveCount == 3){
        user.animations.y = user.y;
        start = true;
        return true;
      }
      speedY *= -1;
      moveCount++;
    }
    return false;
  }
  
  public void dodgeStart(Monster user){
    time.timeStampNow();
    speedX = 4;
    speedY = 4;
    time.setTimeInterval(150);
    moveCount = 0;
  }
  
  public boolean dodgeAnimation(Monster user){
    if(start){
      dodgeStart(user);
      start = false;
      return false;
    }
    user.animations.x += speedX;
    user.animations.y += speedY;
    if(time.intervals()){
      if(moveCount == 3){
        speedX = -4;
        speedY = -4;
      } else if(moveCount == 5){
        user.animations.x = user.x;
        user.animations.y = user.y;
        start = true;
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
