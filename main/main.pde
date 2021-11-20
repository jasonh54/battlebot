//imports
import java.util.*;
import java.io.File;
import java.util.concurrent.TimeUnit;

//hashmaps for each json file
HashMap<String, JSONObject> monsterDatabase = new HashMap<String, JSONObject>();
HashMap<String, JSONObject> movesDatabase = new HashMap<String, JSONObject>();
HashMap<String, JSONObject> itemDatabase = new HashMap<String, JSONObject>();

//tile arrays for all "special" tiles
int[] collidableSprites = new int[]{170,171,172,189,190,191,192,193,194,195,196,197,198,199,216,217,218,219,220,221,222,223,224,225,226,237,238,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,270,271,272,273,274,275,276,278,279,280,286,287,288,289,290,291,292,297,298,299,300,301,302,303,304,305,306,307,327,328,329,330,331,332,333,334,335,336,337,338,340,341,342,344,345,346,354,355,356,357,358,359,360,361,362,363,364,365,367,368,369,370,371,372,373,381,382,383,384,385,386,387,388,389,390,391,392,414,415,416,417,418,419,420,421,422,423,424,425,426,427,443,444,445,446,453,454,470,471,472,473,474,475,476,477,478,479,480,481};
int[] portalSprites = new int[]{281,282,283,284,285,339,412,413};
int[] grassSprites = new int[]{0,1,2,3,4,5,6,7,27,28,29,30,31,32,33,34,54,55,56,57,58,59,60,61};
//sprite stuff
HashMap<String,PImage> spritesHm = new HashMap<String,PImage>(); // sprites hashmap
PImage[] tiles;

//map variables
OverlayMap collidemap = new OverlayMap();
Map map = new Map();
Map overlayedmap = new Map();
Map topmap = new Map();

//item stuff
ArrayList<GroundItem> items = new ArrayList<GroundItem>();
HashMap<String,PImage> itemsprites = new HashMap<String,PImage>();

//menu variables
Menu mainmenu;
Menu battlemenu;

Menu movemenu;
Menu botmenu;
Menu itemmenu;


// todo: fix addhp

//misc variables

Button sandwich;


//misc variables
static Player testPlayer; //the player
static Monster activeMonster; //player's current monster
static Monster testMonster; //current enemy monster
final int naptime = 200; //delayer var to avoid problems when keys are pressed

