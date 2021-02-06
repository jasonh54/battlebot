public static class ButtonFunction{
  
  public ButtonFunction(){
  }
  
  public static void switchState(GameStates s){
    GameState.currentState = s;
  }
  
  public static void runFunction(int num){
    if(num==1){
      switchState(GameStates.MENU);
    }
  }
}
