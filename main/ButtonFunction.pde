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
    } else if (num == "return") {
      switchCombatState(CombatStates.OPTIONS);
    } else if (num == "fight") {
      switchCombatState(CombatStates.FIGHT);
    } else if (num == "itemm") {
      switchCombatState(CombatStates.ITEM);
    } else if (num == "bot") {
      switchCombatState(CombatStates.BATTLEBOT);
    } else if (num == "run") {
      switchCombatState(CombatStates.RUN);
    } else if (num.equals("callmove0")) {
      //get a Move and a self monster
      Move current = activeMonster.moveset[0];
      Monster mon = activeMonster;
      moveNum = 1;
      //play animation, alter stats
      current.useMove(testMonster);
      mon.moveToEnemyStart(testMonster);
      //at the end, switch battlestate to AI
      switchCombatState(CombatStates.ANIMATION);
    } else if (num.equals("callmove1")) {
      Move current = activeMonster.moveset[1];
      moveNum = 2;
      current.useMove(activeMonster);
      activeMonster.defendStart();
      switchCombatState(CombatStates.ANIMATION);
    } else if (num.equals("callmove2")) {
      Move current = activeMonster.moveset[2];
      moveNum = 3;
      current.useMove(activeMonster);
      activeMonster.healStart();
      switchCombatState(CombatStates.ANIMATION);
    } else if (num.equals("callmove3")) {
      Move current = activeMonster.moveset[3];
      moveNum = 4;
      current.useMove(activeMonster);
      activeMonster.dodgeStart();
      switchCombatState(CombatStates.ANIMATION);
    }else{
      println("Unrecognized Button Function: '"+num+"' ("+num.getClass()+"). [callmove0=="+num+" "+num.equals("callmove0")+"] ("+"callmove0".getClass()+")");
    }
  }
}