Timer restartTimer;
static int moveNum = 0;
static int aimovenum = 0;

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
  //after loading each image from the monster folder place it into a hashmap containing name of monster and image
  for(int i = 0; i < spriteList.length; i++){
    spritesPM = loadImage(spritePath + "/" + spriteList[i]);
    spritesHm.put(spriteList[i].substring(0, spriteList[i].length()-4), spritesPM);
  }
  
  String itemPath = spritePath.substring(0, spritePath.length()-6) + "items";
  String tilesPath = spritePath.substring(0, spritePath.length()-6) + "Tiles";
  File tilesFile = new File(tilesPath);
  
  String[] tilesList = tilesFile.list();
  tiles = new PImage[tilesList.length]; //tiles PImage
  
  //sort TilesPath
  String temp;
  int nums1;
  int nums2;
  for (int i = 0; i < tilesList.length; i++) {
    for (int k = 1; k < (tilesList.length - i); k++) {
      nums1 = Integer.parseInt(tilesList[k-1].substring(5, 9));
      nums2 = Integer.parseInt(tilesList[k].substring(5, 9));
      if (nums1 > nums2) {
        temp = tilesList[k-1];
        tilesList[k-1] = tilesList[k];
        tilesList[k] = temp;
      }
    }
  }
  
  for(int i = 0; i < tilesList.length; i++){
    tiles[i] = loadImage(tilesPath + "/" + tilesList[i]);
  }
  
  //load the moves.json file
  JSONArray moveArray = loadJSONArray("moves.json");
  for(int i=0; i<moveArray.size();i++){
    JSONObject move = moveArray.getJSONObject(i);
    movesDatabase.put(move.getString("name"),move);
  }
  //load the monsters.json file
  JSONArray monsterArray = loadJSONArray("monsters.json");
  for(int i=0; i<monsterArray.size();i++){
    JSONObject monster = monsterArray.getJSONObject(i);
    monsterDatabase.put(monster.getString("name"),monster);
  }
  //load the items.json file
  JSONArray itemArray = loadJSONArray("items.json");
  for (int i=0; i<itemArray.size();i++){
    JSONObject item = itemArray.getJSONObject(i);
    itemDatabase.put(item.getString("name"),item);
  }

  itemsprites.put("Health Potion",loadImage(itemPath+"/"+"PotionHealth.png"));
  itemsprites.put("Damage Potion",loadImage(itemPath+"/"+"PotionDamage.png"));
  itemsprites.put("Armor Potion" ,loadImage(itemPath+"/"+"PotionArmor.png"));
  itemsprites.put("Speed Potion" ,loadImage(itemPath+"/"+"PotionSpeed.png"));
  itemsprites.put("Agility Potion",loadImage(itemPath+"/"+"PotionAgility.png"));

  
  //initiatize misc variables
  Monster enemy = new Monster("ZombieA", 800, 300);
  testPlayer = new Player(createCharacterSprites(0));
  String[] monsterids = new String[]{"AirA", "MaskA", "ChickenA", "KlackonA"};
  testPlayer.summonMonsterStack(monsterids);
  testPlayer.addItem("Health Potion");

  //initialize all menus
  mainmenu = new Menu(0, 0, 4, 30, 80, 5);
  battlemenu = new Menu(625, 520, 5, 50, 400, 2);
  movemenu = new Menu(625, 520, 4, 50, 400, 2);
  botmenu = new Menu(625, 520, testPlayer.monsters.size(), 50, 400, 2);
  itemmenu = new Menu(625, 520, 5, 50, 200, 2);
  sandwich = new Button(10, 10, "toggle");
  
  //values for main menu
  mainmenu.buttons.get(0).txt = "button1";
  mainmenu.buttons.get(1).txt = "button2";
  mainmenu.buttons.get(2).txt = "button3";
  
  //values for battle menu
  itemmenu.assembleMenuColumn();
  battlemenu.buttons.get(0).txt = "move";
  battlemenu.buttons.get(1).txt = "item";
  battlemenu.buttons.get(2).txt = "battlebots";
  battlemenu.buttons.get(3).txt = "run";
  
  //the following code is redundant w/ code below it - test to figure out which group works
  /*for (int i = 0; i < battlemenu.menulength; i++) {
    battlemenu.buttons.get(i).func = battlemenu.buttons.get(i).txt;
  }*/
  
  battlemenu.assembleMenuColumn();
  battlemenu.buttons.get(0).func = "fight";
  battlemenu.buttons.get(1).func = "item";
  battlemenu.buttons.get(2).func = "bot";
  battlemenu.buttons.get(3).func = "run";
  
  //values for botmenu
  botmenu.assembleMenuColumn();
  for (int i = 0; i < botmenu.menulength; i++) {
    botmenu.buttons.get(i).txt = testPlayer.monsters.get(i).id;
    botmenu.buttons.get(i).func = "botswap";
  }
  
  //values for move menu - no txt as it is custom to the current battle
  movemenu.assembleMenuColumn();
  movemenu.buttons.get(0).func = "callmove0";
  movemenu.buttons.get(1).func = "callmove1";
  movemenu.buttons.get(2).func = "callmove2";
  movemenu.buttons.get(3).func = "callmove3";

  
  
  //assign tiles to map layers
  //lowest layer - ground tiles with no blankspace
  int[][] baseMapTiles = {
    {89,  90,  90,  90,  90,  90,  90,  90,  90,  90,  91,  461,  441,  463,  89,  90,  90,  90,  90,  90,  90,  90,  90,  90,  91},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {143,  144,  144,  144,  144,  144,  144,  144,  144,  144,  145,  461,  441,  463,  143,  144,  144,  144,  144,  144,  144,  144,  144,  144,  145},
    {406,  406,  406,  406,  406,  406,  406,  406,  406,  406,  406,  467,  441,  466,  406,  406,  406,  406,  406,  406,  406,  406,  406,  406,  406},
    {441,  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,  441},
    {460,  460,  460,  460,  460,  460,  460,  460,  460,  460,  460,  440,  441,  439,  460,  460,  460,  460,  460,  460,  460,  460,  460,  460,  460},
    {89,  90,  90,  90,  90,  90,  90,  90,  90,  90,  91,  461,  441,  463,  89,  90,  90,  90,  90,  90,  90,  90,  90,  90,  91},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {143,  144,  144,  144,  144,  144,  144,  144,  144,  144,  145,  461,  441,  463,  143,  144,  144,  144,  144,  144,  144,  144,  144,  144,  145}
  };
  
  //2nd lowest - for ground tiles with blankspace
  int[][] overlayedMapTiles = {
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  0,  1,  1,  1,  1,  1,  1,  58,  58,  58,  4},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  27,  28,  28,  28,  28,  28,  29,  28,  28,  28,  34},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  27,  28,  28,  28,  28,  28,  29,  28,  28,  28,  34},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  27,  28,  28,  28,  28,  28,  29,  28,  28,  28,  34},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  27,  28,  28,  28,  28,  28,  32,  1,  1,  1,  29},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  27,  28,  28,  28,  28,  28,  28,  28,  28,  28,  29},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  27,  28,  28,  28,  28,  28,  28,  28,  28,  28,  29},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  27,  28,  28,  28,  28,  28,  28,  28,  28,  28,  29},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  54,  55,  55,  55,  55,  55,  55,  55,  55,  55,  56},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  89,  90,  90,  90,  90,  90,  90,  90,  90,  90,  91},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486}
  };
  
  //for collidables - cars, trees, etc
  int[][] collidableMapTiles = {
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  198,  198,  198,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  198,  198,  198,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  198,  198,  198,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  192,  486,  486,  486,  486,  486,  486,  486,  259,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  192,  486,  422,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  192,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486}
  };
  
  //top layer - stuff the player can walk under such as lampposts
  int[][] topMapTiles = {
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  165,  486,  486,  486,  486,  486,  486,  486,  232,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  165,  486,  395,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  165,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486} 
  };
  
  //draw map layers
  map.generateBaseMap(baseMapTiles);
  overlayedmap.generateBaseMap(overlayedMapTiles);
  collidemap.generateBaseMap(collidableMapTiles);
  topmap.generateBaseMap(topMapTiles);

  items.add(new GroundItem("Damage Potion",map.getTile(10,10))); // This is where you place items!
  items.add(new GroundItem("Damage Potion",map.getTile(11,10))); // This is where you place items!
  items.add(new GroundItem("Agility Potion",map.getTile(20,10)));

  //misc stuff??
  //restartTimer = new Timer(5000);
  
  //size of game window:
  fullScreen();
}

