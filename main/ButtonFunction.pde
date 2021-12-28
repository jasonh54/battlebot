public static class ButtonFunction {
  
  public ButtonFunction() {
    
  }
  
  public static void switchState(GameStates s) {
    GameState.currentState = s;
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
      currentbattle.switchState(BattleStates.OPTIONS);
    } else if (num == "fight") {
      currentbattle.switchState(BattleStates.FIGHT);
    } else if (num == "item") {
      currentbattle.switchState(BattleStates.ITEM);
    } else if (num == "bot") {
      currentbattle.switchState(BattleStates.BATTLEBOT);
    } else if (num == "run") {
      currentbattle.switchState(BattleStates.RUN);
    } else if (num.startsWith("callmove")) {
      Integer i = Integer.parseInt(num.substring(num.length()-1));
      currentbattle.doMove(i,i != 0);
    } else if (num == "botswap") {
      //instead of taking a parameter; the BATTLEBOT gamestate will set testPlayer.swapto = [txt of clicked button]
      for (int i = 0; i < testPlayer.monsters.size(); i++) {
        //in the botswap func, program will find a monster in testPlayer.monsters with a monster ID that is equal to testPlayer.swapto
         if (testPlayer.monsters.get(i).id == testPlayer.swapto&&testPlayer.monsters.get(i).stats.getFloat("chealth")>0) {
           testPlayer.selectedmonster = i;
           currentbattle.switchState(BattleStates.OPTIONS);
           break;
         }
      }
      
    }
  }
}
