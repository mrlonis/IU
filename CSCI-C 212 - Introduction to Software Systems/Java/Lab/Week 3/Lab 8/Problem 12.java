/*
You attempt to compile and run this code:

class Alpha {
  public static void main(String[] args) {
    System.out.println("... won't compile");
  }
  public static void main() {
    System.out.println("... will not run");
  }
}

What is the outcome?

- Compiles and prints "... won't compile" without the " " marks
*/

class Alpha {
  public static void main(String[] args) {
    System.out.println("... won't compile");
  }
  public static void main() {
    System.out.println("... will not run");
  }
}