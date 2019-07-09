/*
You attempt to compile and run this code:

abstract class Alpha {
  int value;
  Alpha (int value) {
    this.value = value;
    System.out.println(value);
  }
  public static void main(String[] args) {
    Beta f = new Beta(2011);
  }
}
class Beta extends Alpha {
  Beta  (int value) { super(value); }
}

What is the outcome?

- Compiles and prints 2011. Also throw 1 warning:

1 warning found:
File: /Users/lonis/Library/Mobile Documents/com~apple~CloudDocs/Dropbox/Dropbox/School/Sophmore Year (Fall 2015 - Summer 2016)/Summer 2016/CSCI-C 212/C212-Summer-2016/Java/Lab/Week 3/Lab 8/Problem 11.java  [line: 28]
Warning: The value of the local variable f is not used

*/

abstract class Alpha {
  int value;
  Alpha (int value) {
    this.value = value;
    System.out.println(value);
  }
  public static void main(String[] args) {
    Beta f = new Beta(2011);
  }
}
class Beta extends Alpha {
  Beta  (int value) { super(value); }
}