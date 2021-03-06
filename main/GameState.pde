enum GameStates{
  WALKING,
  COMBAT,
  MENU
}

public static class GameState{
   public static GameStates currentState = GameStates.COMBAT;
}
