
//helper function that will generate the character sprites for NPC and player
public PImage[] createCharacterSprites(int playerNum){
  int i = 0;
  PImage[] characterSprites = new PImage[12];
  //locate which row in the tilemapguide the player starts at
  int row = 0 + playerNum*3;
  //locate which tile num col in the tilemapguide the player starts at
  int tilenum = (27*(row+1))-4;
  //for loop that will go through each column
  for(int c = tilenum; c<tilenum+4; c++){
    for(int r = 0; r< 3;r++){
      characterSprites[i] = tiles[c + (r*27)];
      i++;
    }
  }
  return characterSprites;
}
enum PlayerMovementStates{
  UP,
  DOWN,
  LEFT,
  RIGHT,
  STATIC
}

//player class
class Player{
  
  PlayerMovementStates direction = PlayerMovementStates.STATIC;
  

  PImage[] sprites; //character sprites
  SpriteSheet animations;
  final int h = 16;
  final int w = 16;
  final int scale = 2;

  
  ArrayList<Items> items = new ArrayList<Items>();
  ArrayList<Monster> monsters = new ArrayList<Monster>();
  
  public Player(PImage[] sprites){
    this.sprites = sprites; 
    animations = new SpriteSheet(this.sprites);
    animations.currentX = 400;
    animations.currentY = 400;
  }
  
  public void display(){
    //image(sprites[0], 400,400, h * scale, w * scale);
    animations.display();
    switch(direction){
      case UP:
        
        break;
      case DOWN:
        break;
      case LEFT:
        break;
      case RIGHT:
        break;
      default:
        break;
    }
    if(animationTimer.countDownUntil(animations.stoploop)){
      animations.changeDisplay(400,400, false, 0, 2);
    }
    
  }
  
  
  
  //player needs key pressed to trigger animations
  void moveUp(){
    if(animationTimer.countDownUntil(animations.stoploop)){
      animations.changeDisplay(400,400, false, 6, 8);
    }
  }
  
  void moveDown(){
    if(animationTimer.countDownUntil(animations.stoploop)){
      animations.changeDisplay(400,400, false, 3, 5);
    }
  }
  
  void moveLeft(){
    if(animationTimer.countDownUntil(animations.stoploop)){
      animations.changeDisplay(400,400, false, 0, 2);
    }
  }
  
  void moveRight(){
    if(animationTimer.countDownUntil(animations.stoploop)){
      animations.changeDisplay(400,400, false, 9, 11);
    }
  }
  
  
}



//make a seperate animation tool, uses an array of images than a spritesheet
