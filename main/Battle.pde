enum BattleStates {
  ENTRY,
  OPTIONS,
  WIN,
  
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
  public HashMap<BattleStates,Menu> menus;
  
  public Battle(Player p1, Player p2){
    this.player1 = p1;
    this.player2 = p2;
    this.battlestate = BattleStates.ENTRY;
    init();
  }
  public Battle(Player p1, Monster e2){
    this.player1 = p1;
    this.enemy2 = e2;
    this.battlestate = BattleStates.ENTRY;
    init();
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
  
  private void init(){ // fill all menus with default values
    this.menus = new HashMap<BattleStates,Menu>();
  
    Menu battlemenu = new Menu(625, 520, 4, 45, 400, 2); //values for battle menu
    battlemenu.buttons.get(0).txt = "move";
    battlemenu.buttons.get(0).func = "fight";
    battlemenu.buttons.get(1).txt = "item";
    battlemenu.buttons.get(1).func = "item";
    battlemenu.buttons.get(2).txt = "battlebots";
    battlemenu.buttons.get(2).func = "bot";
    battlemenu.buttons.get(3).txt = "run";
    battlemenu.buttons.get(3).func = "run";
    this.menus.put(BattleStates.OPTIONS,battlemenu);
    
    Menu movemenu = new Menu(625, 520, 5, 30, 400, 2); //values for move menu - no txt as it is custom to the current battle
    movemenu.buttons.get(0).txt = "Return to Menu";
    movemenu.buttons.get(0).func = "return";
    movemenu.buttons.get(1).func = "callmove0";
    movemenu.buttons.get(2).func = "callmove1";
    movemenu.buttons.get(3).func = "callmove2";
    movemenu.buttons.get(4).func = "callmove3";
    this.menus.put(BattleStates.FIGHT,movemenu);

    Menu botmenu; //values for botmenu
    botmenu = new Menu(625, 520, testPlayer.monsters.size(), 50, 400, 2);
    for (int i = 0; i < botmenu.buttons.size(); i++) {
      botmenu.buttons.get(i).txt = testPlayer.monsters.get(i).id;
      botmenu.buttons.get(i).func = "botswap";
    }
    this.menus.put(BattleStates.BATTLEBOT,botmenu);
  
    Menu itemmenu;
    itemmenu = new Menu(625, 520, this.player1.items.size()+1, 40, 300, 2);
    itemmenu.buttons.get(0).txt = "Return to Menu";
    itemmenu.buttons.get(0).func = "return";
    for (int i = 1; i < itemmenu.buttons.size(); i++) {
      itemmenu.buttons.get(i).func = "useitem";
    }
    this.menus.put(BattleStates.ITEM,itemmenu);
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
        checkDead(this.player1.getSelectedMonster(),getCurrentEnemy());
        displayMonsters();
        //this happens once at the beginning of every turn; the part where you select what you want to do
        //draw same as Entry State
      break;
      case FIGHT:
        displayMonsters();
        //txt defined here at it is custom to the current battle
        //will produce a menu of what moves the battle bot can use
        for (int i = 0; i < 4; i++) {
          //give move buttons functions based on their moves
          this.menus.get(BattleStates.FIGHT).buttons.get(i+1).txt = this.player1.getSelectedMonster().moveset[i].name;
        }
      break;
      case ANIMATION:
        displayMonsters();
        switch (MOVE_ANIMATION_ID){
          case "attack":
            if(this.player1.getSelectedMonster().moveToEnemy(getCurrentEnemy())){
              battlestate = BattleStates.AI;
            }
          break;
          case "defend":
            if(this.player1.getSelectedMonster().defendAnimation()){
              battlestate = BattleStates.AI;
            }
          break;
          case "heal":
            if(this.player1.getSelectedMonster().healAnimation()){
              battlestate = BattleStates.AI;
            }
          break;
          case "dodge":
            if(this.player1.getSelectedMonster().dodgeAnimation()){
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
        Object[] itemsKeys = this.player1.items.keySet().toArray();
        for (int i = 0; i < this.player1.items.size(); i++) {
          String itemi = (String)itemsKeys[i];
          this.menus.get(BattleStates.ITEM).buttons.get(i+1).txt = itemi+" x "+this.player1.items.get(itemi);
        }
      break;
      case BATTLEBOT:
        displayMonsters();
        //will produce a menu of what battlebots you can switch to
      break;
      case AI:
        checkDead(this.player1.getSelectedMonster(),getCurrentEnemy());
        displayMonsters();
        //let the enemy do stuff - will need a decision tree
        if      (getCurrentEnemy().stats.getFloat("chealth") < 15 && random(0.0,1.0) <= 0.99){ // doing bad.
           doMove(getCurrentEnemy(),3,getCurrentEnemy(),true);
        }else if(getCurrentEnemy().stats.getFloat("chealth") < 30 && random(0.0,1.0) <= 0.88){ // doing okay
           doMove(getCurrentEnemy(),2,getCurrentEnemy(),true);
        }else if(getCurrentEnemy().stats.getFloat("chealth") < 60 && random(0.0,1.0) <= 0.45){ // doing well
           doMove(getCurrentEnemy(),1,getCurrentEnemy(),true);
        }else{                              // doing best
           doMove(getCurrentEnemy(),0,player1);
        }
      break;
      case AIANIMATION:
        displayMonsters();
        switch (AI_MOVE_ANIMATION_ID){
          case "attack":
            if (getCurrentEnemy().moveToEnemy(this.player1.getSelectedMonster())) battlestate = BattleStates.OPTIONS;
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
      case WIN:
        println("You won!");
        GameState.currentState = GameStates.WALKING;
      break;
    }
    if (menus.get(battlestate) != null){
      updateDrawables(menus.get(battlestate));
      updateClickables(menus.get(battlestate));
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
  
  private void checkDead(Monster m1, Monster m2){   
    if (m1.stats.getFloat("chealth")<=0){ // is our current monster dead?
      for (int i = 0; i < this.player1.monsters.size(); i++){ // iterate thru available monsters
        if (this.player1.monsters.get(i).stats.getFloat("chealth")>0){ // find monster with enough health
          this.player1.selectedmonster = i; // swap to that monster
          break;
        }
      }
    }
    if (m2.stats.getFloat("chealth")<=0){
      currentbattle.switchState(BattleStates.WIN); // you won!!
    }
  }
}
