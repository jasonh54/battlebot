class Menu {
  //variables
  float x;
  float y;
  int menulength;
  int buttonh;
  int buttonw;
  int spacing;
  PImage img;
  ArrayList<Button> buttons = new ArrayList<Button>();
  
  //constructor
  public Menu(float x, float y, int menulength, int bh, int bw, int th) {
    this.x = x;
    this.y = y;
    this.menulength = menulength;
    this.buttonh = bh;
    this.buttonw = bw;
    this.spacing = th;
  }
  
  void update() {
    this.draw();
  }
  
  void draw() {
    for (int i = 0; i < menulength - 1; i++) {
      buttons.get(i).draw();
    }
  }
  
  //put together + draw buttons in the menu
  void assembleMenuColumn() {
    //temporary coordinates and widths
    float temph = 0;
    float tempy = this.y + buttonh + temph;
    for (int i = 0; i < this.menulength - 1; i++) {
      //height and width are arbitrary until we have real sprites
      Button current = new Button(this, this.x + 50, tempy, buttonh, buttonw, "0");
      temph = temph + current.h + spacing;
      tempy = this.y + buttonh + temph;
      buttons.add(current);
    }
  }
  
  //set function of a button
  void setFunc(int n, CallBack function) {
      buttons.get(n).setOnClick(function);
  }
  
}
