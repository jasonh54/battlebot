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
  
}

void draw(){

}
