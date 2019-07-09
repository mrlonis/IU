/*
You attempt to compile and run this code:

class Alpha {
  public static void main(String[] args) {
    Alpha f = new Alpha();
    System.out.println(f.test(3));
  }
  String test(int i) {
    return (i + 2) + " ";
  }
}
class Beta extends Alpha {
  String test(int i) {
    return (i + 1) + " ";
  }
}

What is the outcome?

- Compiles and prints 5
*/

class Alpha {
  public static void main(String[] args) {
    Alpha f = new Alpha();
    System.out.println(f.test(3));
  }
  String test(int i) {
    return (i + 2) + " ";
  }
}
class Beta extends Alpha {
  String test(int i) {
    return (i + 1) + " ";
  }
}