import java.util.*;
import java.io.File;
import java.util.concurrent.TimeUnit;

//hashmap of monster information
HashMap<String, JSONObject> monsterDatabase = new HashMap<String, JSONObject>();
HashMap<String, JSONObject> movesDatabase = new HashMap<String, JSONObject>();
HashMap<String, JSONObject> itemDatabase = new HashMap<String, JSONObject>();
//tile arrays
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

//boolean lock = false;

//menu variables
Menu mainmenu;
Menu battlemenu;

//misc variables
Button sandwich;


static Player testPlayer;

static Monster activeMonster;

static Monster testMonster;

Timer restartTimer;
final int naptime = 200;

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
    //println(tilesList[i]);
    tiles[i] = loadImage(tilesPath + "/" + tilesList[i]);
  }

  //JSONObject proto = new JSONObject();
  //proto.setString("type","fire");
  //proto.setFloat("attack",50);
  //proto.setFloat("defense",50);
  //proto.setFloat("maxhealth",50);
  //proto.setFloat("speed",50);
  //proto.setString("image",spriteList[0].substring(0, spriteList[0].length()-4));
  ////hashID of the test monster is "prototype"
  //monsterDatabase.put("prototype", proto);

  
  JSONArray moveArray = loadJSONArray("moves.json");
  for(int i=0; i<moveArray.size();i++){
    JSONObject move = moveArray.getJSONObject(i);
    movesDatabase.put(move.getString("name"),move);
  }
  JSONArray monsterArray = loadJSONArray("monsters.json");
  for(int i=0; i<monsterArray.size();i++){
    JSONObject monster = monsterArray.getJSONObject(i);
    monsterDatabase.put(monster.getString("name"),monster);
  }
  JSONArray itemArray = loadJSONArray("items.json");
  for (int i=0; i<itemArray.size();i++){
    JSONObject item = itemArray.getJSONObject(i);
    itemDatabase.put(item.getString("name"),item);
  }
  //initiatize misc variables
  Monster enemy = new Monster("ZombieA", activeMonster, 800, 300);
  testPlayer = new Player(createCharacterSprites(0));


  testPlayer.addMonsters("AirA", "BallA", "BallB", "BallC", "BallD", enemy);

  testPlayer.addItem("Health Potion");


  mainmenu = new Menu(0, 0, 4, 30, 80, 5);
  battlemenu = new Menu(625, 520, 5, 50, 400, 2);
  sandwich = new Button(10, 10, "toggle");
  
  //values for main menu
  mainmenu.assembleMenuColumn();
  mainmenu.buttons.get(0).txt = "button1";
  mainmenu.buttons.get(1).txt = "button2";
  mainmenu.buttons.get(2).txt = "button3";
  
  //values for battle menu
  battlemenu.assembleMenuColumn();
  battlemenu.buttons.get(0).txt = "fight";
  battlemenu.buttons.get(1).txt = "items";
  battlemenu.buttons.get(2).txt = "battlebots";
  battlemenu.buttons.get(3).txt = "run";
  battlemenu.buttons.get(0).func = "fight";
  battlemenu.buttons.get(1).func = "item";
  battlemenu.buttons.get(2).func = "bot";
  battlemenu.buttons.get(3).func = "run";
  
  //assign tiles to map layers
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
  
  //misc stuff??
  //restartTimer = new Timer(5000);
  
  //size of game window:
  size(1100,800);
}

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
        println("the battle has begun!");
        ButtonFunction.switchCombatState(CombatStates.OPTIONS);
        testMonster = new Monster("AirA", activeMonster, 800, 250);
        activeMonster.setEnemy(testMonster);
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
        //will produce a menu of what moves the battle bot can use
        Menu movemenu = new Menu(625, 520, 5, 50, 400, 2);
        movemenu.assembleMenuColumn();
        //nullpointer error HERE because txt is null
        for (int i = 0; i < 4; i++) {
          //give move buttons functions based on their moves
          movemenu.buttons.get(i).txt = activeMonster.moveset[i].name;
        }
        movemenu.buttons.get(0).func = "callmove0";
        movemenu.buttons.get(1).func = "callmove1";
        movemenu.buttons.get(2).func = "callmove2";
        movemenu.buttons.get(3).func = "callmove3";
        movemenu.update();
        checkMouse(movemenu);
      break;
      case ANIMATION:
        testMonster.display();
        activeMonster.display();
        if(activeMonster.moveToEnemy(testMonster)){
          ButtonFunction.switchCombatState(CombatStates.OPTIONS);
        }
      break;
      case ITEM:
        testMonster.display();
        activeMonster.display();
        //will produce a menu of what items you have
        Menu itemmenu = new Menu(625, 520, 5, 50, 200, 2);
        itemmenu.assembleMenuColumn();
        itemmenu.x = itemmenu.x - 100;
        itemmenu.assembleMenuColumn();
        String[] itemsKeys = testPlayer.items.keySet().toArray(new String[testPlayer.items.keySet().size()]);
        for (int i = 0; i < 8; i++) {
          Button button = itemmenu.buttons.get(i);
          button.txt = itemsKeys[i];
          button.func = "useitem";
          /* set each button's function
          need function for using an ability
          items should have inherent functions like buttons do */
        }
        itemmenu.update();
        checkMouse(itemmenu);
      break;
      case BATTLEBOT:
        //will produce a menu of what battlebots you can switch to
      break;
      case AI:
        //let the enemy do stuff - will need a decision tree
      break;
      case RUN:
        //will go back to walk state
        GameState.currentState = GameStates.WALKING;
      break;
    }
  //if in the menu state:
  } else if (GameState.currentState == GameStates.MENU) {
    println("menu");
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
          println("menuclick");
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
