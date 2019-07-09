abstract public class Creature {
  public String name;
  Creature (String name) {
    this.name = name;
  }
  abstract public int howLong();
  abstract public void details();
}