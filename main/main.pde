import java.util.*;
import java.io.File;

void setup(){

  String path = sketchPath().substring(0, sketchPath().length()-4) + "images";
  File sprites = new File(path);
  String[] spriteList = sprites.list();
  HashMap<String,PImage> spritesHm = new HashMap<String,PImage>(); // sprites hashmap
  
  for(String name : spriteList){
    
  }
  


}


//implement a statemachine
//walking state - player walking around the world, draws the world
//combat state - player encounters and enemy - draws the enemy
//in the combat state we could have another state machine to denote, picking a move, animate attacks, calcualte damage, back to picking a move, etc.


void draw(){

}
