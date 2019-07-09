/*
What is the result of attempting to compile and run the following code?

class Five {
  int value;
  Five (int v) {
    value = 0;
  }
  Five () {
    value = 3;
  }
  public static void main(String[] args) {
    Five alpha = new Five();
    Five beta = new Five(3);
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

- We get option (c); compiles and outputs 3 0
- This is because we defined both a Five(); and a Five(int);

*/

class Five {
  int value;
  Five (int v) {
    value = 0;
  }
  Five () {
    value = 3;
  }
  public static void main(String[] args) {
    Five alpha = new Five();
    Five beta = new Five(3);
    System.out.println(alpha.value + " " + beta.value);
  }
}