public class CreatureList {
  public static void main(String[] args) {
    Creature [] creatureList = {new Cow("Clarabella"), new Dolphin("Flipper"), new Bass("Adele"), new Guppy("Riddick")};
    
    creatureList[0].details();
    creatureList[1].details();
    creatureList[2].details();
    creatureList[3].details();
  }
}