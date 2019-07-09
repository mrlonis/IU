abstract public class Fish extends Creature {
  public String name;
  Fish (String name) {
    super(name);
  }
  abstract public int howLong();
  abstract public void details();
}