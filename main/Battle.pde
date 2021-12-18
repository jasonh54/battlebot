enum BattleStates {
  ENTRY,
  OPTIONS,
  
  FIGHT,
  ITEM,
  BATTLEBOT,
  RUN,
    
  ANIMATION,
  AI,
  AIANIMATION
}

class Battle {
  private Player player1;
  private Player player2;
  private Monster enemy2;
  private BattleStates battlestate;
  private String MOVE_ANIMATION_ID;
  private String AI_MOVE_ANIMATION_ID;
  
  public Battle(Player p1, Player p2){
    this.player1 = p1;
    this.player2 = p2;
    this.battlestate = BattleStates.ENTRY;
  }
  public Battle(Player p1, Monster e2){
    this.player1 = p1;
    this.enemy2 = e2;
    this.battlestate = BattleStates.ENTRY;
  }
  
  private Monster getCurrentEnemy(){
    return this.player2 != null ? this.player2.getSelectedMonster() : this.enemy2;
  }
  private void displayMonsters() {
    this.player1.getSelectedMonster().display();
    getCurrentEnemy().display();
  }
  
  public void switchState(BattleStates newstate){
    this.battlestate = newstate;
  }
  public void turn(){
    switch (battlestate){
    //battle rhythm: options (choice of action) -> subaction (eg. the specific move or item chosen) -> perform action -> enemy turn -> back to options
      case ENTRY:
        //this happens once at the beginning of every battle, to set the scene
        //draw monsters, menu, background, HP
        battlestate = BattleStates.OPTIONS;
      break;
      case OPTIONS:
        displayMonsters();
        //this happens once at the beginning of every turn; the part where you select what you want to do
        //draw same as Entry State
        battlemenu.update();
        checkMouse(battlemenu);
      break;
      case FIGHT:
        displayMonsters();
        //txt defined here at it is custom to the current battle
        //will produce a menu of what moves the battle bot can use
        Menu movemenu = new Menu(625, 520, 5, 50, 400, 2);

        //nullpointer error HERE because txt is null
        movemenu.buttons.get(0).txt = "Return to Menu";
        movemenu.buttons.get(0).func = "return";

        for (int i = 0; i < 4; i++) {
          //give move buttons functions based on their moves
          movemenu.buttons.get(i+1).txt = testPlayer.getSelectedMonster().moveset[i].name;
          movemenu.buttons.get(i+1).func = ("callmove"+String.valueOf(i)).toString();
        }
        movemenu.update();
        checkMouse(movemenu);
      break;
      case ANIMATION:
        displayMonsters();
        switch (MOVE_ANIMATION_ID){
          case "attack":
            if(testPlayer.getSelectedMonster().moveToEnemy(getCurrentEnemy())){
              battlestate = BattleStates.AI;
            }
          break;
          case "defend":
            if(testPlayer.getSelectedMonster().defendAnimation()){
              battlestate = BattleStates.AI;
            }
          break;
          case "heal":
            if(testPlayer.getSelectedMonster().healAnimation()){
              battlestate = BattleStates.AI;
            }
          break;
          case "dodge":
            if(testPlayer.getSelectedMonster().dodgeAnimation()){
              battlestate = BattleStates.AI;
            }
          break;
          default:
            battlestate = BattleStates.OPTIONS;
          break;
        }
      break;
      case ITEM:
        displayMonsters();
        //will produce a menu of what items you have
        Menu itemmenu = new Menu(625, 520, testPlayer.items.size()+1, 50, 300, 2);
        Object[] itemsKeys = testPlayer.items.keySet().toArray();
        
        itemmenu.buttons.get(0).txt = "Return to Menu";
        itemmenu.buttons.get(0).func = "return";
        for (int i = 0; i < testPlayer.items.size(); i++) {
          String itemi = (String)itemsKeys[i];
          itemmenu.buttons.get(i+1).txt = itemi+" x "+testPlayer.items.get(itemi);
          itemmenu.buttons.get(i+1).func = "useitem";
        }
        
        itemmenu.update();
        checkMouse(itemmenu);
      break;
      case BATTLEBOT:
        displayMonsters();
        //will produce a menu of what battlebots you can switch to
        botmenu.update();
        checkMouse(botmenu);
      break;
      case AI:
        displayMonsters();
        //let the enemy do stuff - will need a decision tree
        if      (getCurrentEnemy().stats.getFloat("chealth") < 15 && random(0.0,1.0) <= 0.99){ // doing bad.
          doMove(getCurrentEnemy(),3,player1);
        }else if(getCurrentEnemy().stats.getFloat("chealth") < 30 && random(0.0,1.0) <= 0.88){ // doing okay
           doMove(getCurrentEnemy(),2,player1);
        }else if(getCurrentEnemy().stats.getFloat("chealth") < 60 && random(0.0,1.0) <= 0.45){ // doing well
           doMove(getCurrentEnemy(),1,player1);
        }else{                              // doing best
           doMove(getCurrentEnemy(),0,player1);
        }
      break;
      case AIANIMATION:
        displayMonsters();
        switch (AI_MOVE_ANIMATION_ID){
          case "attack":
            if (getCurrentEnemy().moveToEnemy(testPlayer.getSelectedMonster())) battlestate = BattleStates.OPTIONS;
          break;
          case "defend":
            if(getCurrentEnemy().defendAnimation()) battlestate = BattleStates.OPTIONS;
          break;
          case "heal":
            if(getCurrentEnemy().healAnimation()) battlestate = BattleStates.OPTIONS;
          break;
          case "dodge":
            if(getCurrentEnemy().dodgeAnimation()) battlestate = BattleStates.OPTIONS;
          break;
        }
      break;
      case RUN:
        //will go back to walk state
        GameState.currentState = GameStates.WALKING;
      break;
    }
  }
  
  public void doMove(int moven){
    doMove(player1.getSelectedMonster(),moven,getCurrentEnemy(),false);
  }
  public void doMove(int moven,boolean targetSelf){
    //System.out.printf("Using move #%d, targeting %s",moven,targetSelf ? "self" : "enemy");
    doMove(player1.getSelectedMonster(),moven,targetSelf ? player1.getSelectedMonster() : getCurrentEnemy(),false);
  }
  public void doMove(Player user,int moven,Player enemy){
    doMove(user.getSelectedMonster(),moven,enemy.getSelectedMonster(),false);
  }
  public void doMove(Player user,int moven,Monster target){
    doMove(user.getSelectedMonster(),moven,target,false);
  }
  public void doMove(Monster user,int moven,Player target){
    doMove(user,moven,target.getSelectedMonster(),true);
  }
  public void doMove(Monster user,int moven,Monster target,boolean ai){
    Move current = user.moveset[moven]; // get the move to use by id
    if (ai) {
      AI_MOVE_ANIMATION_ID = current.stats.getString("movetype");
    } else {
      MOVE_ANIMATION_ID = current.stats.getString("movetype"); // tell the animation which to play
    }
    //System.out.printf("%s uses %s against %s\n",user.id,current.name,target.id);
    current.useMove(target); // take the action, use the move
    switch (ai ? AI_MOVE_ANIMATION_ID : MOVE_ANIMATION_ID) { // start the animation
      case "attack":
        user.moveToEnemyStart(target); 
      break;
      case "defend":
        user.defendStart();
      break;
      case "heal":
        user.healStart();
      break;
      case "dodge":
        user.dodgeStart();
      break;
    }
    currentbattle.switchState(ai ? BattleStates.AIANIMATION : BattleStates.ANIMATION); //at the end, switch battlestate to animation
  }
}
