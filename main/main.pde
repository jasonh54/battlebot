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

void draw(){

}
