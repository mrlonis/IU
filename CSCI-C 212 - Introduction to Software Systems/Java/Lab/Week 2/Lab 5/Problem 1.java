/*
You compile and run this program.

class One {
  int a = 0;
  int b = 0;
  void fun() {
    b += 1;
    a += 1;
    System.out.print(a + " " + b + " ");
  }
  public static void main(String[] args) {
    One alpha = new One();
    alpha.fun();
    alpha.fun();
    alpha.fun();
  }
}

What is the output that it produces? Why?

- The output is 1 1 2 2 3 3 because each iteration of alpha.fun(); makes a nd b go up by 1 unit.

Don't forget: first write the answer down on paper.

Then type the code in the computer and check.

Finally indicate what the result was and what that means for your understanding.
*/

class One {
  int a = 0;
  int b = 0;
  void fun() {
    b += 1;
    a += 1;
    System.out.print(a + " " + b + " ");
  }
  public static void main(String[] args) {
    One alpha = new One();
    alpha.fun();
    alpha.fun();
    alpha.fun();
  }
}