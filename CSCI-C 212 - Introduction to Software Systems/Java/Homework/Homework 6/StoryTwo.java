public class StoryTwo {
  public static void main(String[] args) {
    Creature [] creatureList = {new Duck("Duckers"), new Parrot("Copy-Cat"), new Penguin("Emperor")};
    
    creatureList[0].details();
    creatureList[1].details();
    creatureList[2].details();
  }
}