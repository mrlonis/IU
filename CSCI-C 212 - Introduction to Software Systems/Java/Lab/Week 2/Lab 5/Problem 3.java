/*
You compile and run this program.
class Three {
  int a = 0;
  static int b = 0;
  void fun() {
    b += 1;
    a += 1;
    System.out.print(a + " " + b + " ");
  }
  public static void main(String[] args) {
    Three alpha = new Three();
    Three beta = new Three();
    alpha.fun();
    beta.fun();
    alpha.fun();
  }
}
What is the output that it produces? Why?

- It produces "1 1 1 2 2 3" without the quotation marks
- This is because b is a static integer which will stay the same throughout alpha.fun and beta.fun

*/

class Three {
  int a = 0;
  static int b = 0;
  void fun() {
    b += 1;
    a += 1;
    System.out.print(a + " " + b + " ");
  }
  public static void main(String[] args) {
    Three alpha = new Three();
    Three beta = new Three();
    alpha.fun();
    beta.fun();
    alpha.fun();
  }
}