/*
What is the output of this program and why?

It prints 20 because when x is 19, it'll pass the conditional meaning x then goes to 20. Once it turns 20 it fails the 
conditional and gets printed

class Nine {
  public static void main(String[] args) {
    int x = 10;
    while (x < 20)
      x = x + 1;
      System.out.print(x);
  }
}
*/

class Nine {
  public static void main(String[] args) {
    int x = 10;
    while (x < 20)
      x = x + 1;
      System.out.print(x);
  }
}