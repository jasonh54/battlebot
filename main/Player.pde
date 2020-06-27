
//helper function that will generate the character sprites for NPC and player
public PImage[] createCharacterSprites(int playerNum){
  int i = 0;
  PImage[] characterSprites = new PImage[12];
  for(int row=0 + playerNum*3;row<3+ playerNum*3;row++){
    int tileNum = (27*(row+1))-4;
    for(int col = 0; col< 4; col++){
      characterSprites[i] = tiles[tileNum];
      i++;
      tileNum++;
    }
  }
  return characterSprites;
}


//player class
class Player{
  

  int direction = 0; //0 = north, 1 = east, 2 = south, 3 = west;

  PImage[] sprites; //character sprites
  SpriteSheetArr animations;
  final int h = 16;
  final int w = 16;
  final int scale = 2;

  
  ArrayList<Items> items = new ArrayList<Items>();
  ArrayList<Monster> monsters = new ArrayList<Monster>();
  
  public Player(PImage[] sprites){
    this.sprites = sprites; 
    animations = new SpriteSheetArr(this.sprites);
  }
  
  public void display(){
    image(sprites[4], 400,400, h * scale, w * scale);
    if(animationTimer.countDownUntil(animations.stoploop)){
      //animations.changeDisplay();
    }
    //animations.display();
  }
  
  //player needs key pressed to trigger animations
  
}


//work on player aniamtion, tile guide .png
//23 - 26 and so on are player sprites
//make a seperate animation tool, uses an array of images than a spritesheet
