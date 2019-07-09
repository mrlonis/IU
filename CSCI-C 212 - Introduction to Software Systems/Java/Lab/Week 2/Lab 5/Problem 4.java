/*
What is the result of attempting to compile and run the following code?

class Four {
  int value;
  Four () {
    value = 3;
  }
  public static void main(String[] args) {
    Four alpha = new Four(3);
    Four beta = new Four();
    System.out.println(alpha.value + " " + beta.value);
  }
}

Here are some possibilities:

(a) The program does not compile. 
(b) The program compiles and runs and outputs 0 0 
(c) The program compiles and runs and outputs 3 0 
(d) The program compiles and runs and outputs 0 3 
(e) The program compiles and runs and outputs 3 3
(f) None of the above.

Please explain.

- We get option (a); the program does not compile
- 1 error found:
File: J:\School\Sophmore Year (Fall 2015 - Summer 2016)\Summer 2016\CSCI-C 212\Java\Lab\Week 2\Lab 5\Problem 4.java  [line: 34]
Error: The constructor Four(int) is undefined

- We have defined Four to accept no arguments so when we say new Four(3), the compiler gives out the error that 
   Four(int) is undefined because technically it is.

*/

class Four {
  int value;
  Four () {
    value = 3;
  }
  public static void main(String[] args) {
    Four alpha = new Four(3);
    Four beta = new Four();
    System.out.println(alpha.value + " " + beta.value);
  }
}