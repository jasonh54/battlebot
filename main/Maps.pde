class Maps {
  String id;
  //layer objects - 5 to each map
  OverlayLayer collidelayer = new OverlayLayer();
  Layer baselayer = new Layer();
  Layer coverlayer = new Layer();
  Layer portallayer = new Layer();
  Layer toplayer = new Layer();
  
  //layer array
  Layer[] layerset = {baselayer, coverlayer, collidelayer, portallayer, toplayer};
  //portal-map pair list
  HashMap<Tile, Maps> portalPairs = new HashMap<Tile, Maps>();
  
  //constructor for most maps
  public Maps(String id) {
    //name the self
    this.id = id;
    //retrieve the map to copy from the database
    
    JSONObject thismap = mapsDatabase.get(id);
    generateAllLayers(loadTileArray(thismap.getJSONArray("collide")),loadTileArray(thismap.getJSONArray("portal")),loadTileArray(thismap.getJSONArray("base")),loadTileArray(thismap.getJSONArray("cover")),loadTileArray(thismap.getJSONArray("top")));
  
    println(mapsDatabase.keySet().toString());
    println(id);
  
    //generate each layer via 2d JSONArrays from the JSONObject
    //allow the layers to imprint to this map
    for (int i = 0; i < layerset.length; i++) {
      layerset[i].parent = this;
    }
  }
  
  //constructor for currentmap, which starts blank
  public Maps() {
    
  }
  
  //find some way to search a tile in a JSON database and retrieve the map it is paired with, to place into portalPairs here
  //currently bad; pairs all portals with one given map. fix later
  void pairPortal(Maps othermap) {
    for (int i = 0; i < this.portallayer.portalTiles.size(); i++) {
      portalPairs.put(this.portallayer.portalTiles.get(i),othermap);
    }
  }
  
  void generateAllLayers(int[][] collide, int[][] portal, int[][] base, int[][] cover, int[][] top) {
    println("collide");
    collidelayer.generateBaseLayer(collide);
    println("portal");
    portallayer.generateBaseLayer(portal);
    println("base");
    baselayer.generateBaseLayer(base);
    println("cover");
    coverlayer.generateBaseLayer(cover);
    println("top");
    toplayer.generateBaseLayer(top);
  }
  
  //default does not update toplayer as it must update after the player
  void update() {
    baselayer.update(collidelayer);
    coverlayer.update(collidelayer);
    collidelayer.update();
    portallayer.update(collidelayer);
  }
  
  void updateAll() {
    baselayer.update(collidelayer);
    coverlayer.update(collidelayer);
    collidelayer.update();
    portallayer.update(collidelayer);
    toplayer.update(collidelayer);
  }
  
  void totalDraw() {
    baselayer.draw();
    coverlayer.draw();
    collidelayer.draw();
    toplayer.draw();
  }

  //given a 2d JSONArray, copy contents and return as a 2d intarray
  //note: this works for ONE LAYER; does not process an entire map
  int[][] loadTileArray(JSONArray ogarr) {
    //int[size of outer JSONArray][size of first JSONArray within the outer JSONArray]
    int[][] arr = new int[ogarr.size()][ogarr.getJSONArray(0).size()];
    //int[][] arr = new int[100][100];
    //for each JSONArray within the original JSONArray
    for (int i = 0; i < ogarr.size(); i++) {
      //create a dummy int[] identical to an int-only version of the current JSONArray within the outer JSONArray (ogarr)
      int[]  dummy = ogarr.getJSONArray(i).getIntArray();
      //set the current row to be equal to the current dummy array
      for (int k = 0; k < dummy.length; k++) {
        arr[i][k] = dummy[k];
      }
    }
    return arr;
  }
}
