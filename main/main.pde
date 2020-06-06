import java.util.*;
import java.io.File;
import java.util.concurrent.TimeUnit;

PImage[] playerSprites = new PImage[12];

int[] collidableSprites = new int[]{189,190,191,192,193,194,195,196,216,217,218,219,220,221,222,223,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,270,271,272,273,274,275,276,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,327,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,344,345,346,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,381,382,383,384,385,386,387,388,389,390,391,392,412,413,414,415,416,417,418,419,420,421,422,423,424,425,426,427,443,444,445,446,453,454,470,471,472,473,474,475,476,477,478,479,480,481};


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
