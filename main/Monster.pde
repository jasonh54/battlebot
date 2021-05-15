class Monster {
  //variables
  String id;
  String type;
  float attack;
  float defense;
  float maxhealth;
  float speed;
  PImage image;
  Moves move1, move2, move3, move4;
  Moves[] moveset = {move1, move2, move3, move4};
  
  //constructor
  public Monster(String id) {
    this.id = id;
    type = monsterDatabase.get(id).getString("type");
    attack = monsterDatabase.get(id).getFloat("attack");
    defense = monsterDatabase.get(id).getFloat("defense");
    maxhealth = monsterDatabase.get(id).getFloat("maxhealth");
    speed = monsterDatabase.get(id).getFloat("speed");
    image = spritesHm.get(monsterDatabase.get(id).getString("image"));
    move1 = new Moves(monsterDatabase.get(id).getString("move1"));
    move2 = new Moves(monsterDatabase.get(id).getString("move2"));
    move3 = new Moves(monsterDatabase.get(id).getString("move3"));
    move4 = new Moves(monsterDatabase.get(id).getString("move4"));
    println(id + type + attack + defense + maxhealth + speed + monsterDatabase.get(id).getString("image"));
  }
  
  
  
  //create an "archive" of monster models with predetermined stats (similar to buttonfunction)
  //public Monster will only have an ID parameter
  //ID variable used as a "key" to reach the predetermined stats of a monster model
  //public void retrieveStats() will use the ID to find the associated monster model and set the current monster's stats
  
  
}
