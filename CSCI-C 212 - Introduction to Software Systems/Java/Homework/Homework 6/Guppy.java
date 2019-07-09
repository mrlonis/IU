public class Guppy extends Fish {
  String name1;
  public Guppy (String name) {
    super(name);
    name1 = name;
  }
  public int howLong() {
    return 2;
  }
  public void details() {
    System.out.println("Hello, my name is " + name1 + " and my projected life expectancy as a Guppy is " + howLong() + " years.");
  }
}