/*
What is the output of this program and why?

- 24 because it is running through two if statements. the first prints 2 the second prints 4

class Seven {
  public static void main(String[] args) {

    int x = 3;
    if (2 > x)
      System.out.print(1);
    else
      System.out.print(2);
    if (x < 2)
      System.out.println(3);
    System.out.print(4);

  }
}
What happens if we add two curly braces to the program as follows:
class Sieben {
  public static void main(String[] args) {

    int x = 3;
    if (2 > x)
      System.out.print(1);
    else
      System.out.print(2);
    if (x < 2) {
      System.out.println(3);
    System.out.print(4); }

  }
}
Does anything change? Why or why not?

The system only prints out 2. This is because after the first else case, the program knows not to run the second else case
*/

class Sieben {
  public static void main(String[] args) {

    int x = 3;
    if (2 > x)
      System.out.print(1);
    else
      System.out.print(2);
    if (x < 2) {
      System.out.println(3);
    System.out.print(4); }

  }
}