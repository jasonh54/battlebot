class Button implements Clickable,Drawable {
  //variables :>
  String txt;
  float x;
  float y;
  float h;
  float w;
  String func;
  String buttontype;
  Menu mymenu;
  
  //menu button
  public Button(Menu m, float x, float y, float h, float w, String f) { //this, this.x + 50, tempy, buttonh, buttonw, "0"
    this.x = x;
    this.y = y;
    this.h = h;
    this.w = w;
    this.mymenu = m;
    this.buttontype = "default";
    this.func = f;
  }
  //sandwich
  public Button(float x, float y, String f) {
    this.x = x;
    this.y = y;
    this.h = 5;
    this.w = 30;
    this.buttontype = "sandwich";
    this.func = f;
  }
  
  void draw() {
    switch (this.buttontype) {
      case "sandwich":
        rect(this.x, this.y, this.w, this.h);
        rect(this.x, this.y + (this.h * 2), this.w, this.h);
        rect(this.x, this.y + (this.h * 4), this.w, this.h);
      break;
      default:
        int[] fillc = {255,255,255};
        if (this.func == "botswap"){ // makeshift solution that doesnt work for duplicate monsters. needs fix.
          for (int i = 0;i<testPlayer.monsters.size();i++){
            Monster monster = testPlayer.monsters.get(i);
            if (monster.id != this.txt) continue;
            //println("Found valid monster for this button: "+monster.id);
            if (monster.stats.getFloat("chealth")<=0.0) {
              println("Greying out: "+monster.stats.getString("name"));
              fillc[0]=120;fillc[1]=120;fillc[2]=120;
              break;
            }else if (testPlayer.selectedmonster==i){
              fillc[0]=150;fillc[1]=230;fillc[2]=150;
              break;
            }else{
              //println("Did not find special format for "+monster.stats.getString("name"));
            }
          }
        }
        fill(fillc[0],fillc[1],fillc[2]);
        rect(this.x, this.y, this.w, this.h);
        fill(0, 0, 0);
    
        if (this.txt != null) {
          text(this.txt, this.x + mymenu.buttonw/4, this.y + mymenu.buttonh/2);
        }
        fill(256, 256, 256);
      break;
    }
  }
  
  float[] getDimensions() {
    return new float[]{this.x,this.y,this.w,this.h};
  }
  boolean isClickable() {return true;};
  
  //use whatever function is stored in the f variable
  public void onClick(){
    switch (this.func) {
      case "0":
        warn("Empty function has been run!");
      break;
      case "useitem"://use an item
        if (testPlayer.items.containsKey(this.txt.split("x")[0].trim()) && testPlayer.items.get(this.txt.split("x")[0].trim()) > 0){ // more than 0 items (check database instead of button)
          testPlayer.useItem(this.txt.split("x")[0].trim());
          currentbattle.switchState(BattleStates.AI);
        }
      break;
      case "toggle":// enter/exit menu
        if (GameState.currentState == GameStates.WALKING) {
          GameState.switchState(GameStates.MENU);
        } else if (GameState.currentState == GameStates.MENU) {
          GameState.switchState(GameStates.WALKING);
        }
      break;
      case "return":// return to the actions menu
        currentbattle.switchState(BattleStates.OPTIONS);
      break;
      case "fight": // switch menu to show moves
        currentbattle.switchState(BattleStates.FIGHT);
      break;
      case "item":  // switch menu to show items
        currentbattle.switchState(BattleStates.ITEM);
      break;
      case "bot":   // switch menu to show battlebots
        currentbattle.switchState(BattleStates.BATTLEBOT);
      break;
      case "run":
        currentbattle.switchState(BattleStates.RUN);
      break;
      case "botswap":// switch battlebot
        for (int n = 0; n < testPlayer.monsters.size(); n++) {
          //in the botswap func, program will find a monster in testPlayer.monsters with a monster ID that is equal to testPlayer.swapto
          if (testPlayer.monsters.get(n).id == this.txt&&testPlayer.monsters.get(n).stats.getFloat("chealth")>0) {
            testPlayer.selectedmonster = n;
            currentbattle.switchState(BattleStates.OPTIONS);
            return;
          }
        }
        warn("Botswap did not find a valid monster to switch to! [For "+this.txt+"]");
      break;
      default:
        if (this.func.startsWith("callmove")){ // execute a move in the battle
          Integer i = Integer.parseInt(this.func.substring(this.func.length()-1));
          currentbattle.doMove(i,i != 0);
        }else{
          warn("Unrecognized ButtonFunction: "+this.func);
        }
    }
  }
}
