/*
You attempt to compile and run this code:

class Alpha {
  String message;
  Alpha (String msg) { message = msg; }
}
class Beta extends Alpha {
  Beta (String msg)  { message = msg; }
}
class Tester {
  public static void main(String[] args) {
    Beta f = new Beta("Greetings");
    System.out.println(f.message);
  }
}

What is the outcome?

- Doesn't compile and throws 1 error:

1 error found:
File: /Users/lonis/Library/Mobile Documents/com~apple~CloudDocs/Dropbox/Dropbox/School/Sophmore Year (Fall 2015 - Summer 2016)/Summer 2016/CSCI-C 212/C212-Summer-2016/Java/Lab/Week 3/Lab 8/Problem 14.java  [line: 26]
Error: Implicit super constructor Alpha() is undefined. Must explicitly invoke another constructor

*/

class Alpha {
  String message;
  Alpha (String msg) { message = msg; }
}
class Beta extends Alpha {
  Beta (String msg)  { message = msg; }
}
class Tester {
  public static void main(String[] args) {
    Beta f = new Beta("Greetings");
    System.out.println(f.message);
  }
}