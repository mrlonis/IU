public class Parrot extends Bird {
  String name1;
  public Parrot (String name) {
    super(name);
    name1 = name;
  }
  public int howLong() {
    return 50;
  }
  public void details() {
    System.out.println("Hello, my name is " + name1 + " and my projected life expectancy as a Parrot is " + howLong() + " years.");
    System.out.println("As a parrot I can fly, unlike my penguin cousins. I can also speak audible human words.");
  }
}