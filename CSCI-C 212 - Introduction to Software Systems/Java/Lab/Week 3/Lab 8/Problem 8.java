/*
You attempt to compile and run this code:

class Alpha {
  public static void main(String[] args) {
    Beta f = new Alpha();
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

- Doesn't compile and throw 1 error:

1 error found:
File: /Users/lonis/Library/Mobile Documents/com~apple~CloudDocs/Dropbox/Dropbox/School/Sophmore Year (Fall 2015 - Summer 2016)/Summer 2016/CSCI-C 212/C212-Summer-2016/Java/Lab/Week 3/Lab 8/Problem 8.java  [line: 24]
Error: Type mismatch: cannot convert from Alpha to Beta


This error is due to trying to convert one consturtor into another
*/

class Alpha {
  public static void main(String[] args) {
    Beta f = new Alpha();
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