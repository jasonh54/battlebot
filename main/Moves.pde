class Moves {
  //variables
  String name;
  String type;
  float accuracy;
  float damage;
  int target;
  
  //constructor for archive moves only
  public Moves(String name, float type, float acc, float dam, int tar) {
    
  }
  
  //constructor for everyday use
  public Moves(String name) {
    this.name = name;
    type = movesDatabase.get(name).getString("type");
    accuracy = movesDatabase.get(name).getFloat("accuracy");
    damage = movesDatabase.get(name).getFloat("damage");
    println(name + type + accuracy + damage);
  }
  
  /* public void retrieveStats() {
    Moves storage = [name of hashmap].get(name);
    this.type = storage.type;
    this.accuracy = storage.accuracy;
    this.damage = storage.accuracy;
    this.target = storage.target;
  } */
  
  //implement archive system similar to in monster file

}
