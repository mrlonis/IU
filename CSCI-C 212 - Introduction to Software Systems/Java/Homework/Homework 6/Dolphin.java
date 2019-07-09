public class Dolphin extends Creature {
  public Dolphin (String name) {
    super(name);
  }
  public int howLong() {
    return 40;
  }
  public void details() {
    System.out.println("Hello, my name is " + name + " and my projected life expectancy as a Dolphin is " + howLong() + " years.");
  }
}