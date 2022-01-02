class Menu implements Clickable,Drawable {
  //variables
  float x;
  float y;
  int buttonh;
  int buttonw;
  int spacing;
  ArrayList<Button> buttons = new ArrayList<Button>();
  
  //constructor
  public Menu(float x, float y, int menulength, int bh, int bw, int th) {
    this.x = x;
    this.y = y;
    this.buttonh = bh;
    this.buttonw = bw;
    this.spacing = th;
    float temph = 0;
    float tempy = this.y + buttonh + temph;
    for (int i = 0; i < menulength; i++) {
      //height and width are arbitrary until we have real sprites
      Button current = new Button(this, x + 50, tempy, bh, bw, "0");
      temph = temph + current.h + spacing;
      tempy = this.y + buttonh + temph;
      buttons.add(current);
    }
  }
  
  void draw() {
    for (Button button : this.buttons) {
      updateDrawables(button);
    }
  }
  boolean isClickable() {return true;};
  float[] getDimensions() {
    return new float[]{this.x,this.y,this.buttonw,(this.buttonh+this.spacing)*(this.buttons.size()+1)};
  }
  void onClick(){
    // doesnt work for some reason updateClickables(this.buttons);
    for (Clickable button : this.buttons){
      updateClickables(button);
    }
  }
}
