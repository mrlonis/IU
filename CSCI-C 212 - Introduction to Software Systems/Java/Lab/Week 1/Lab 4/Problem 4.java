/*
What is the output of this program and why?

The output is 3. This is because since it fails the first (x > 5) and ignored the (x < 10) if conditional and instead goes to the end.

class Eight {
  public static void main(String[] args) {
    int x = 3;
    if (x > 5)
      if (x < 10)
        System.out.print(1);
    else
      System.out.print(2);
    System.out.print(3);
  }
}
What happens if we add two curly braces to the program as follows:
class Acht {
  public static void main(String[] args) {
    int x = 3;
    if (x > 5) {
      if (x < 10)
        System.out.print(1); }
    else
      System.out.print(2);
    System.out.print(3);
  }
}
Does anything change? Why or why not?

It prints 23 because this time it sees the else
      System.out.print(2); as being apart of the first if statement instead of the second one and so it prints out 23
*/

class Acht {
  public static void main(String[] args) {
    int x = 3;
    if (x > 5) {
      if (x < 10)
        System.out.print(1); }
    else
      System.out.print(2);
    System.out.print(3);
  }
}