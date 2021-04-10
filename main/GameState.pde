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
<<<<<<< HEAD
   public static GameStates currentState = GameStates.COMBAT;
   public static CombatStates combatState = CombatStates.OPTIONS;
=======
   public static GameStates currentState = GameStates.WALKING;
   public static CombatStates combatState = CombatStates.ENTRY;
>>>>>>> 3b11d98c90b1c68ccdfde714480570ffdcb4aed6

}
