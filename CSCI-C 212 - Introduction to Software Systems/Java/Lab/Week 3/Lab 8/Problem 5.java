/*
You attempt to compile and run this code:

class Alpha {
  public static void main(String[] args) {
    Beta f = new Beta(3);
  }
  Alpha() {
    System.out.println(0);
  }
  Alpha(int i) {
    System.out.println(i);
  }
}
class Beta extends Alpha {
  Beta() {
    super(6);
  }
  Beta(int i) {
    super(3);
    this();
  }
}

What is the outcome?

- Doesn't compile:

1 error and 1 warning found:
-------------
*** Error ***
-------------
File: /Users/lonis/Library/Mobile Documents/com~apple~CloudDocs/Dropbox/Dropbox/School/Sophmore Year (Fall 2015 - Summer 2016)/Summer 2016/CSCI-C 212/C212-Summer-2016/Java/Lab/Week 3/Lab 8/Problem 5.java  [line: 45]
Error: Constructor call must be the first statement in a constructor
-------------
** Warning **
-------------
File: /Users/lonis/Library/Mobile Documents/com~apple~CloudDocs/Dropbox/Dropbox/School/Sophmore Year (Fall 2015 - Summer 2016)/Summer 2016/CSCI-C 212/C212-Summer-2016/Java/Lab/Week 3/Lab 8/Problem 5.java  [line: 30]
Warning: The value of the local variable f is not used

This error is due to this not being attached to anything. A new way to use this is demonstrated in the code below:

class JBT {
 
 int variable = 5;
 
 public static void main(String args[]) {
  JBT obj = new JBT();
 
  obj.method(20);
  obj.method();
 }
 
 void method(int variable) {
  variable = 10;
  System.out.println("Value of Instance variable :" + this.variable);
  System.out.println("Value of Local variable :" + variable);
 }
 
 void method() {
  int variable = 40;
  System.out.println("Value of Instance variable :" + this.variable);
  System.out.println("Value of Local variable :" + variable);
 }
 
 After further testing I have also realize this(); is throwing an error because we already have a consturctor super(3); before this();. If you swap the order of this(); and super(3);, you get the same error
*/

class Alpha {
  public static void main(String[] args) {
    Beta f = new Beta(3);
  }
  Alpha() {
    System.out.println(0);
  }
  Alpha(int i) {
    System.out.println(i);
  }
}
class Beta extends Alpha {
  Beta() {
    super(6);
  }
  Beta(int i) {
    super(3);
    this();
  }
}