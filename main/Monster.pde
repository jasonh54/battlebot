class Monster {
  //variables
  String id;
  String type;
  float attack;
  float defense;
  float maxhealth;
  float speed;
  Moves move1, move2, move3, move4;
  Moves[] moveset = {move1, move2, move3, move4};
  
  //constructor
  public Monster(String id) {
    this.id = id;
  }
  
  //create an "archive" of monster models with predetermined stats (similar to buttonfunction)
  //public Monster will only have an ID parameter
  //ID variable used as a "key" to reach the predetermined stats of a monster model
  //public void retrieveStats() will use the ID to find the associated monster model and set the current monster's stats
  
  
}
