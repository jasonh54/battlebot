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
    for (int i = 0; i < menulength; i++) {
      buttons.get(i).draw();
    }
  }
  
  //put together + draw buttons in the menu
  void assembleMenuColumn() {
    float temph = 0;
    float tempy = this.y + buttonh + temph;
    for (int i = 0; i < this.menulength; i++) {
      //height and width are arbitrary until we have real sprites
      Button current = new Button(this, this.x + 50, tempy, buttonh, buttonw, "0");
      temph = temph + current.h + spacing;
      tempy = this.y + buttonh + temph;
      buttons.add(current);
    }
  }
  
  //buttons should ve half as wide as they usually are
  void assembleMenuRect() {
    assembleMenuColumn();
    this.x = this.x + + 30;
    assembleMenuColumn();
  }
  
  //set function of a button
  void setFunc(int n, CallBack function) {
      buttons.get(n).setOnClick(function);
  }
  
}
