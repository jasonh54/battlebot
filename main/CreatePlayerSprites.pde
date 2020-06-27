public void createPlayerSprites(){
  int i = 0;
  for(int row=0;row<3;row++){
    int tileNum = (27*(row+1))-4;
    for(int col = 0; col< 4; col++){
      playerSprites[i] = tiles[tileNum];
      i++;
      tileNum++;
    }
  }
}
