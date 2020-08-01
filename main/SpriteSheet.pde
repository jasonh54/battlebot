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
  private int increment = 0;
  public boolean stoploop = false;
  private boolean reverse = false;
  private int wide;
  private int currentX;
  private int currentY;
  
  public SpriteSheet(PImage[] img){
     this.spriteSheet = new PImage[img.length];
     this.wide = img.length;
     
     for(int i = 0; i < this.spriteSheet.length; i++){
       this.spriteSheet[i] = img[i];    
     }
     
  }
  
  public SpriteSheet(PImage img){
    this.wide = img.width/16;
    spriteSheet = new PImage[this.wide];
    
    for(int i = 0; i < wide; i++){
       this.spriteSheet[i] = img.get(i*16,0,16,16);
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
  
  public void changeDisplay(int x, int y, int stop){
    
      if(this.increment == wide-1){
        reverse = true;
      } 
      
      //clear();
      
      //image(this.spriteSheet[increment] , x, y, 64, 64);
      this.currentX = x;
      this.currentY = y;
      
      if(reverse && (stop == 1)){
         this.increment--;
       } else if(stop == 1){
         this.increment++; 
       }
       
       if(this.increment == 0){
        reverse = false; 
     }
     
  }
  
  public void display(){
    image(this.spriteSheet[this.increment] , currentX, currentY, 32, 32);
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
  int, int (x,y) "x,y" variables: where to display animation
  int, int, int (x,y, stop) "stop" variable: put "0" to loop animation once, put "1" to loop animation once without reverse (bad input makes stop do nothing)
  int, int, int, int, int (x,y, stop, start, end) "start" variable: which frame to start animation (cannot be less than 0), "end" variable: which frame to end animation (cannot be less than 0)

*/

//document things
