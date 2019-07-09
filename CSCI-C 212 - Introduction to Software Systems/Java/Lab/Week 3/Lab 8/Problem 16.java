/*
You attempt to compile and run this code:

class Vegetable { } 
class Cabbage extends Vegetable { }
class Kohlrabi extends Cabbage { } 
class Kroger {
  public static void main(String[] args) {
    Kohlrabi a = new Vegetable(); 
  }
}

What is the outcome?

- Compiles but throws 1 error:

1 error found:
File: /Users/lonis/Library/Mobile Documents/com~apple~CloudDocs/Dropbox/Dropbox/School/Sophmore Year (Fall 2015 - Summer 2016)/Summer 2016/CSCI-C 212/C212-Summer-2016/Java/Lab/Week 3/Lab 8/Problem 16.java  [line: 21]
Error: Type mismatch: cannot convert from Vegetable to Kohlrabi

*/

class Vegetable { } 
class Cabbage extends Vegetable { }
class Kohlrabi extends Cabbage { } 
class Kroger {
  public static void main(String[] args) {
    Kohlrabi a = new Vegetable(); 
  }
}