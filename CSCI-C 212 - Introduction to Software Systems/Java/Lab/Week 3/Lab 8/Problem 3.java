/*
You attempt to compile and run this code:

class Alpha {
  public static void main(String[] args) {
    Beta f = new Beta(3);
  }
  Alpha() { System.out.println(0); }
  Alpha(int i) {
    System.out.println(i);
  }
}
class Beta extends Alpha {
  Beta()      { }
  Beta(int i) { }
}

What is the outcome?

- This function prints out 0. I also receive one warning

1 warning found:
File: /Users/lonis/Library/Mobile Documents/com~apple~CloudDocs/Dropbox/Dropbox/School/Sophmore Year (Fall 2015 - Summer 2016)/Summer 2016/CSCI-C 212/C212-Summer-2016/Java/Lab/Week 3/Lab 8/Problem 3.java  [line: 25]
Warning: The value of the local variable f is not used

*/

class Alpha {
  public static void main(String[] args) {
    Beta f = new Beta(3);
  }
  Alpha() { System.out.println(0); }
  Alpha(int i) {
    System.out.println(i);
  }
}
class Beta extends Alpha {
  Beta()      { }
  Beta(int i) { }
}