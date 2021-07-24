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
    for (int i = 0; i < this.menulength - 1; i++) {
      //height and width are arbitrary until we have real sprites
      Button current = new Button(this, x + 50, y+(bh+th)*i, bh, bw, "0"); // likely erronius code
      this.buttons.add(current);
      println("new Button("+this+", "+x + 50+", "+y+(bh+th)*i+", "+bh+", "+bw+", '0')");
    }
  }
  
  void update() {
    this.draw();
  }
  
  void draw() {
    for (int i = 0; i < menulength - 1; i++) {
      buttons.get(i).draw();
    }
  }
  //set function of a button
  void setFunc(int n, CallBack function) {
      buttons.get(n).setOnClick(function);
  }
}
