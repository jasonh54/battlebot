class Monster {
  //variables
  private String id;
  private Type type;
  private int level;
  private JSONObject basestats;
  private HashMap<Stat,Float> stats;
  private float chealth;
  private Move[] moveset = new Move[4];
  
  private PImage image;
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
    JSONObject data = monsterDatabase.get(id);

    this.image = monstersprites.get(data.getString("image"));
    this.id = id;
    this.level = 1;
    this.type = Type.valueOf(data.getString("type").toUpperCase());
    this.basestats = JSONCopy(data).setFloat("agility",1.0f);
    this.stats = new HashMap<Stat,Float>();
    for (Stat stat : Stat.values()) {
      String sstat = stat.name().toLowerCase();
      if (!this.basestats.isNull(sstat)) {
        this.stats.put(stat,this.basestats.getFloat(sstat));
      }
    }
    this.chealth = this.stats.get(Stat.MAXHEALTH);
    for (int i = 0; i<this.moveset.length; i++) {
      this.moveset[i] = new Move(this,monsterDatabase.get(id).getJSONArray("moves").getString(i));
    }
    
    animations = new Spritesheet(this.image, 120);
    animations.setxywh(x, y, w*scale, h*scale);
    int frameNum = image.width/16;
    int[] frameNums = new int[frameNum];
    for(int i = 0; i < frameNum; i++){frameNums[i] = i;}
    animations.createAnimation("default", frameNums);
    time = new Timer();
    
    this.x = x;
    this.y = y;
  }
  
  public float getCHealth() {
    return this.chealth;
  }

  public void display(){
    color(0,0,200);
    fill(250, 229, 127);
    rect(x-60,y-100,170,60);
    fill(158,0,0);
    rect(x-55,y-75,150,25);
    fill(0,158,0);
    rect(x-55,y-75,(this.chealth/this.stats.get(Stat.MAXHEALTH))*150,25);
    fill(0,0,0);
    textAlign(LEFT, UP);
    text(id,x-54,y-80);
    textAlign(CENTER, CENTER);
    text(this.chealth + "/" + this.stats.get(Stat.MAXHEALTH), x+20, y-62);
    //pop();
    //if(animations.animationTimer.countDownUntil(animations.stoploop)){
    //  animations.changeDisplay(true);
    //}
    animations.play("default");
  }
  
  public void addHp(float hp){
    this.chealth += constrain(hp,-this.chealth,this.stats.get(Stat.MAXHEALTH));
  }
  public void modStats(HashMap<Stat,Float> mod){
    if (mod.containsKey(Stat.MAXHEALTH)) addHp(mod.get(Stat.MAXHEALTH));
    if (mod.get(Stat.ATTACK)  != 1.0f) this.stats.put(Stat.ATTACK ,this.stats.get(Stat.ATTACK) *mod.get(Stat.ATTACK) );
    if (mod.get(Stat.SPEED)   != 1.0f) this.stats.put(Stat.SPEED  ,this.stats.get(Stat.SPEED)  *mod.get(Stat.SPEED)  );
    if (mod.get(Stat.DEFENSE) != 1.0f) this.stats.put(Stat.DEFENSE,this.stats.get(Stat.DEFENSE)*mod.get(Stat.DEFENSE));
    if (mod.get(Stat.AGILITY) != 1.0f) this.stats.put(Stat.AGILITY,this.stats.get(Stat.AGILITY)*mod.get(Stat.AGILITY));
    //System.out.printf("Modifying Stats of %s:\nHP: +%f | Atk: x%f | Spd: x%f | Def: x%f | Agl: x%f\n",this.id,mod.getFloat("health"),mod.getFloat("attack"),mod.getFloat("speed"),mod.getFloat("defense"),mod.getFloat("agility"));
  }

  
}
