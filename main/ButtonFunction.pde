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
      println("tofight");
      switchCombatState(CombatStates.FIGHT);
    } else if (num == "item") {
      switchCombatState(CombatStates.ITEM);
    } else if (num == "bot") {
      switchCombatState(CombatStates.BATTLEBOT);
    } else if (num == "run") {
      switchCombatState(CombatStates.RUN);

    } else if (num.equals("callmove0")) {


      //get a Move and a self monster
      println("move1 used");
      Moves current = activeMonster.move1;
      Monster mon = activeMonster;
      moveNum = 1;
      //play animation, alter stats
      current.useAttackMove(mon);
      mon.moveToEnemyStart(testMonster);
      //at the end, switch battlestate to animation
      switchCombatState(CombatStates.ANIMATION);

    } else if (num.equals("callmove1")) {

      Moves current = activeMonster.move2;
      Monster mon = activeMonster;
      moveNum = 2;
      mon.defendStart();
      switchCombatState(CombatStates.ANIMATION);
    } else if (num.equals("callmove2")) {
      Moves current = activeMonster.move3;
      Monster mon = activeMonster;
      moveNum = 3;
      //
      mon.healStart();
      switchCombatState(CombatStates.ANIMATION);
    } else if (num.equals("callmove3")) {
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

    } else if (num == "botswap") {
      //instead of taking a parameter; the BATTLEBOT gamestate will set testPlayer.swapto = [txt of clicked button]
      Monster temp;
      for (int i = 0; i < testPlayer.monsters.size(); i++) {
        //in the botswap func, program will find a monster in testPlayer.monsters with a monster ID that is equal to testPlayer.swapto
         if (testPlayer.monsters.get(i).id == testPlayer.swapto) {
           //the desired monster will first be saved into a temporary variable
           temp = testPlayer.monsters.get(i);
           //then old copy of the monster will be deleted
           testPlayer.monsters.remove(i);
           //the old activeMonster's stats will be saved into testPlayer.monsters, effectively "swapping" with the desired monster
           testPlayer.monsters.add(activeMonster);
           //the desired monster  will be saved to activeMonster, and the swap willbe completed
           activeMonster = temp;
           println("swap completed. current activeMonster is: " + activeMonster.id);
           break;
         }
      }
      switchCombatState(CombatStates.OPTIONS);

    }
  }
  public static void useItem(String id){
    switchCombatState(CombatStates.ITEM);
    JSONObject stats = testPlayer.useItem(id);
    activeMonster.modStats((float)stats.getInt("health"),stats.getFloat("attack"),stats.getFloat("speed"),stats.getFloat("defense"),1);
    // maybe play animation
    switchCombatState(CombatStates.OPTIONS);
  }
}
