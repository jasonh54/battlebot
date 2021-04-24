class Moves {
  //variables
  public HashMap<String,Moves> allmoves = new HashMap<String,Moves>();
  String name;
  float type;
  float accuracy;
  float damage;
  int target;
  
  //constructor for archive moves only
  public Moves(String name, float type, float acc, float dam, int tar) {
    
  }
  
  //constructor for everyday use
  public Moves(String name) {
    this.name = name;
  }
  
  public void retrieveStats() {
    Moves storage = allmoves.get(name);
    this.type = storage.type;
    this.accuracy = storage.accuracy;
    this.damage = storage.accuracy;
    this.target = storage.target;
  }
  
  //implement archive system similar to in monster file

}
