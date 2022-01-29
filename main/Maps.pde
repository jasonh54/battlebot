class Maps {
  //layer objects - 5 to each map
  OverlayLayer collidelayer = new OverlayLayer();
  Layer portallayer = new Layer();
  Layer baselayer = new Layer();
  Layer coverlayer = new Layer();
  Layer toplayer = new Layer();
  
  Layer[] layerset = {collidelayer, portallayer, baselayer, coverlayer, toplayer};
  //portal-map pair list
  HashMap<Tile, Maps> portalPairs = new HashMap<Tile, Maps>();
  
  //create tilesets for each layer
  //lowest layer - ground tiles with no blankspace
  int[][] baseLayerTiles = {
    {89,  90,  90,  90,  90,  90,  90,  90,  90,  90,  91,  461,  441,  463,  89,  90,  90,  90,  90,  90,  90,  90,  90,  90,  91},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {143,  144,  144,  144,  144,  144,  144,  144,  144,  144,  145,  461,  441,  463,  143,  144,  144,  144,  144,  144,  144,  144,  144,  144,  145},
    {406,  406,  406,  406,  406,  406,  406,  406,  406,  406,  406,  467,  441,  466,  406,  406,  406,  406,  406,  406,  406,  406,  406,  406,  406},
    {441,  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,  441},
    {460,  460,  460,  460,  460,  460,  460,  460,  460,  460,  460,  440,  441,  439,  460,  460,  460,  460,  460,  460,  460,  460,  460,  460,  460},
    {89,  90,  90,  90,  90,  90,  90,  90,  90,  90,  91,  461,  441,  463,  89,  90,  90,  90,  90,  90,  90,  90,  90,  90,  91},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {143,  144,  144,  144,  144,  144,  144,  144,  144,  144,  145,  461,  441,  463,  143,  144,  144,  144,  144,  144,  144,  144,  144,  144,  145}
  };
  
  //2nd lowest - for ground tiles with blankspace (need backing)
  int[][] coverLayerTiles = {
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  0,  1,  1,  1,  1,  1,  1,  58,  58,  58,  4},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  27,  28,  28,  28,  28,  28,  29,  28,  28,  28,  34},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  27,  28,  28,  28,  28,  28,  29,  28,  28,  28,  34},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  27,  28,  28,  28,  28,  28,  29,  28,  28,  28,  34},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  27,  28,  28,  28,  28,  28,  32,  1,  1,  1,  29},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  27,  28,  28,  28,  28,  28,  28,  28,  28,  28,  29},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  27,  28,  28,  28,  28,  28,  28,  28,  28,  28,  29},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  27,  28,  28,  28,  28,  28,  28,  28,  28,  28,  29},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  54,  55,  55,  55,  55,  55,  55,  55,  55,  55,  56},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  89,  90,  90,  90,  90,  90,  90,  90,  90,  90,  91},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486}
  };
  
  //for collidables - cars, trees, etc
  int[][] collidableLayerTiles = {
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  198,  198,  198,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  198,  198,  198,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  198,  198,  198,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  192,  486,  486,  486,  486,  486,  486,  486,  259,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  192,  486,  422,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  192,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486}
  };
  
  //for portals - doors, street edges, etc
  int[][] portalLayerTiles = {
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  192,  486,  486,  486,  486,  486,  486,  486,  259,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  339,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486}
  };
  
  //top layer - stuff the player can walk under such as lampposts
  int[][] topLayerTiles = {
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  165,  486,  486,  486,  486,  486,  486,  486,  232,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  165,  486,  395,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  165,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486} 
  };
  
  int[][] bt = {
    {8,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  8},
    {27,  28,  28,  28,  28,  28,  28,  28,  28,  28,  28,  28,  28,  28,  28,  29},
    {27,  28,  28,  28,  28,  28,  28,  28,  28,  28,  28,  28,  28,  28,  28,  29},
    {27,  28,  28,  28,  28,  28,  28,  28,  28,  28,  28,  28,  28,  28,  28,  29},
    {27,  28,  28,  28,  28,  28,  198,  198,  28,  28,  28,  28,  28,  28,  28,  29},
    {27,  28,  28,  28,  28,  28,  198,  198,  28,  28,  28,  28,  28,  28,  28,  29},
    {27,  28,  28,  28,  28,  28,  28,  28,  28,  28,  28,  28,  28,  28,  28,  29},
    {27,  28,  28,  28,  28,  28,  28,  28,  28,  28,  28,  28,  28,  28,  28,  29},
    {27,  28,  28,  28,  28,  28,  28,  28,  28,  28,  28,  28,  28,  28,  28,  29},
    {27,  28,  28,  28,  28,  28,  28,  28,  28,  28,  28,  28,  28,  28,  28,  29},
    {27,  28,  28,  28,  28,  28,  28,  28,  28,  28,  28,  28,  28,  28,  28,  29},
    {27,  28,  28,  28,  28,  28,  28,  28,  28,  28,  28,  28,  28,  28,  28,  29},
    {8,  55,  55,  55,  55,  55,  55,  55,  55,  55,  55,  55,  55,  55,  55,  8}
  };
  
  int[][] ct = {
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  170,  171,  171,  172,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  197,  486,  486,  199,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  197,  486,  486,  199,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  224,  225,  225,  226,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  261,  262,  262,  263,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  288,  289,  289,  290,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486}
  };
  
  int[][] pt = {
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  339,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486}
  };
  
  int[][] cvt = {
    {0,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  2},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {54,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  56}
  };
  
  int[][] tt = {
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  234,  235,  235,  236,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486}
  };
  
  //constructor
  public Maps() {
    for (int i = 0; i < layerset.length; i++) {
      layerset[i].parent = this;
    }
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
}
