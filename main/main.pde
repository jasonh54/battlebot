//imports
import java.util.*;
import java.io.File;
import java.util.concurrent.TimeUnit;

// never gonna give you up, never gonna let you down, never gonna run around and desert you

//tile arrays for all "special" tiles
int[] collidableSprites = new int[]{170,171,172,189,190,191,192,193,194,195,196,197,198,199,216,217,218,219,220,221,222,223,224,225,226,237,238,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,270,271,272,273,274,275,276,278,279,280,286,287,288,289,290,291,292,297,298,299,300,301,302,303,304,305,306,307,327,328,329,330,331,332,333,334,335,336,337,338,340,341,342,344,345,346,354,355,356,357,358,359,360,361,362,363,364,365,367,368,369,370,371,372,373,381,382,383,384,385,386,387,388,389,390,391,392,414,415,416,417,418,419,420,421,422,423,424,425,426,427,443,444,445,446,453,454,470,471,472,473,474,475,476,477,478,479,480,481};
int[] portalSprites = new int[]{281,282,283,284,285,339,412,413};
int[] grassSprites = new int[]{0,1,2,3,4,5,6,7,27,28,29,30,31,32,33,34,54,55,56,57,58,59,60,61};

//hashmaps for each json file
HashMap<String, JSONObject> monsterDatabase = new HashMap<String, JSONObject>();
HashMap<String, JSONObject> movesDatabase = new HashMap<String, JSONObject>();
HashMap<String, JSONObject> itemDatabase = new HashMap<String, JSONObject>();
HashMap<String, JSONObject> mapsDatabase = new HashMap<String, JSONObject>();

//sprite stuff
HashMap<String,PImage> spritesHm = new HashMap<String,PImage>(); // sprites hashmap
PImage[] tiles;

//item stuff
ArrayList<GroundItem> dqueue = new ArrayList<GroundItem>();
HashMap<String,PImage> itemsprites = new HashMap<String,PImage>();

//list of all maps
HashMap<String,Maps> masterMapList = new HashMap<String,Maps>();

//menu variables
Menu mainmenu;

//misc variables
Button sandwich;

static Battle currentbattle;

//layers/map stuff
Maps currentmap = new Maps();
//One existing map which is manipulated/used by the code, currentmap
//Many other defined maps w/ specific layers which exist solely in a JSON file
//When map is changed in the overworld, set currentmap equal to one of the other preexisting maps itself - all layers and other data will carry over
//'citymap' being used as a test version of a theoretical JSON map
Maps citymap;
Maps fieldmap;
Maps jailmap;


//misc variables
static Player testPlayer; //the player
final int naptime = 200; //delayer var to avoid problems when keys are pressed

Timer restartTimer;

