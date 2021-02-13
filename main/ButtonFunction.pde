public static class ButtonFunction {
  
  public ButtonFunction() {
    
  }
  
  public static void switchState(GameStates s) {
    GameState.currentState = s;
  }
  
  public static void runFunction(int num) {
    if (num == 0) {
      println("this button has been clicked " + GameState.currentState);
    } else if (num == 1) {
      switchState(GameStates.MENU);
    } else if (num == 2) {
      switchState(GameStates.WALKING);
    } else if (num == 3) {
      println("clicked on: " + GameState.currentState);
      if (GameState.currentState == GameStates.WALKING) {
        switchState(GameStates.MENU);
      } else if (GameState.currentState == GameStates.MENU) {
        switchState(GameStates.WALKING);
      }
    }
  }
}
