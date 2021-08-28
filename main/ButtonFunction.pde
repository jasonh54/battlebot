public static class ButtonFunction {
  
  public ButtonFunction() {
    
  }
  
  public static void switchState(GameStates s) {
    GameState.currentState = s;
  }
  public static void switchCombatState(CombatStates s) {
    GameState.combatState = s;
  }
  
  public static void runFunction(String num) {
    //filler func
    if (num == "0") {
      println("this button has been clicked " + GameState.currentState);
    //swap to various states
    } else if (num == "menu") {
      switchState(GameStates.MENU);
    } else if (num == "walk") {
      switchState(GameStates.WALKING);
    //toggle between walking + menu
    } else if (num == "toggle") {
      if (GameState.currentState == GameStates.WALKING) {
        switchState(GameStates.MENU);
      } else if (GameState.currentState == GameStates.MENU) {
        switchState(GameStates.WALKING);
      }
    //swap to various combat states
    } else if (num == "fight") {
      switchCombatState(CombatStates.FIGHT);
    } else if (num == "itemm") {
      switchCombatState(CombatStates.ITEM);
    } else if (num == "bot") {
      switchCombatState(CombatStates.BATTLEBOT);
    } else if (num == "run") {
      switchCombatState(CombatStates.RUN);
    } else if (num == "callmove0") {
      //get a Move and a self monster
      Moves current = activeMonster.move1;
      Monster mon = activeMonster;
      moveNum = 1;
      //play animation, alter stats
      current.useAttackMove(mon);
      mon.moveToEnemyStart(testMonster);
      //at the end, switch battlestate to AI
      switchCombatState(CombatStates.ANIMATION);
    } else if (num == "callmove1") {

      Moves current = activeMonster.move2;

      Monster mon = activeMonster;
      moveNum = 2;

      //
      mon.defendStart();
      switchCombatState(CombatStates.ANIMATION);
    } else if (num == "callmove2") {
      Moves current = activeMonster.move3;
      Monster mon = activeMonster;
      moveNum = 3;
      //
      mon.healStart();
      switchCombatState(CombatStates.ANIMATION);
    } else if (num == "callmove3") {
      Moves current = activeMonster.move4;
      Monster mon = activeMonster;
      moveNum = 4;
      //

      mon.dodgeStart();
      switchCombatState(CombatStates.ANIMATION);
    } else if (num == "useitem") {
      JSONObject stats = testPlayer.useItem("id"); //oh no <error here>
      activeMonster.attack *= stats.getInt("attack");
      activeMonster.defense *= stats.getInt("defense");
      activeMonster.speed *= stats.getInt("speed");
      activeMonster.addHp(stats.getInt("health"));

    }
  }
  public static void useItem(String id){
    switchCombatState(CombatStates.ITEM);
    JSONObject stats = testPlayer.useItem(id);
    activeMonster.attack *= stats.getInt("attack");
    activeMonster.defense *= stats.getInt("defense");
    activeMonster.speed *= stats.getInt("speed");
    activeMonster.addHp(stats.getInt("health"));
  }
}
