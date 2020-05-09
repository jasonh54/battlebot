//sprite sheet class
//takes a large PImage and cuts it apart into smaller PImages

class SpriteSheet{
  
  private PImage spriteSheet;
  private int wide;
  private int increment = 0;
  
  public SpriteSheet(PImage PImg){
    this.spriteSheet = PImg;
    wide = PImg.width/16;
    
 }
   
   public void display(){
     if(this.increment > wide){
        this.increment = 0; 
     }
      
     clear();
     image(this.spriteSheet , 80, 80, 64, 64, 0 + (increment*16), 0, 16 * (increment+1), 16);
     this.increment++;
   }
 
  
}
