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
  Menu mymenu;
  //function-storing variable
  CallBack f;
  
  public Button(Menu m, float x, float y, float h, float w) {
    this.x = x;
    this.y = y;
    this.h = h;
    this.w = w;
    this.mymenu = m;
  }
  
  void draw() {
    rect(this.x, this.y, this.w, this.h);
    fill(0, 0, 0);
    text(this.txt, this.x + mymenu.buttonw/4, this.y + mymenu.buttonh/2);
    fill(256, 256, 256);
  }
  
  void drawSandwich() {
    
  }
  
  //########################################################################
  //########################################################################
  //depreciated code will delete
  //########################################################################
  //########################################################################
  //sets whatever function is loaded into the parameter into a variable
  public void setOnClick(CallBack function){
    this.f = function;
  }
  //########################################################################
  //########################################################################
  //depreciated code will delete
  //########################################################################
  //########################################################################
  
  //use whatever function is stored in the f variable
  public void onClick(){
    f.callback();
  }
  
  
  
  
}
