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

class SpriteSheet{
 
  private PImage[] spriteSheet;
  private int loopstart = 0;
  private int loopend = 0;
  private int increment = 0;
  public boolean stoploop = false;
  private boolean adjust = false;
  private boolean reverse = false;
  private int wide;
  private int currentX;
  private int currentY;
  
  public SpriteSheet(PImage[] img){
     this.spriteSheet = new PImage[img.length];
     this.wide = img.length;
     this.loopend = this.wide;
     
     for(int i = 0; i < this.spriteSheet.length; i++){
       this.spriteSheet[i] = img[i];    
     }
     
  }
  
  public SpriteSheet(PImage img){
    this.wide = img.width/16;
    spriteSheet = new PImage[this.wide];
    this.loopend = this.wide-1;
    
    for(int i = 0; i < wide; i++){
       this.spriteSheet[i] = img.get(i*16,0,16,16);
    }
    
  }
  
  public void changeDisplay(boolean loopcontrol, int start, int end){
    
       if(!adjust){
         increment = start;
         if(start > loopstart){
           loopstart = start;
         }
         if(end < loopend){
           loopend = end;
         }
         adjust = true;
       }
    
      if(this.increment == this.loopend && loopcontrol){
        stoploop = true;
        this.increment--;
      } 
    
      if(this.increment == this.loopend && !loopcontrol){
        reverse = true;
      } 
      
      if(reverse){
         this.increment--;
       } else {
         this.increment++; 
       }
       
     if(this.increment == this.loopstart && !loopcontrol){
        stoploop = true;
     } else if(this.increment == this.loopstart) {
        reverse = false;
     }
     
  }
  
  public void changeDisplay(){
    
      if(this.increment == this.loopend){
        reverse = true;
      } 
      
      if(reverse){
         this.increment--;
       } else {
         this.increment++; 
       }
       
       if(this.increment == this.loopstart){
        reverse = false; 
     }
     
  }
  
  public void changeDisplay(boolean loopcontrol){
    
      if(this.increment == this.loopend && loopcontrol){
        stoploop = true;
        this.increment--;
      } 
    
      if(this.increment == this.loopend && !loopcontrol){
        reverse = true;
      } 
      
      
      if(reverse){
         this.increment--;
       } else {
         this.increment++; 
       }
       
     if(this.increment == this.loopstart && !loopcontrol){
        stoploop = true;
     } else if(this.increment == this.loopstart) {
        reverse = false;
     }
     
  }
  
  public void changeDisplay(int start, int end){
    
      if(!adjust){
         increment = start;
         if(start > loopstart){
           loopstart = start;
         }
         if(end < loopend){
           loopend = end;
         }
         adjust = true;
       }
    
      if(this.increment == loopend){
        reverse = true;
      } 
      
      if(reverse){
         this.increment--;
       } else{
         this.increment++; 
       }
       
       if(this.increment == loopstart){
        reverse = false; 
     }
     
  }
  
  public void display(int x, int y){
    image(this.spriteSheet[this.increment] , x, y, 32, 32);
    this.currentX = x;
    this.currentY = y;
  }
  
  public void display(){
    image(this.spriteSheet[this.increment] , currentX, currentY, 32, 32);
  }
  
  public void restart(){
    if(stoploop){
        stoploop = false;
    }
    this.increment = this.loopstart;
  }
  
  public void changeFrame(int frame){
    this.increment = frame;
  }
  
}

/*
working example of how to display an animated sprite on a timer
------------------------------------------------------------

in this case our SpriteSheet variable is called SSAirA

SpriteSheet SSAirA;

setup an if statement with an Timer (either use a generic one (to have syncronized timing) or a unique one to get the timing you want)

this Timer (called animationTimer) is set to activate every 500 milliseconds (0.5 seconds)

  SSAirA.display(); //use display() to display the current frame of a spritesheet
  
  if(animationTimer.countDownUntil(SSAirA.stoploop)){ 
    SSAirA.changeDisplay(80,80); //use changeDisplay to switch the spritesheet to the next frame
  }
  
   
  
------------------------------------------------------------
  ****IMPORTANT**** section details methods....
  .changeDisplay can be overloaded
  it can take in:
  bool (x,y, loopcontrol) "stop" variable: put "false" to play animation with reverse once, put "true" to play animation once without reverse
  int, int (x,y, start, end) "start" variable: which frame to start animation (cannot be less than 0), "end" variable: which frame to end animation (cannot be less than 0)
  bool, int, int (x,y, stop, start, end) "start" variable: which frame to start animation (cannot be less than 0), "end" variable: which frame to end animation (cannot be less than 0)
  

*/

//document things