ArrayList<Integer> dqueue = new ArrayList<Integer>();

void draw() {
  background(0);
  //if in the walking state:
  if (GameState.currentState == GameStates.WALKING) {
    //update stuff - in order of layers, lowest first
    map.update();
    overlayedmap.update();
    collidemap.update();
    testPlayer.display();
    topmap.update();
    sandwich.drawSandwich();
    for (GroundItem item : items){
      item.display();
      Integer col = item.colCheck(testPlayer);
      if (col >= 0) dqueue.add(col);

    }
    for (Integer ind : dqueue){
      items.remove(items.get(ind));
    }

    dqueue = new ArrayList<Integer>();
 
    //check if menu is opened
    checkMouse(sandwich);
    //keypress to go into menu - backup if button breaks
    if (keyPressed == true && key == 'm') {
      ButtonFunction.switchState(GameStates.MENU);
      delay(naptime);
    }
  //if in the combat state:
  } else if (GameState.currentState == GameStates.COMBAT) {
    switch(GameState.combatState){
      //battle rhythm: options (choice of action) -> subaction (eg. the specific move or item chosen) -> perform action -> enemy turn -> back to options
      case ENTRY:
      //this happens once at the beginning of every battle, to set the scene
        activeMonster = testPlayer.monsters.get(0);
        //draw monsters, menu, background, HP
        ButtonFunction.switchCombatState(CombatStates.OPTIONS);
        testMonster = new Monster("AirA", 800, 250);
      break;
      case OPTIONS:
        testMonster.display();
        activeMonster.display();
        //this happens once at the beginning of every turn; the part where you select what you want to do
        //draw same as Entry State
        battlemenu.update();
        checkMouse(battlemenu);
      break;
      case FIGHT:
        testMonster.display();
        activeMonster.display();
        //txt defined here at it is custom to the current battle
        //will produce a menu of what moves the battle bot can use
        Menu movemenu = new Menu(625, 520, 5, 50, 400, 2);

        //nullpointer error HERE because txt is null
        
        movemenu.buttons.get(0).txt = "Return to Menu";
        movemenu.buttons.get(0).func = "return";

        for (int i = 0; i < 4; i++) {
          //give move buttons functions based on their moves
          movemenu.buttons.get(i+1).txt = activeMonster.moveset[i].name;
          movemenu.buttons.get(i+1).func = ("callmove"+String.valueOf(i)).toString();
        }
        movemenu.update();
        checkMouse(movemenu);
      break;
      case ANIMATION:
        testMonster.display();
        activeMonster.display();
        if(moveNum == 1){
          if(activeMonster.moveToEnemy(testMonster) ){
            ButtonFunction.switchCombatState(CombatStates.AI);

          } 

        } else if (moveNum == 2){
          if(activeMonster.defendAnimation()){
            ButtonFunction.switchCombatState(CombatStates.AI);
          }
        } else if(moveNum == 3){
          if(activeMonster.healAnimation()){
            ButtonFunction.switchCombatState(CombatStates.AI);
          }
        } else if(moveNum == 4){
          if(activeMonster.dodgeAnimation()){
            ButtonFunction.switchCombatState(CombatStates.AI);
          }
        } else {
          ButtonFunction.switchCombatState(CombatStates.OPTIONS);
        }
      break;
      case ITEM:
        testMonster.display();
        activeMonster.display();
        //will produce a menu of what items you have


        Menu itemmenu = new Menu(625, 520, testPlayer.items.size()+1, 50, 300, 2);
        Object[] itemsKeys = testPlayer.items.keySet().toArray();
        
        itemmenu.buttons.get(0).txt = "Return to Menu";
        itemmenu.buttons.get(0).func = "return";
        for (int i = 0; i < testPlayer.items.size(); i++) {
          String itemi = (String)itemsKeys[i];
          itemmenu.buttons.get(i+1).txt = itemi+" x "+testPlayer.items.get(itemi);
          itemmenu.buttons.get(i+1).func = "useitem";

        }
        itemmenu.update();
        checkMouse(itemmenu);
      break;
      case BATTLEBOT:
        testMonster.display();
        activeMonster.display();
        //will produce a menu of what battlebots you can switch to
        botmenu.update();
        checkMouse(botmenu);
      break;
      case AI:
        //let the enemy do stuff - will need a decision tree
        if      (testMonster.stats.getFloat("chealth") < 15 && random(0.0,1.0) <= 0.99){ // doing bad.
          testMonster.moveset[3].useMove(testMonster);
          aimovenum = 2;
          testMonster.dodgeStart();
        }else if(testMonster.stats.getFloat("chealth") < 30 && random(0.0,1.0) <= 0.88){ // doing okay
          testMonster.moveset[2].useMove(testMonster);
          aimovenum = 3;
          testMonster.healStart();
        }else if(testMonster.stats.getFloat("chealth") < 60 && random(0.0,1.0) <= 0.45){ // doing well
          testMonster.moveset[1].useMove(testMonster);
          aimovenum = 4;
          testMonster.defendStart();
        }else{                              // doing best
          aimovenum = 1;
          testMonster.moveset[0].useMove(activeMonster);
          testMonster.moveToEnemyStart(activeMonster);
        }
        ButtonFunction.switchCombatState(CombatStates.AIANIMATION);
      break;
      case AIANIMATION:
        testMonster.display();
        activeMonster.display();

        switch (aimovenum){
          case 1:
            if (testMonster.moveToEnemy(activeMonster)) ButtonFunction.switchCombatState(CombatStates.OPTIONS);
          break;
          case 2:
            if(testMonster.dodgeAnimation()) ButtonFunction.switchCombatState(CombatStates.OPTIONS);
          break;
          case 3:
            if(testMonster.healAnimation()) ButtonFunction.switchCombatState(CombatStates.OPTIONS);
          break;
          case 4:
            if(testMonster.defendAnimation()) ButtonFunction.switchCombatState(CombatStates.OPTIONS);
          break;
        }

      break;
      case RUN:
        //will go back to walk state
        GameState.currentState = GameStates.WALKING;
      break;
    }
  //if in the menu state:
  } else if (GameState.currentState == GameStates.MENU) {
    //draw stuff (not update; no movement)
    map.draw();
    overlayedmap.draw();
    collidemap.draw();
    testPlayer.display();
    topmap.draw();
    sandwich.drawSandwich();
    //updating the menu
    mainmenu.update();
    //for button clicks
    checkMouse(mainmenu);
    checkMouse(sandwich);
    //keypress to go into walking - backup if button breaks
    if (keyPressed == true && key == 'm') {
      ButtonFunction.switchState(GameStates.WALKING);
      delay(naptime);
    }
  }
  
  ///* -- test display code -- remove in the future 
  /*if(SSAirA.animationTimer.countDownUntil(SSAirA.stoploop)){
      
      SSAirA.changeSaE(3,5);
      System.out.println("loopstart: " + SSAirA.loopstart + ", loopend: " + SSAirA.loopend);
      SSAirA.changeDisplay(true);   
      //SSAirA.changeDisplay();
  }
  
  SSAirA.display(80,80);
  
  if(SSAirA.stoploop){
    SSAirA.restart();
    System.out.println("restarted");
  }
  
  testPlayer.display(); */  

  //System.out.println(map.framecounter);
  
  //testPlayer.display();

}

