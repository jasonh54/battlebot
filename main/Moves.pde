class Moves {
  //variables
  float type;
  float accuracy;
  float damage;
  PImage visual;
  Monster target;
  
  //constructor
  public Moves (float type, float accuracy, float damage, Monster target, PImage visual) {
    this.type = type;
    this.accuracy = accuracy;
    this.damage = damage;
    this.target = target;
    this.visual = visual;
  }


}
