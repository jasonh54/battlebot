import java.util.*;
import java.io.File;
import java.util.concurrent.TimeUnit;



int[] collidableSprites = new int[]{189,190,191,192,193,194,195,196,216,217,218,219,220,221,222,223,237,238,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,270,271,272,273,274,275,276,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,327,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,344,345,346,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,381,382,383,384,385,386,387,388,389,390,391,392,412,413,414,415,416,417,418,419,420,421,422,423,424,425,426,427,443,444,445,446,453,454,470,471,472,473,474,475,476,477,478,479,480,481};


HashMap<String,PImage> spritesHm = new HashMap<String,PImage>(); // sprites hashmap
PImage[] tiles;

SpriteSheet TPlayerStand;

SpriteSheet SSAirA;


Timer animationTimer;
Map map = new Map();
int framecounter = 0;
char countingkey;

Player testPlayer;

boolean lock = false;

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
    {27, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 29}, 
    {27, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 29}, 
    {27, 28, 28, 28, 28, 28, 28, 232, 28, 28, 28, 28, 28, 28, 28, 29}, 
    {27, 28, 28, 28, 28, 28, 28, 259, 28, 28, 28, 28, 28, 28, 28, 29}, 
    {27, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 29}, 
    {27, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 29}, 
    {27, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 29}, 
    {54, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 56}
  };
  map.generateBaseMap(tileArr);
  


  
  animationTimer = new Timer(500);
  
  //TPlayerStand = new SpriteSheet(Arrays.copyOfRange(tiles, 23, 27));
  
  SSAirA = new SpriteSheet(spritesHm.get("AirA"));
  
    size(1100,800);
    
  
}

//implement a statemachine
//walking state - player walking around the world, draws the world
//combat state - player encounters and enemy - draws the enemy
//in the combat state we could have another state machine to denote, picking a move, animate attacks, calcualte damage, back to picking a move, etc.

void draw(){
  background(0);
  map.draw();
  
  
  if (currentState == GameStates.WALKING) {
    //if key is pressed
    if (keyPressed == true) {
      //if it's a movement key
      if ( (key == 'w'|| key == 's' || key == 'a' || key == 'd') && lock == false) {
        //if a new movement needs to start
        lock = true;
        
        map.newMove(key);
        println("new move: " + framecounter);
        
      }
    }
    
    if(lock==true){
      framecounter++;
      if (map.getCurrentKey() == 'w') {
        map.moveUp();
      } else if (map.getCurrentKey() == 's') {
        map.moveDown();
      } else if (map.getCurrentKey() == 'a') {
        map.moveLeft();
      } else if (map.getCurrentKey() == 'd') {
        map.moveRight();
      }
      if(framecounter == 8){
        lock = false;
        framecounter = 0;
        map.stopMove();
      }
    }
    
    ////if in the middle of a movement
    //if (framecounter < 16 && framecounter != 0) {
    //  println("is anything happening: " + framecounter);
    //  //move up
    //  if (countingkey == 'w') {
    //    map.moveUp();
    //  //down
    //  } else if (countingkey == 's') {
    //    map.moveDown();
    //  //left
    //  } else if (countingkey == 'a') {
    //    map.moveLeft();
    //  //right
    //  } else if (countingkey == 'd') {
    //    map.moveRight();
    //  }
    //} else if (framecounter > 16) {
    //  println("stop moving");
    //  map.stopMove();
    //  lock = false;
    //}

  } else if (currentState == GameStates.COMBAT) {
    //drawing monsters, moves, battlefield, etc
  } else if (currentState == GameStates.MENU) {
    //drawing buttons/options
  }
  

  /* -- test display code -- remove in the future
  if(animationTimer.countDownUntil(TPlayerStand.stoploop)){
    
  } 
  
  SSAirA.display();
  if(animationTimer.countDown()){
    SSAirA.changeDisplay(80,80,0);
    //TPlayerStand.changeDisplay(80,80);
  }
  
  //TPlayerStand.display();
  */
  
  
  
  
  

  
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
