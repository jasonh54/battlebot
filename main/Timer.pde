class Timer{
  
  private int timeStamp = 0;
  private int timeInterval = 0;
  
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
  
  public boolean countDownUntil(boolean stop){
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
  
}
