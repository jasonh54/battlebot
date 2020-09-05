class SpriteSheet{
 
  private Timer animationTimer;
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
  
  public SpriteSheet(PImage[] img, int time){
     this.animationTimer = new Timer(time);
    
     this.spriteSheet = new PImage[img.length];
     this.wide = img.length;
     this.loopend = this.wide;
     
     for(int i = 0; i < this.spriteSheet.length; i++){
       this.spriteSheet[i] = img[i];    
     }
     
  }
  
  public SpriteSheet(PImage img, int time){
    this.animationTimer = new Timer(time);
    
    this.wide = img.width/16;
    spriteSheet = new PImage[this.wide];
    this.loopend = this.wide-1;
    
    for(int i = 0; i < wide; i++){
       this.spriteSheet[i] = img.get(i*16,0,16,16);
    }
    
  }
  
  public void changeDisplay( boolean loopcontrol, int start, int end){
    
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
    
      if(this.increment == this.loopend){
        reverse = true;
      }  
    
      if(reverse){
         this.increment--;
       } else {
         this.increment++; 
       }
       
     if(this.increment == this.loopstart && !loopcontrol){
        stoploop = true;
     } else {
        reverse = false;
     }
     
     /*if(!adjust){
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
     }*/
     
  }
  
  public void changeDisplay(){
    
      if(this.increment == this.loopend){
        stoploop = true;
        this.increment--;
      } 
    
      this.increment++;
      
     
     /*if(this.increment == this.loopend){
        reverse = true;
      } 
      
      if(reverse){
         this.increment--;
       } else {
         this.increment++; 
       }
       
       if(this.increment == this.loopstart){
        reverse = false; 
     }*/
     
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
  
  public void changeTime(int time){
     animationTimer.changeTs(time); 
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
  by default it will not loop the animation, nor will it loop it will reverse
  it can take in:
  bool (loopcontrol) "loopcontrol" variable: put "false" to play animation with reverse once, put "true" to loop animation with reverse
  int, int (start, end) "start" variable: which frame to start animation (cannot be less than 0), "end" variable: which frame to end animation (cannot be less than 0)
  bool, int, int (loopcontrol, start, end) "start" variable: which frame to start animation (cannot be less than 0), "end" variable: which frame to end animation (cannot be less than 0)
  

*/

//document things
