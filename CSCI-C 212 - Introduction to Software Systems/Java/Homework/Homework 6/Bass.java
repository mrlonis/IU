public class Bass extends Fish {
  String name1;
  public Bass (String name) {
    super(name);
    name1 = name;
  }
  public int howLong() {
    return 16;
  }
  public void details() {
    System.out.println("Hello, my name is " + name1 + " and my projected life expectancy as a Bass is " + howLong() + " years.");
  }
}