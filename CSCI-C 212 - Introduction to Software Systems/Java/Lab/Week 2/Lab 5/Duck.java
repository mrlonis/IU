public class Duck extends Bird {
  String name1;
  public Duck (String name) {
    super(name);
    name1 = name;
  }
  public int howLong() {
    return 20;
  }
  public void details() {
    System.out.println("Hello, my name is " + name1 + " and my projected life expectancy as a Duck is " + howLong() + " years.");
    System.out.println("As a Duck I can fly and swim. The only problem is, I cannot deep dive ike the penguins.");
  }
}