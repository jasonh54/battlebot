class Move {
  //variables
  String name;
  JSONObject stats;
  Monster parent;
  
  //constructor for everyday use
  public Move(Monster parent, String name) {
    this.name = name;
    this.parent = parent;
    this.stats = movesDatabase.get(name);
  }
  
  void useMove(Monster target){
    float hpmod = this.stats.getInt("health");
    if (hpmod < 0){
      hpmod = moveEfficency(target);
    }
    target.modStats(JSONCopy(this.stats).setFloat("health",hpmod));
  }
  
  //various moves - just one for now
  private float moveEfficency(Monster target) {
    //determine values of coefficients: type advantage, type efficiency, random value
    Random r = new Random();
    float ranval = r.nextInt(10) + 90;
    ranval = ranval/100;
    //determine if move hits
    if (r.nextInt(100) < this.stats.getInt("accuracy")) {
      //calculate total power
      float power = (this.parent.stats.getFloat("attack") * this.stats.getInt("health"))/target.stats.getFloat("defense") * ranval * typeEfficency(target);
      return power;
    } else {
      return 0;
    }
  }
  
  private float typeEfficency(Monster target) {
    String movetype = this.stats.getString("type");
    float moveEfficency = movetype == this.parent.type ? 1.5 : 1.0;
    float monsterEfficency = 1.0;
 
    if (movetype == target.type) {
      monsterEfficency = 0.5;
    } else if (movetype == "fire" && target.type == "water" || movetype == "air" && target.type == "earth") {
      monsterEfficency = 0.5;
    } else if (movetype == "water" && target.type == "fire" || movetype == "earth" && target.type == "air") {
      monsterEfficency = 1.5;
    }
    return moveEfficency*monsterEfficency;
  }
}
