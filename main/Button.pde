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
  //function-storing variable
  CallBack f;
  
  public Button(float x, float y, float h, float w) {
    this.x = x;
    this.y = y;
    this.h = h;
    this.w = w;
  }
  
  void draw() {
    rect(this.x, this.y, this.w, this.h);
    text(this.txt, this.x, this.y);
  }
  
  //sets whatever function is loaded into the parameter into a variable
  public void setOnClick(CallBack function){
    this.f = function;
  }
  
  //use whatever function is stored in the f variable
  public void onClick(){
    f.callback();
  }
  
}
