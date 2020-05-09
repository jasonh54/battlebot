//sprite sheet class
//takes a large PImage and cuts it apart into smaller PImages

class SpriteSheet{
  
  private PImage spriteSheet;
  private int wide;
  private PImage[] sprites;
  private int spriteStart = 0;
  private int spriteInterval = 200;
  
  public SpriteSheet(PImage PImg){
    this.spriteSheet = PImg;
    wide = PImg.width;
    this.sprites = new PImage[wide/16];
    
    for(int i = 0; i < wide/16; i++){
      
      clear();
      //image(this.spriteSheet, 80, 80, 0 + (i * 16), 16);
      image(this.spriteSheet , 80, 80, 64, 64, 0 + (i*16), 0, 16 * (i+1), 16);
      
     }
      
   }
 
  
}
