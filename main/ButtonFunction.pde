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
      println("clicked on: " + GameState.currentState);
      if (GameState.currentState == GameStates.WALKING) {
        switchState(GameStates.MENU);
      } else if (GameState.currentState == GameStates.MENU) {
        switchState(GameStates.WALKING);
      }
    //swap to various combat states
    } else if (num == "fight") {
      switchCombatState(CombatStates.FIGHT);
    } else if (num == "item") {
      switchCombatState(CombatStates.ITEM);
    } else if (num == "bot") {
      switchCombatState(CombatStates.BATTLEBOT);
    } else if (num == "run") {
      switchCombatState(CombatStates.RUN);
    } else if (num == "callmove0") {
      //get a Move and a self monster
      Moves current = activeMonster.move1;
      Monster mon = activeMonster;
      //play animation, alter stats
      println("move 1 used");
      current.useAttackMove(mon);
      
      //at the end, switch battlestate to AI

      
    } else if (num == "callmove1") {
      //
    } else if (num == "callmove2") {
      Moves current = activeMonster.move3;
      //
    } else if (num == "callmove3") {
      Moves current = activeMonster.move4;
      //

    } else if (num == "useitem") {
      JSONObject stats = testPlayer.useItem("id"); //oh no <error here>
      activeMonster.attack *= stats.getInt("attack");
      activeMonster.defense *= stats.getInt("defense");
      activeMonster.speed *= stats.getInt("speed");
      activeMonster.addHp(stats.getInt("health"));
    }

  }
}
