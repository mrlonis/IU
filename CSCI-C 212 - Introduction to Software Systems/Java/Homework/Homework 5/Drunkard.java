import java.util.Random;

public class Drunkard {
  public int x = 0;
  public int y = 0;
  
  public Drunkard (int x1, int y1) {
    x = x1;
    y = y1;
  }
  
  public static int randInt(int min, int max) {
    Random rand = new Random();
    int randomNum = rand.nextInt((max - min) + 1) + min;
    return randomNum;
}
  
  public static void main(String[] args) {
    int i = 0;
    for (i = 0; i != 100; i++) {
      Drunkard newDrunkard1 = new Drunkard(0, 0);
      System.out.println("Drunkard #" + (i + 1) + " is starting at: (" + newDrunkard1.x + ", " + newDrunkard1.y + ")");
      
      int x = 0;
      
      while (x != 100) {
        int choice = randInt(0, 3);
        
        if (choice == 0) {
          newDrunkard1 = new Drunkard( (newDrunkard1.x - 1), newDrunkard1.y);
        } else if (choice == 1) {
          newDrunkard1 = new Drunkard( (newDrunkard1.x + 1), newDrunkard1.y);
        } else if (choice == 2) {
          newDrunkard1 = new Drunkard(newDrunkard1.x, (newDrunkard1.y - 1));
        } else {
          newDrunkard1 = new Drunkard(newDrunkard1.x, (newDrunkard1.y + 1));
        }
        x++;
      }
      System.out.println ("Drunkard #" + (i + 1) + " ended at: (" + newDrunkard1.x + ", " + newDrunkard1.y + ")");
    }
  }
}