class Menu {
  //variables
  float x;
  float y;
  int menulength;
  
  
  ArrayList<Button> buttons = new ArrayList<Button>();
  PImage img;
  
  public Menu(float x, float y, int menulength) {
    this.x = x;
    this.y = y;
    this.menulength = menulength;
  }
  
  void assembleMenu () {
    //temporary coordinates and widths
    float temph = 0;
    float tempy = this.y + 10 + temph;
    for (int i = 0; i < this.menulength - 1; i++) {
      //height and width are arbitrary until we have real sprites
      Button current = new Button(this.x + 10, tempy, 10, 10);
      temph = temph + current.h;
      buttons.add(current);
    }
  }
  
}
