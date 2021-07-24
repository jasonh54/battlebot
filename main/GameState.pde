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
  AI,
  RUN
}

public static class GameState{
   public static GameStates currentState = GameStates.COMBAT;
   public static CombatStates combatState = CombatStates.ENTRY;
   //public static boolean lock = false;
}
