/*
You attempt to compile and run this code:

abstract class Alpha {
  abstract void complain();
}
class Beta extends Alpha {
  void complain(String s) {
    System.out.println(s);
  }
}
class Tester {
  public static void main(String[] args) {
    Beta f = new Beta();
    f.complain("There's a tomato in every automaton.");
  }
}

What is the outcome?

- Doesn't compile and throws 1 error:

1 error found:
File: /Users/lonis/Library/Mobile Documents/com~apple~CloudDocs/Dropbox/Dropbox/School/Sophmore Year (Fall 2015 - Summer 2016)/Summer 2016/CSCI-C 212/C212-Summer-2016/Java/Lab/Week 3/Lab 8/Problem 13.java  [line: 25]
Error: The type Beta must implement the inherited abstract method Alpha.complain()

*/

abstract class Alpha {
  abstract void complain();
}
class Beta extends Alpha {
  void complain(String s) {
    System.out.println(s);
  }
}
class Tester {
  public static void main(String[] args) {
    Beta f = new Beta();
    f.complain("There's a tomato in every automaton.");
  }
}