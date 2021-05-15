class Moves {
  //variables
  String name;
  String type;
  float accuracy;
  float damage;
  
  //constructor
  public Moves (String name) {
    this.name = name;
    type = movesDatabase.get(name).getString("type");
    accuracy = movesDatabase.get(name).getFloat("accuracy");
    damage = movesDatabase.get(name).getFloat("damage");
    println(name + type + accuracy + damage);
  }
  
  //implement archive system similar to in monster file

}
