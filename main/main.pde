import java.util.*;
import java.io.File;
import java.util.concurrent.TimeUnit;

HashMap<String,PImage> spritesHm = new HashMap<String,PImage>(); // sprites hashmap
PImage[] tiles;
SpriteSheet ss;

void setup(){

  String spritePath = sketchPath().substring(0, sketchPath().length()-4) + "images";
  File sprites = new File(spritePath);
  
  String[] spriteList = sprites.list();
  PImage spritesPM; //sprites PImage
  
  for(int i = 0; i < spriteList.length; i++){
    spritesPM = loadImage(spritePath + "/" + spriteList[i]);
    spritesHm.put(spriteList[i].substring(0, spriteList[i].length()-4), spritesPM);
  }
  
  //map
  Map map = new Map();
  map.generateBaseMap();

  
  String tilesPath = spritePath.substring(0, spritePath.length()-6) + "Tiles";
  File tilesFile = new File(tilesPath);
  
  String[] tilesList = tilesFile.list();
  tiles = new PImage[tilesList.length]; //tiles PImage
  
  for(int i = 0; i < tilesList.length; i++){
    tiles[i] = loadImage(tilesPath + "/" + tilesList[i]);
  }
  
  size(800,800);
  
}

//implement a statemachine
//walking state - player walking around the world, draws the world
//combat state - player encounters and enemy - draws the enemy
//in the combat state we could have another state machine to denote, picking a move, animate attacks, calcualte damage, back to picking a move, etc.


void draw(){
  
  clear();
  ss = new SpriteSheet(spritesHm.get("AirA"));
  try{
    TimeUnit.SECONDS.sleep(1);
  } catch(Exception e){
    e.printStackTrace();
  } 
  //image(spritesHm.get("AirA") , 80, 80, 64, 64, 16, 0, 32, 16);
}
