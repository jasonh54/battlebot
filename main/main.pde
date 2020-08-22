import java.util.*;
import java.io.File;
import java.util.concurrent.TimeUnit;


//all the collidable sprites on the spritesheet
int[] collidableSprites = new int[]{189,190,191,192,193,194,195,196,216,217,218,219,220,221,222,223,232,237,238,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,270,271,272,273,274,275,276,278,279,280,286,287,288,289,290,291,292,297,298,299,300,301,302,303,304,305,306,307,327,328,329,330,331,332,333,334,335,336,337,338,340,341,342,344,345,346,354,355,356,357,358,359,360,361,362,363,364,365,367,368,369,370,371,372,373,381,382,383,384,385,386,387,388,389,390,391,392,414,415,416,417,418,419,420,421,422,423,424,425,426,427,443,444,445,446,453,454,470,471,472,473,474,475,476,477,478,479,480,481};
int[] portalSprites = new int[]{281,282,283,284,285,339,412,413};

HashMap<String,PImage> spritesHm = new HashMap<String,PImage>(); // sprites hashmap
PImage[] tiles;



SpriteSheet TPlayerStand;

SpriteSheet SSAirA;
SpriteSheet SSBeardA;


Timer animationTimer;
Timer restartTimer;

Map map = new Map();
//int framecounter = 0;
//char countingkey;

Player testPlayer;

//boolean lock = false;

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
    //System.out.println(spriteList[i].substring(0, spriteList[i].length()-4));
  }
  
  String tilesPath = spritePath.substring(0, spritePath.length()-6) + "Tiles";
  File tilesFile = new File(tilesPath);
  
  String[] tilesList = tilesFile.list();
  tiles = new PImage[tilesList.length]; //tiles PImage
  
  for(int i = 0; i < tilesList.length; i++){
    tiles[i] = loadImage(tilesPath + "/" + tilesList[i]);
  }
  
  testPlayer = new Player(createCharacterSprites(0));

  //map and maptile array
  int[][] tileArr = {
    {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2}, 
    {27, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 29}, 
    {27, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 29}, 
    {27, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 29}, 
    {27, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 29}, 
    {27, 28, 28, 281, 28, 28, 28, 28, 28, 28, 283, 28, 28, 28, 28, 29}, 
    {27, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 29}, 
    {27, 28, 28, 28, 28, 28, 28, 232, 28, 28, 28, 28, 28, 28, 28, 29}, 
    {27, 28, 28, 28, 28, 28, 28, 259, 28, 28, 28, 28, 28, 28, 28, 29}, 
    {27, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 29}, 
    {27, 28, 28, 28, 28, 412, 413, 28, 28, 28, 28, 28, 28, 28, 28, 29}, 
    {27, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 29}, 
    {54, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 56}
  };
  
  map.generateBaseMap(tileArr);
  print(testPlayer.x + " " + testPlayer.y);
  
  TPlayerStand = new SpriteSheet(Arrays.copyOfRange(tiles, 23, 27));

  
  animationTimer = new Timer(500);
  restartTimer = new Timer(5000);
  
  SSAirA = new SpriteSheet(spritesHm.get("AirA"));
  SSBeardA = new SpriteSheet(spritesHm.get("BeardA"));
  
    size(1100,800);
    
  
}

void draw(){
  background(0);
  map.update();
  testPlayer.display();
  
  if (currentState == GameStates.WALKING) {
    


  } else if (currentState == GameStates.COMBAT) {
    //drawing monsters, moves, battlefield, etc
  } else if (currentState == GameStates.MENU) {
    //drawing buttons/options
  }
  


  ///* -- test display code -- remove in the future 
  //if(animationTimer.countDownUntil(SSAirA.stoploop)){
  //    SSAirA.changeDisplay(true,-1,9);   
  //}
  
  //SSAirA.display(80,80);
  
  //if(restartTimer.countDownOnce()){
  //  SSAirA.restart();
  //  System.out.println("restarted");
  //}
  
  
  
  
  //*/
  
  testPlayer.display();
  
}



public void generateTileMapGuide(){
  int i = 0;
  for(int row = 0; row < 18; row++){
    for(int col=0;col<27; col++){
      image(tiles[i], col * 32 + col + 100, row * 32 + row+100, 32,32);
      
      textSize(16);
      text(i,col * 32+col+100, row * 32 + 20+row+100);
      i++;
    }
  }
}