//mouseClicked functions for menus and singular buttons each
void checkMouse(Menu menu) {
  //check if mouse is clicked; mouseClicked func is weird so we're doing this instead
  if (mousePressed) {
    //iterate through every button in the menu
    for (int i = 0; i < menu.buttons.size(); i++) {
      Button current = menu.buttons.get(i);
      //if mouse is touching  a button
      if (mouseX >= current.x && mouseX <= current.x + current.w) {
        if (mouseY >= current.y && mouseY <= current.y + current.h) {
          //next line is only used when the botswap function is called
          //although it is set with every buttonclick
          testPlayer.swapto = current.txt;
          current.onClick();
          delay(naptime);
        }
      }
    }
  }
}

void checkMouse(Button current) {
  //check if mouse is clicked; mouseClicked func is weird so we're doing this instead
  if (mousePressed) {
    if (mouseX >= current.x && mouseX <= current.x + current.w) {
      if (mouseY >= current.y && mouseY <= current.y + (5 * current.h)) {
        current.onClick();
        delay(naptime);
      }
    }
  }
}

//draw the tile guide(not ever used - delete?)
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

public JSONObject JSONCopy(JSONObject original){
  JSONObject duplicate = new JSONObject();
  String[] keys = new String[original.keys().size()];
  Object[] temp = original.keys().toArray();
  for(int i=0; i<keys.length; i++){
    keys[i] = temp[i].toString();
  }
  
  for(String keyi : keys){
    if(original.get(keyi) instanceof Boolean){
      duplicate.setBoolean(keyi, original.getBoolean(keyi));
    }else if(original.get(keyi) instanceof String){
      duplicate.setString(keyi, original.getString(keyi));
    }else if(original.get(keyi) instanceof Integer){
      duplicate.setInt(keyi, original.getInt(keyi));
    }else if(original.get(keyi) instanceof Float){
      duplicate.setFloat(keyi, original.getFloat(keyi));
    }else if(original.get(keyi) instanceof Double){
      duplicate.setDouble(keyi, original.getDouble(keyi));
    }else if(original.get(keyi) instanceof JSONObject){
      duplicate.setJSONObject(keyi, original.getJSONObject(keyi));
    }else if(original.get(keyi) instanceof JSONArray){
      duplicate.setJSONArray(keyi, original.getJSONArray(keyi));
    }else{
      System.out.printf("[JSONCopy] Warning! Did not copy key '%s' because it did not match type! Class: "+original.get(keyi).getClass(),keyi);
      System.out.println(original.get(keyi));
    }
  }
  return duplicate;
}

//public void setValue(JSONObject duplicate, String k, String value){
//  duplicate.setString(k,value);
//}
//public void setValue(JSONObject duplicate, String k, int value){
//  duplicate.setInt(k,value);
//}
//public void setValue(JSONObject duplicate, String k, float value){
//  duplicate.setFloat(k,value);
//}
//public void setValue(JSONObject duplicate, String k, boolean value){
//  duplicate.setBoolean(k,value);
//}
//public void setValue(JSONObject duplicate, String k, JSONObject value){
//  duplicate.setJSONObject(k,value);
//}
//public void setValue(JSONObject duplicate, String k, JSONArray value){
//  duplicate.setJSONArray(k,value);
//}
