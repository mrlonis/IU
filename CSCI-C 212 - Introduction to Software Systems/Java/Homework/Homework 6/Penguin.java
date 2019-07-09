public class Penguin extends Bird {
  String name1;
  public Penguin (String name) {
    super(name);
    name1 = name;
  }
  public int howLong() {
    return 20;
  }
  public void details() {
    System.out.println("Hello, my name is " + name1 + " and my projected life expectancy as a Penguin is " + howLong() + " years.");
    System.out.println("As a penguin I cannot fly, however I can deep dive in the ocean, something that ducks can't do.");
  }
}