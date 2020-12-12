class SpriteSheet{
 
  private Timer animationTimer; //main timing for the animations of the class, can be changed
  private Timer pausedTimer = new Timer(0); //seperate timer used with the pause() and unpause() functions
  private PImage[] spriteSheet; //array that contains all of the sprites used for animation
  private int loopstart = 0; //start frame variable of the animation
  private int loopend = 0; //end frame variable of the animation
  private int increment = 0; //current frame of the animation
  public boolean stoploop = false; //variable that if true stops the animation, can be restarted
  private boolean paused = false; //like the stoploop variable, but stops the animation for a period of time
  private boolean adjust = false; //one off variable used to check if the start and end frames have been adjusted
  private boolean reverse = false; //variable used to loop animations cleanly
  private int wide; //length of the spriteSheet array
  private int currentX; //the current x position of the animation
  private int currentY; //the current y position of the animation
  
  public SpriteSheet(PImage[] img, int time){ //makes a spritesheet instance with an array of images
     this.animationTimer = new Timer(time);
    
     this.spriteSheet = new PImage[img.length]; 
     this.wide = img.length; //sets the wide variable to the length of the array
     this.loopend = this.wide;
     
     this.spriteSheet = img; //creates a new spritesheet array using the old array
     
     
  }
  
  public SpriteSheet(PImage img, int time){ //makes a spritesheet instance with a spritesheet image
 
    this.animationTimer = new Timer(time);
    
    this.wide = img.width/16; //sets the wide variable to the length of the array
    spriteSheet = new PImage[this.wide];
    this.loopend = this.wide-1;
    
    for(int i = 0; i < wide; i++){
       this.spriteSheet[i] = img.get(i*16,0,16,16); //creates the spritesheet array by cutting up a spritesheet image
    }
    
  }
  
  /*public void changeDisplay( boolean loopcontrol, int start, int end){ //changeDisplay function which controls looping
    
       if(!adjust){  //changes the start and end if changed
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
     
  }*/
  
  public void changeDisplay(){ //standard changeDisplay() function
    
      if(this.increment == this.loopend){ //just counts up and stops when it runs out of frames
        stoploop = true;
        this.increment--;
      } 
    
      this.increment++;
      
     
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
  
  public void changeDisplay(int start, int end){ // use with change start function
      
      if(!adjust){
        this.loopstart = start;
        this.increment = start-1;
        adjust = true;
      }
      
      this.increment++;
      
      if(increment == end){
        this.stoploop = true;
        this.increment--;
      }
  }
     
  
  
  public void changeDisplay(boolean loopcontrol){ //changeDisplay() function which controls looping
    
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
  
  /*public void changeDisplay(int start, int end){//changeDisplay() function which can change the start and end variables
    
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
     
  }*/
  
  public void displayFrame(){
    
  }
  
  public void display(int x, int y){ //displays the animation at x and y
    image(this.spriteSheet[this.increment] , x, y, 32, 32);
    this.currentX = x;
    this.currentY = y;
  }
  
  public void display(){ //displays the animation (currentX and currentY must already be set)
    image(this.spriteSheet[this.increment] , currentX, currentY, 32, 32);
  }
  
  public void restart(){ //starts the function from the first frame over again
    if(stoploop){
        stoploop = false;
    }
    this.increment = this.loopstart;
  }
  
  public void changeFrame(int frame){ //jumps to the given frame
    this.increment = frame;
  }
  
  public void changeTime(int time){ //changes the animationTimer time
    animationTimer.changeTs(time); 
  }
  
  public void changeStart(int frame){
    this.loopstart = frame;
    this.increment = frame;
  }
  
  public void changeEnd(int frame){
    this.loopend = frame;
  }
  
  public void checkCase(int start){
    if(start != this.loopstart){
      softReset();
    }
  }
  
  public void changeSaE(int frame1, int frame2){ //change start and end (start, end)
    
         if(frame1 > loopstart){
           loopstart = frame1;
           this.increment = loopstart;
         }
         if(frame2 < loopend){
           loopend = frame2;
         }
  }
  
  //public void matchStart(){
  //  this.increment = loopstart;
  //}
  
  public void pause(){ //pauses the function (can be unpaused with a function or after a certain amount of time) 
    this.paused = true;
  }
  
  public void pause(int time){ //pauses the function with a timer, will unpause after the time
    this.paused = true;
    pausedTimer.changeTs(time);
  }
  
  public void unpause(){ //unpauses the function if no timer
    this.paused = false;
    pausedTimer.changeTs(0);
  }
  
  public void skip(){ //tba
     
  }
  
  public void softReset(){ //reset the adjust function and stoploop
    this.adjust = false;
    this.stoploop = false;
    this.loopstart = 0;
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
