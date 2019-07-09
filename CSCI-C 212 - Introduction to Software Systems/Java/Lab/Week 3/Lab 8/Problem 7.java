/*
You attempt to compile and run this code:

class Alpha {
  public static void main(String[] args) {
    Alpha f = new Beta();
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
  String test(long i) {
    return i + " ";
  }
}

What is the outcome?

- Compiles and prints out 4
*/

class Alpha {
  public static void main(String[] args) {
    Alpha f = new Beta();
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
  String test(long i) {
    return i + " ";
  }
}