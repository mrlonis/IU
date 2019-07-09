/*
What is the result of attempting to compile and run the following code?

class Six {
  static int value;
  Six (int v) {
    value = v;
  }
  public static void main(String[] args) {
    Six alpha = new Six(0);
    Six beta = new Six(3);
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

- We get option (e); compiles and outputs 3 3.
- This is because we aren't accessing the fields in a static way
- value is a static variable, holding its value regardless
- After Six beta = new Six(3), alpha.value and beta.value equals 3

*/

class Six {
  static int value;
  Six (int v) {
    value = v;
  }
  public static void main(String[] args) {
    Six alpha = new Six(0);
    Six beta = new Six(3);
    System.out.println(alpha.value + " " + beta.value);
  }
}