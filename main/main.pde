import java.util.*;
import java.io.File;

void setup(){

  String path = sketchPath().substring(0, sketchPath().length()-4) + "images";
  File sprites = new File(path);
  
  String[] spriteList = sprites.list();
  PImage[] spritesPM = new PImage[spriteList.length]; //sprites PImage
  HashMap<String,PImage> spritesHm = new HashMap<String,PImage>(); // sprites hashmap
  
  for(int i = 0; i < spriteList.length; i++){
    spritesPM[i] = loadImage(path + "\\" + spriteList[i]);
    spritesHm.put(spriteList[i].substring(0, spriteList[i].length()-4), spritesPM[i]);
  }
  
<<<<<<< HEAD


=======
>>>>>>> 76dfbefd80a4b117a2614b42a8dba9ac9f9f248d
}


//implement a statemachine
//walking state - player walking around the world, draws the world
//combat state - player encounters and enemy - draws the enemy
//in the combat state we could have another state machine to denote, picking a move, animate attacks, calcualte damage, back to picking a move, etc.


void draw(){

}
