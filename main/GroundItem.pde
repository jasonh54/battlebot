class GroundItem {
  //variables
  protected String id;
  private Tile parent;
  private PImage sprite;
  private int scale;
  //constructor
  public GroundItem(String id, Tile parent) {
    this.id = id;
    this.parent = parent;
    this.sprite = itemsprites.get(id);
    this.scale = parent.scale;
  }
  
  void draw(){
    image(this.sprite,this.parent.x,this.parent.y,this.sprite.width * this.scale, this.sprite.height * this.scale);
  }
  
  public void update(Player player){
    if (this.parent.checkOverlap(player)){
      player.addItem(this.id);
      dqueue.add(this);
    }
  }
}
