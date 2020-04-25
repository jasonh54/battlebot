import java.util.*;
import java.io.File;

void setup(){

  String path = sketchPath().substring(0, sketchPath().length()-4) + "images";
  File sprites = new File(path);
  
  String[] spriteList = sprites.list();
  PImage[] spritesPM = new PImage[spriteList.length]; //sprites PImage
  HashMap<String,PImage> spritesHm = new HashMap<String,PImage>(); // sprites hashmap
  
  for(int i = 0; i < spriteList.length; i++){
    spritesPM[i] = loadImage(path + "/" + spriteList[i]);
    spritesHm.put(spriteList[i].substring(0, spriteList[i].length()-4), spritesPM[i]);
  }
  //generate tiles, columns left to right
  Tile topleft = new Tile(25, 25, false, false);
  Tile prev = topleft;
  Tile current;
  //row: create new tile to the right once column is down
  for (int i = 0; i < 10; i++) {
    //column: new tiles below
    for (int k = 0; k < 10; k++) {
      current = new Tile(prev.x, prev.y + 50, false, false);
      prev = current;
    }
    current = new Tile(prev.x + 50, 25, false, false);
    prev = current;
  }
}


//implement a statemachine
//walking state - player walking around the world, draws the world
//combat state - player encounters and enemy - draws the enemy
//in the combat state we could have another state machine to denote, picking a move, animate attacks, calcualte damage, back to picking a move, etc.


void draw(){

}