Monster generateNewMonster(String id) {
  Monster m = new Monster(id, 400, 400);
  return m;
}

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
  //load the maps.json file
  JSONArray mapArray = loadJSONArray("maps.json");
  for(int i = 0; i < mapArray.size(); i++) {
    JSONObject map = mapArray.getJSONObject(i);
    mapsDatabase.put(map.getString("name"),map);
    //confirm that map is being loaded in
    println("loading in: " + map.getString("name"));
  }

  itemsprites.put("Health Potion",loadImage(itemPath+"/"+"PotionHealth.png"));
  itemsprites.put("Damage Potion",loadImage(itemPath+"/"+"PotionDamage.png"));
  itemsprites.put("Armor Potion" ,loadImage(itemPath+"/"+"PotionArmor.png"));
  itemsprites.put("Speed Potion" ,loadImage(itemPath+"/"+"PotionSpeed.png"));
  itemsprites.put("Agility Potion",loadImage(itemPath+"/"+"PotionAgility.png"));
  
  //initiatize misc variables

  testPlayer = new Player(createCharacterSprites(0),new ArrayList());

  String[] monsterids = new String[]{"AirA", "Goku", "ChickenA", "KlackonA"};
  testPlayer.summonMonsterStack(monsterids);
  testPlayer.addItem("Health Potion");

  //initialize the maps
  citymap = new Maps("citymap");
  fieldmap = new Maps("fieldmap");
  jailmap = new Maps("jailmap");
  
  //set up portal connections
  citymap.pairPortals();
  fieldmap.pairPortals();
  jailmap.pairPortals();

  //sets the active map as city to start
  currentmap = fieldmap;
  
  //initialize all menus
  mainmenu = new Menu(0, 0, 4, 30, 80, 5);

  sandwich = new Button(10, 10, "toggle");
  //values for main menu
  mainmenu = new Menu(0, 0, 4, 30, 80, 5);
  mainmenu.buttons.get(0).txt = "button1";
  mainmenu.buttons.get(1).txt = "button2";
  mainmenu.buttons.get(2).txt = "button3";
  

  currentmap.addItem(new GroundItem("Damage Potion",currentmap.baselayer.getTile(1,1))); // This is where you place items!
  currentmap.addItem(new GroundItem("Agility Potion",currentmap.baselayer.getTile(2,1)));

  /*items.add(new GroundItem("Damage Potion",currentmap.baselayer.getTile(10,10))); // This is where you place items!
  items.add(new GroundItem("Agility Potion",currentmap.baselayer.getTile(20,10)));*/

  //size of game window:
  fullScreen();
}


void draw() {
  background(0);
  //if in the walking state:
  switch (GameState.currentState) {
    case WALKING:
      if (currentmap.nextmap != null) {
        currentmap = currentmap.nextmap;
      }
      currentmap.update();
      testPlayer.display();
      currentmap.updateLast();
      updateDrawables(sandwich);
      updateClickables(sandwich);
      
      for (GroundItem gi : dqueue) {
        currentmap.removeItem(gi);
      }
      //keypress to go into menu - backup if button breaks
      if (keyPressed == true && key == 'm') {
        GameState.switchState(GameStates.MENU);
        delay(naptime);
      }
    break;
    case COMBAT:
      currentbattle.turn();
    break;
    case MENU:
      //draw stuff (not update; no movement)
      currentmap.totalDraw();
      //updating the menu
      updateDrawables(sandwich);
      updateClickables(sandwich);
      updateDrawables(mainmenu);
      updateClickables(mainmenu);
      //for button clicks
      //keypress to go into walking - backup if button breaks
      if (keyPressed == true && key == 'm') {
        GameState.switchState(GameStates.WALKING);
        delay(naptime);
      }
    break;
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
      warn("Did not copy key '"+original.get(keyi).getClass()+"' because it did not match type! Class: "+keyi+"\n"+original.get(keyi));
    }
  }
  return duplicate;
}

interface Clickable { // all clickable features should have this interface
  abstract void onClick();          // what happens opon being clicked
  abstract boolean isClickable();   // can this item be clicked at this time
  abstract float[] getDimensions(); // [x,y,w,h]
}
void updateClickables(ArrayList<Clickable> clickables){
  if (!mousePressed) return;
  for (Clickable clickable : clickables){
    updateClickables(clickable);
  }
}
void updateClickables(Clickable clickable) {
  if (!mousePressed) return;
  float[] dims = clickable.getDimensions();
  if (clickable.isClickable() && (mouseX >= dims[0] && mouseX <= dims[0]+dims[2]) && (mouseY >= dims[1] && mouseY <= dims[1]+dims[3])) {
    clickable.onClick();
    delay(naptime);
  }
}

interface Drawable {
  abstract void draw(); // draw this feature
}
void updateDrawables(ArrayList<Drawable> drawables){
  for (Drawable drawable : drawables){
    updateDrawables(drawable);
  }
}
void updateDrawables(Drawable drawable){
  drawable.draw();
}
void warn(String message) {
  println("!WARNING! "+message);
}
