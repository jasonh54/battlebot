
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
  int x = 400;
  int y = 400;
  final int scale = 2;

  
  ArrayList<Items> items = new ArrayList<Items>();
  ArrayList<Monster> monsters = new ArrayList<Monster>();
  
  public Player(PImage[] sprites){
    this.sprites = sprites; 
    animations = new SpriteSheet(this.sprites, 500);
  }
  
  public void display(){
    //image(sprites[0], 400,400, h * scale, w * scale);
    if(keyPressed == true){
      if (key == 'w') {
        direction= PlayerMovementStates.UP;
      } else if (key == 's') {
        direction= PlayerMovementStates.DOWN;
      } else if (key == 'a') {
        direction= PlayerMovementStates.LEFT;
      } else if (key == 'd') {
        direction= PlayerMovementStates.RIGHT;
      }
    }
    
    switch(direction){
      case UP:
        moveUp();
        break;
      case DOWN:
        moveDown();
        break;
      case LEFT:
        moveLeft();
        break;
      case RIGHT:
        moveRight();
        break;
      default:
        
        break;
    }

<<<<<<< HEAD
    
    animations.display(400,400);
=======
    if(animations.animationTimer.countDownUntil(animations.stoploop)){
      animations.changeSaE(0,2);
      animations.changeDisplay(false);
    }
>>>>>>> 531f1366812b5df448bbffa353ed2c3c7e1bd3ae

  }
  
  
  
  //player needs key pressed to trigger animations
  void moveUp(){
    if(animations.animationTimer.countDownUntil(animations.stoploop)){
      animations.changeSaE(6,8);
      animations.changeDisplay( false);
    }
  }
  
  void moveDown(){
    if(animations.animationTimer.countDownUntil(animations.stoploop)){
      animations.changeSaE(3,5);
      animations.changeDisplay( false);
    }
  }
  
  void moveLeft(){
    if(animations.animationTimer.countDownUntil(animations.stoploop)){
      animations.changeSaE(0,2);
      animations.changeDisplay( false);
    }
  }
  
  void moveRight(){
    if(animations.animationTimer.countDownUntil(animations.stoploop)){
      animations.changeSaE(9,11);
      animations.changeDisplay( false);
    }
  }
  
  
}



//make a seperate animation tool, uses an array of images than a spritesheet
