/*
You attempt to compile and run this code:

class Alpha {
  public static void main(String[] args) {
    Beta f = new Beta(3);
  }
  Alpha (int i) {  }
}
class Beta extends Alpha {
  Beta(int i) {
  }
}

What is the outcome?

- 1 error and 1 warning found:
-------------
*** Error ***
-------------
File: /Users/lonis/Library/Mobile Documents/com~apple~CloudDocs/Dropbox/Dropbox/School/Sophmore Year (Fall 2015 - Summer 2016)/Summer 2016/CSCI-C 212/C212-Summer-2016/Java/Lab/Week 3/Lab 8/Problem 2.java  [line: 25]
Error: Implicit super constructor Alpha() is undefined. Must explicitly invoke another constructor

*/

class Alpha {
  public static void main(String[] args) {
    Beta f = new Beta(3);
  }
  Alpha (int i) {  }
}
class Beta extends Alpha {
  Beta(int i) {
  }
}