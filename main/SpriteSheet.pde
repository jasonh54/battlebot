//sprite sheet class
//takes a large PImage and cuts it apart into smaller PImages

/*class SpriteSheet{
  
  private PImage spriteSheet;
  private int wide;
  private int increment = 0;
  private boolean reverse = false;
  public boolean stoploop = false;
  
  
  public SpriteSheet(PImage PImg){
    this.spriteSheet = PImg;
    wide = PImg.width/16;
    
 }
   
   public void display(int x, int y, boolean stop, int disp){
     if(disp != 0){
       wide = disp;    
     }
     
     if(this.increment >= wide){
        reverse = true;
        this.increment--; 
     } 
     
       clear();
       image(this.spriteSheet , x, y, 64, 64, 0 + (increment*16), 0, 16 * (increment+1), 16);
       
       if(reverse){
         this.increment--;
       } else {
         this.increment++; 
       }
       
       if(this.increment == 0){
        reverse = false; 
        
        if(stop){
           clear();
           image(this.spriteSheet , x, y, 64, 64, 0 + (increment*16), 0, 16 * (increment+1), 16);
           this.stoploop = stop;
        }
     }
       
     
   }
 
  
}*/

class SpriteSheetArr{
 
  private PImage[] spriteSheet;
  private int increment = -1;
  public boolean stoploop = false;
  private boolean reverse = false;
  private int wide;
  private int currentX;
  private int currentY;
  
  public SpriteSheetArr(PImage[] img){
     this.spriteSheet = new PImage[img.length];
     this.wide = img.length;
     
     for(int i = 0; i < this.spriteSheet.length; i++){
       this.spriteSheet[i] = img[i];    
     }
     
  }
  
  public void changeDisplay(int x, int y, boolean stop, int start, int end){
    
      if(end != 0){
        if(end >= wide){
           end = wide; 
        } else {
          wide = end;
        }
      }
      
      if(start != -1){
        if(start >= wide - 2){
          start = wide - 2;
        } else {
           
        }
      }
    
      if(this.increment == wide - 1){
        reverse = true;
      } 
      
      //clear();
      
      //image(this.spriteSheet[increment] , x, y, 64, 64);
      this.currentX = x;
      this.currentY = y;
      
      if(reverse && !stop){
         this.increment--;
       } else if(!stop){
         this.increment++; 
       }
       
       if(this.increment == 0){
        reverse = false; 
     }
     
  }
  
  public void changeDisplay(int x, int y){
    
      if(this.increment == wide-1){
        reverse = true;
      } 
      
      //clear();
      
      //image(this.spriteSheet[increment] , x, y, 64, 64);
      this.currentX = x;
      this.currentY = y;
      
      if(reverse){
         this.increment--;
       } else{
         this.increment++; 
       }
       
       if(this.increment == 0){
        reverse = false; 
     }
     
  }
  
  public void changeDisplay(int x, int y, boolean stop){
    
      if(this.increment == wide-1){
        reverse = true;
      } 
      
      //clear();
      
      //image(this.spriteSheet[increment] , x, y, 64, 64);
      this.currentX = x;
      this.currentY = y;
      
      if(reverse && !stop){
         this.increment--;
       } else if(!stop){
         this.increment++; 
       }
       
       if(this.increment == 0){
        reverse = false; 
     }
     
  }
  
  public void display(){
    image(this.spriteSheet[this.increment] , currentX, currentY, 64, 64);
  }
  
}

/*
working example of how to display an animated sprite on a timer

if(animationTimer.countDownUntil(SSAirA.stoploop)){
    SSAirA.display(false,0);
  }
  
  first parameter tells the program whether to loop once or loop forever
  second parameter tells the program if it should only loop a certain amount of frames, say instead of going from frame 1 - 5 over and over, it should only go to frame 1 - 4 over and over

*/
