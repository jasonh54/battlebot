enum GameStates{
  WALKING,
  COMBAT,
  MENU
}

enum CombatStates{
  ENTRY,
  OPTIONS,
  FIGHT,
  ANIMATION,
  ITEM,
  BATTLEBOT,
  AI,
  AIANIMATION,
  RUN
}

public static class GameState{
   public static GameStates currentState = GameStates.WALKING;
   public static CombatStates combatState = CombatStates.ENTRY;
   //public static boolean lock = false;
}
