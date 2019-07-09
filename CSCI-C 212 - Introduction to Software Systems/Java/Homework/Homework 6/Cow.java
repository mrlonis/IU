public class Cow extends Creature {
  public Cow (String name) {
    super(name);
  }
  public int howLong() {
    return 15;
  }
  public void details() {
    System.out.println("Hello, my name is " + name + " and my projected life expectancy as a Cow is " + howLong() + " years.");
  }
}