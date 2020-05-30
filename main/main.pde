import java.util.*;
import java.io.File;
import java.util.concurrent.TimeUnit;

PImage[] playerSprites = new PImage[12];


HashMap<String,PImage> spritesHm = new HashMap<String,PImage>(); // sprites hashmap
PImage[] tiles;

SpriteSheet SSAirA;

SpriteSheetArr PlayerStand;


Timer animationTimer;
Map map = new Map();

enum GameStates{
  WALKING,
  COMBAT,
  MENU
}
GameStates currentState = GameStates.WALKING;



void setup(){
  
  //Ethan's code
  //acquire the folder location of where the monster images are
  String spritePath = sketchPath().substring(0, sketchPath().length()-4) + "images";
  File sprites = new File(spritePath);
  //opens up the folder that contains the monster images
  //creates a list of file names from the folder of monster images
  String[] spriteList = sprites.list();
  //temporary variable that holds the image that is loaded from the monster file
  PImage spritesPM; //sprites PImage
  
  for(int i = 0; i < spriteList.length; i++){
    //after loading each image from the monster folder place it into a hashmap containing name of monster and image
    spritesPM = loadImage(spritePath + "/" + spriteList[i]);
    spritesHm.put(spriteList[i].substring(0, spriteList[i].length()-4), spritesPM);
  }
  
  String tilesPath = spritePath.substring(0, spritePath.length()-6) + "Tiles";
  File tilesFile = new File(tilesPath);
  
  String[] tilesList = tilesFile.list();
  tiles = new PImage[tilesList.length]; //tiles PImage
  
  for(int i = 0; i < tilesList.length; i++){
    tiles[i] = loadImage(tilesPath + "/" + tilesList[i]);
  }
  
  

  //map and maptile array
  int[][] tileArr = {{0, 1, 1, 1, 1, 1, 2}, {27, 28, 28, 28, 28, 28, 29}, {54, 55, 55, 55, 55, 55, 56}};
  map.generateBaseMap(tileArr);
  


  
  animationTimer = new Timer(100);
  
  SSAirA = new SpriteSheet(spritesHm.get("AirA"));
  

  PlayerStand = new SpriteSheetArr(Arrays.copyOfRange(tiles, 23, 26));
  
    size(800,800);
}

//implement a statemachine
//walking state - player walking around the world, draws the world
//combat state - player encounters and enemy - draws the enemy
//in the combat state we could have another state machine to denote, picking a move, animate attacks, calcualte damage, back to picking a move, etc.

void draw(){


  if (currentState == GameStates.WALKING) {
    map.draw();
  } else if (currentState == GameStates.COMBAT) {
    //drawing monsters, moves, battlefield, etc
  } else if (currentState == GameStates.MENU) {
    //drawing buttons/options
  }

 
}
