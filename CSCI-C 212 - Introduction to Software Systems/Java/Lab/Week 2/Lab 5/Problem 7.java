/*
What is the result of attempting to compile and run the following code?

class Seven {
  static int value;
  public static void main(String[] args) {
    Seven alpha = new Seven();
    Seven beta = new Seven();
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

- We get (b); compiles and produces 0 0

*/

class Seven {
  static int value;
  public static void main(String[] args) {
    Seven alpha = new Seven();
    Seven beta = new Seven();
    System.out.println(alpha.value + " " + beta.value);
  }
}