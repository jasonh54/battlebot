enum GameStates{
  WALKING,
  COMBAT,
  MENU
}

enum CombatStates{
  ENTRY,
  OPTIONS,
  FIGHT,
  ITEM,
  BATTLEBOT,
  RUN
}

public static class GameState{
   public static GameStates currentState = GameStates.COMBAT;
   public static CombatStates combatState = CombatStates.ENTRY;
}
