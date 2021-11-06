//helper function that will generate the character sprites for NPC and player
public PImage[] createCharacterSprites(int playerNum){
  int i = 0;
  PImage[] characterSprites = new PImage[12];
  //locate which row in the tilemapguide the player starts at
  int row = 0 + playerNum*3;
  //locate which tile num col in the tilemapguide the player starts at
  int tilenum = (27*(row+1))-4;
  //for loop that will go through each column
  for(int c = tilenum; c<tilenum+4; c++){
    for(int r = 0; r< 3;r++){
      characterSprites[i] = tiles[c + (r*27)];
      i++;
    }
  }
  return characterSprites;
}

enum PlayerMovementStates{
  UP,
  DOWN,
  LEFT,
  RIGHT,
  SUDDENSTOP,
  STATIC,
  MOVEUP,
  MOVEDOWN,
  MOVELEFT,
  MOVERIGHT
}

//player class
class Player{
  
  PlayerMovementStates direction = PlayerMovementStates.RIGHT;
  

  PImage[] sprites; //character sprites
  //private Timer keyTimer = new Timer(40);
  final int h = 16;
  final int w = 16;
  int steps = 0; //steps taken during gameplay
  int x = 400;
  int y = 400;
  final int scale = 2;
  String swapto;

  
  HashMap<String,Integer> items = new HashMap<String,Integer>();
  ArrayList<Monster> monsters = new ArrayList<Monster>();
  Spritesheet animations;
  
  public Player(PImage[] sprites){
    this.sprites = sprites; 
    animations = new Spritesheet(this.sprites, 120);
    animations.setxywh(x, y, w*scale, h*scale);
    animations.createAnimation("walkLeft", new int[]{0,1,2});
    animations.createAnimation("walkDown", new int[]{3,4,5});
    animations.createAnimation("walkUp", new int[]{6,7,8});
    animations.createAnimation("walkRight", new int[]{9,10,11});
    animations.createAnimation("lookLeft", new int[]{0});
    animations.createAnimation("lookDown", new int[]{3});
    animations.createAnimation("lookUp", new int[]{6});
    animations.createAnimation("lookRight", new int[]{9});
  }
  

  public void addItem(String id){
    Integer a = items.get(id);
    items.put(id, a == null ? 1 : a+1);
  }
  public JSONObject useItem(String id){
    Integer a = items.get(id);
    if (a != null){
      items.put(id, a-1); // "healthPotion": 0
      if (a-1 == 0){
        items.remove(id);
      }
      return itemDatabase.get(id);
    }
    throw new Error("You insolent fool, thou hast disturbed the balance of the universe. (["+id+"] was not in the database.)");
  }
  
  public void summonMonsterStack(String[] idarray) {
    for (int i = 0; i < idarray.length; i++) {
      addMonster(generateNewMonster(idarray[i]));
    }
  }
  
  public void addMonster(Monster m) {
      monsters.add(m);
  }
  
  public Monster generateNewMonster(String id) {
    Monster m = new Monster(id, 400, 400);
    return m;
  }
  
  public void display(){
    //image(sprites[0], 400,400, h * scale, w * scale);
    
    if(keyPressed == true){
      if (key == 'w') {
        direction= PlayerMovementStates.MOVEUP;
      } else if (key == 's') {
        direction= PlayerMovementStates.MOVEDOWN;
      } else if (key == 'a') {
        direction= PlayerMovementStates.MOVELEFT;
      } else if (key == 'd') {
        direction= PlayerMovementStates.MOVERIGHT;
      }
    }
    
    //if(animations.stoploop){
    //  animations.softReset();
    //  //keyTimer.refresh();
    //  direction = PlayerMovementStates.STATIC;
    //}
    
    switch(direction){
      case MOVEUP:
        //animations.checkCase(6);
        moveUp();
        break;
      case MOVEDOWN:
        //animations.checkCase(3);
        moveDown();
        break;
      case MOVELEFT:
        //animations.checkCase(0);
        moveLeft();
        break;
      case MOVERIGHT:
        //animations.checkCase(9);
        moveRight();
        break;
      case UP:
        animations.play("lookUp");
        break;
      case DOWN:
        animations.play("lookDown");
        break;
      case LEFT:
        animations.play("lookLeft");
        break;
      case RIGHT:
        animations.play("lookRight");
        break;
      default:
        //if(animations.animationTimer.countDownOnce()){
        //  animations.increment = animations.loopstart;
        //}
        //animations.display(400,400);
        break;
    }
  }
  
  void moveUp(){
    animations.play("walkUp");
    if(animations.finished("walkUp")){
      direction = PlayerMovementStates.UP;
    }
  }
  void moveDown(){
    animations.play("walkDown");
    if(animations.finished("walkDown")){
      direction = PlayerMovementStates.DOWN;
    }
  }
  void moveLeft(){
    animations.play("walkLeft");
    if(animations.finished("walkLeft")){
      direction = PlayerMovementStates.LEFT;
    }
  }
  void moveRight(){
    animations.play("walkRight");
    if(animations.finished("walkRight")){
      direction = PlayerMovementStates.RIGHT;
    }
  }
}
  //player needs key pressed to trigger animations
  //this function is used in the switch statement depending on which direction the player is facing in
  //when this function runs the player needs to player the walking up animation
  //void moveUp(){
      //if(animations.animationTimer.countDownUntil(animations.stoploop)){
      //  animations.changeDisplay(6,8);
      //}
      //animations.display(400,400);
      
      //if(keyPressed == false && animations.increment > 6){
      //  animations.softReset();
      //  direction = PlayerMovementStates.STATIC;
      //}
  //}
  
  //void moveDown(){
  //    if(animations.animationTimer.countDownUntil(animations.stoploop)){
  //      animations.changeDisplay(3,5);
  //    }
  //    animations.display(400,400);
      

  //    if(keyPressed == false && animations.increment > 3){
  //      animations.softReset();
  //      direction = PlayerMovementStates.STATIC;
  //    }
  //}
  
  //void moveLeft(){  
  //    if(animations.animationTimer.countDownUntil(animations.stoploop)){
  //      animations.changeDisplay(0,2);
  //    }
  //    animations.display(400,400);
      

  //    if(keyPressed == false && animations.increment > 0){
  //      animations.softReset();
  //      direction = PlayerMovementStates.STATIC;
  //    }
  //}
  
  //void moveRight(){
  //    if(animations.animationTimer.countDownUntil(animations.stoploop)){
  //      animations.changeDisplay(9,11);
  //    }
  //    animations.display(400,400);
      
  //    if(keyPressed == false && animations.increment > 9){
  //      animations.softReset();
  //      direction = PlayerMovementStates.STATIC;
  //    }
  //}
