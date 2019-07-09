/*
You compile and run this program.
class Two {
  int a = 0;
  int b = 0;
  void fun() {
    b += 1;
    a += 1;
    System.out.print(a + " " + b + " ");
  }
  public static void main(String[] args) {
    Two alpha = new Two();
    Two beta = new Two();
    alpha.fun();
    beta.fun();
    alpha.fun();
  }
}
What is the output that it produces? Why?

- The output is "1 1 1 1 2 2" without quotation marks.
- This is because beta.fun isn't related to alpha.fun yet it produces the same result as the first occurence of alpha.fun

*/

class Two {
  int a = 0;
  int b = 0;
  void fun() {
    b += 1;
    a += 1;
    System.out.print(a + " " + b + " ");
  }
  public static void main(String[] args) {
    Two alpha = new Two();
    Two beta = new Two();
    alpha.fun();
    beta.fun();
    alpha.fun();
  }
}