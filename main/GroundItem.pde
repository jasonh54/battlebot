class GroundItem {
  //variables
  String id;
  Tile parent;
  PImage sprite;
  int scale;
  //constructor
  public GroundItem(String id, Tile parent) {
    this.id = id;
    this.parent = parent;
    this.sprite = itemsprites.get(id);
    this.scale = parent.scale;
  }
  
  void display(){
    image(this.sprite,this.parent.x,this.parent.y,this.sprite.width * this.scale, this.sprite.height * this.scale);
  }
  int colCheck(Player player){
    if (this.parent.checkOverlap(player)){
      player.addItem(this.id);

      println("Item Added to Player! "+player.items);
      println("Returning index to remove with: "+items.indexOf(this));

      return items.indexOf(this);
    }
    return -1;
  }
}
