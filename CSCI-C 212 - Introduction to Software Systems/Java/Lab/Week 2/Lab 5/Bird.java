abstract public class Bird extends Creature {
  public String name;
  Bird (String name) {
    super(name);
  }
  abstract public int howLong();
  abstract public void details();
}