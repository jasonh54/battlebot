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
      switchCombatState(CombatStates.FIGHT);
    } else if (num == "item") {
      switchCombatState(CombatStates.ITEM);
    } else if (num == "bot") {
      switchCombatState(CombatStates.BATTLEBOT);
    } else if (num == "run") {
      switchCombatState(CombatStates.RUN);

    } else if (num.equals("callmove0")) {
      Move current = activeMonster.moveset[0]; // get the move to use
      moveNum = 1; // tell the animation which to play
      current.useMove(testMonster); // take the action, use the move
      activeMonster.moveToEnemyStart(testMonster); // start the animation
      switchCombatState(CombatStates.ANIMATION); //at the end, switch battlestate to animation
    } else if (num.equals("callmove1")) {
      Move current = activeMonster.moveset[1];
      moveNum = 2;
      current.useMove(activeMonster);
      activeMonster.defendStart();
      switchCombatState(CombatStates.ANIMATION);
    } else if (num.equals("callmove2")) {
      Move current = activeMonster.moveset[2];
      moveNum = 3;
      current.useMove(activeMonster);
      activeMonster.healStart();
      switchCombatState(CombatStates.ANIMATION);
    } else if (num.equals("callmove3")) {
      Move current = activeMonster.moveset[3];
      moveNum = 4;
      current.useMove(activeMonster);
      activeMonster.dodgeStart();
      switchCombatState(CombatStates.ANIMATION);
    }  else if (num == "botswap") {
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
           break;
         }
      }
      switchCombatState(CombatStates.OPTIONS);

    }
  }
}
