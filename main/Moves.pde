class Moves {
  //variables
  String name;
  String type;
  float accuracy;
  Monster target;
  //need modifiers like damage for every stat (accuracy, speed, etc)
  float damage;
  
  //constructor for everyday use
  public Moves(String name) {
    this.name = name;
    type = movesDatabase.get(name).getString("type");
    accuracy = movesDatabase.get(name).getFloat("accuracy");
    damage = movesDatabase.get(name).getFloat("damage");
  }
  
  //various moves - just one for now
  float calculateAttackMove(Monster self) {
    //determine values of coefficients: type advantage, type efficiency, random value
    Random r = new Random();
    float ranval = r.nextInt(10) + 90;
    ranval = ranval/100;
    float typeff = checkTypeEfficiency(self);
    float typeadv = checkTypeAdvantage();
    //determine if move hits
    if (r.nextInt(100) < this.accuracy) {
      //calculate total power
      float power = this.damage * self.attack/this.target.defense;
      power = power * ranval * typeff * typeadv;
      return power;
    } else {
      return 0;
    }
  }
  
  void useAttackMove(Monster self) {
    //calculate power and make it negative
    float power = calculateAttackMove(self) * -1;
    //convert to an int
    int damage = (int) Math.floor(power);
    this.target.modStats(damage, 1, 1, 1);
  }
  
  float checkTypeAdvantage() {
    if (this.type == this.target.type) {
      return 0.5;
    } else if (this.type == "fire" && target.type == "water" || this.type == "air" && target.type == "earth") {
      return 0.5;
    } else if (this.type == "water" && target.type == "fire" || this.type == "earth" && target.type == "air") {
      return 1.5;
    }
    return 1.0;
  }
  
  float checkTypeEfficiency(Monster self) {
    return this.type == self.type ? 1.5 : 1.0;
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
