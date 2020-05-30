enum MenuStates{
    INVENTORY,
    MONSTERLIST
}

class Menu {
  String[] states = {"INVENTORY", "MONSTERLIST"};
  
  public Menu() {
    
  }
  
  
  public void assembleMenu(HashMap<String, Button> buttons) {
    for (int i = 0; i < states.length; i++) {
      Button temp = new Button(0, 0, states[i]);
      buttons.put(states[i], temp);
    }
  }
  
}
