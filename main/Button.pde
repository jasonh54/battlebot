interface CallBack {
  //just an interface with a function; it works for some reason
    public void callback();
}

class Button {
  //variables :>
  String txt;
  float x;
  float y;
  float h;
  float w;
  String state;
  String func;
  Menu mymenu;
  //function-storing variable
  CallBack f;
  
  //menu button
  public Button(Menu m, float x, float y, float h, float w, String f) { //this, this.x + 50, tempy, buttonh, buttonw, "0"
    this.x = x;
    this.y = y;
    this.h = h;
    this.w = w;
    this.mymenu = m;
    this.func = f;
  }
  
  //sandwich
  public Button(float x, float y, String f) {
    this.x = x;
    this.y = y;
    this.h = 5;
    this.w = 30;
    this.func = f;
  }
  
  void draw() {
    fill(255, 255, 255);
    if (this.func == "botswap"){ // makeshift solution that doesnt work for duplicate monsters. needs fix.
      for (int i = 0; i<testPlayer.monsters.size();i++){
        Monster monster = testPlayer.monsters.get(i);
        if (monster.stats.getString("name") != this.txt) continue;
        if (monster.stats.getFloat("chealth")<=0) {
          println("Greying out dead bot");
          fill(120,120,120);
          break;
        }else if (testPlayer.selectedmonster==i){
          fill(150,200,150);
          this.func = "return"; // no use swapping to current monster lmfao
          break;
        }
      }
    }
    rect(this.x, this.y, this.w, this.h);
    fill(0, 0, 0);

    if (this.txt != null) {
      text(this.txt, this.x + mymenu.buttonw/4, this.y + mymenu.buttonh/2);
    }
    fill(256, 256, 256);

  }
  
  void drawSandwich() {
    rect(this.x, this.y, this.w, this.h);
    rect(this.x, this.y + (this.h * 2), this.w, this.h);
    rect(this.x, this.y + (this.h * 4), this.w, this.h);
    this.update();
  }
  
  void update(){
    if (mousePressed) {
      //if mouse is touching  a button
      if (mouseX >= this.x && mouseX <= this.x + this.w) {
        if (mouseY >= this.y && mouseY <= this.y + this.h) {
          //next line is only used when the botswap function is called
          //although it is set with every buttonclick
          testPlayer.swapto = this.txt;
          this.onClick();
          delay(naptime);
        }
      }
    }
  }
  
  //sets whatever function is loaded into the parameter into a variable
  public void setOnClick(CallBack function){
    this.f = function;
  }
  
  //use whatever function is stored in the f variable
  public void onClick(){
    if (this.func == "useitem"){
      if (Integer.parseInt(this.txt.split("x")[1].trim()) > 0){
        testPlayer.useItem(this.txt.split("x")[0].trim());
        currentbattle.switchState(BattleStates.AI);
      }
    }else{
      ButtonFunction.runFunction(this.func);
    }
  }
}
