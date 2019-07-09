/*
You attempt to compile and run this code:

class Alpha {
  public static void main(String[] args) {
    Beta f = new Beta(12);
  }
  Alpha() {
    System.out.print(0);
  }
  Alpha(int i) {
    System.out.print(i);
  }
}
class Beta extends Alpha {
  Beta() {
  }
  Beta(int i) {
    this();
    System.out.print(3);
  }
}

What is the outcome?

- Prints out '03>' without the ' ' marks
*/

class Alpha {
  public static void main(String[] args) {
    Beta f = new Beta(12);
  }
  Alpha() {
    System.out.print(0);
  }
  Alpha(int i) {
    System.out.print(i);
  }
}
class Beta extends Alpha {
  Beta() {
  }
  Beta(int i) {
    this();
    System.out.print(3);
  }
}