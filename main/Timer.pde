class Timer{
  
  private int timeStamp = 0;
  private int timeInterval = 0;
  private boolean once = false;
  
  public Timer(int timeInterval){
    this.timeInterval = timeInterval;
  }
  
  public boolean countDown(){
    if (timeStamp + timeInterval < millis()){
      timeStamp = millis();
      return true;
    } else {
      return false;
    }
  }
  
  public boolean countDownOnce(){
    if(!once){
      if (timeStamp + timeInterval < millis()){
        timeStamp = millis();
        once = true;
        return true;
      }
    }
    return false;
  }
  
  public boolean countDownUntil(boolean stop){ //function made with use of the spritesheet class in mind
    if (timeStamp + timeInterval < millis()){
      if(stop){
        return false;
      }
      timeStamp = millis();
      return true;
    } else {
      return false;
    }
  }
  
  public boolean coolDown(){
    if (timeStamp + timeInterval < millis()){
      return true;
    } else {
      return false;
    }
  }
  
  public void updateTs(){
    timeStamp = millis();
  }
  
  public void change(int time){
    this.timeStamp = time;
  }
  
  public void clearOnce(){
     this.once = false; 
  }
  
}
