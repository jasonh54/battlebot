public static class ButtonFunction {
  
  public ButtonFunction() {
    
  }
  
  public static void switchState(GameStates s) {
    GameState.currentState = s;
  }
  public static void switchCombatState(CombatStates s) {
    GameState.combatState = s;
  }
  
  public static void runFunction(int num) {
    //filler func
    if (num == 0) {
      println("this button has been clicked " + GameState.currentState);
    //swap to various states
    } else if (num == 1) {
      switchState(GameStates.MENU);
    } else if (num == 2) {
      switchState(GameStates.WALKING);
    //toggle between walking + menu
    } else if (num == 3) {
      println("clicked on: " + GameState.currentState);
      if (GameState.currentState == GameStates.WALKING) {
        switchState(GameStates.MENU);
      } else if (GameState.currentState == GameStates.MENU) {
        switchState(GameStates.WALKING);
      }
    //swap to various combat states
    } else if (num == 4) {
      switchCombatState(CombatStates.FIGHT);
    } else if (num == 5) {
      switchCombatState(CombatStates.ITEM);
    } else if (num == 6) {
      switchCombatState(CombatStates.BATTLEBOT);
    } else if (num == 7) {
      switchCombatState(CombatStates.RUN);
    }
  }
}
