interface CallBack {
  //just an interface with a function; it works for some reason
    public void callback();
}

class Button {
  PImage img;
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
  
  
  
  
  //sets whatever function is loaded into the parameter into a variable
  public void setOnClick(CallBack function){
    this.f = function;
  }
  //use whatever function is stored in the f variable
  public void onClick(){
    f.callback();
  }
  
}
