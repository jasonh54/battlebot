class Monster {
  //variables
  String id;
  String type;
  float attack;
  float defense;
  float health;
  float speed;
  Moves move1, move2, move3, move4;
  
  //constructor
  public Monster(String id, String type, float attack, float defense, float health, float speed) {
    this.id = id;
    this.type = type;
    this.attack = attack;
    this.defense = defense;
    this.health = health;
    this.speed = speed;
  }
  
  
}
