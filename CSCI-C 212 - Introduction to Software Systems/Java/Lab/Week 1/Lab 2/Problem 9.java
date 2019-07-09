/*
What is the output of the following program? Explain.
class One {
  public static void main(String[] args) {
    int x = 3, y = 5;
    int b = x++ + y++ - ++y - ++x;
    System.out.println( x + " " + y + " " + b );
  }
}

The output is 5 7 -4 because ++y and ++x make x and y 5 and 7 resopectively. b is equal to -4 because its math is really
b = 3 + 5 - 5 - 7 = -4
*/

class One {
  public static void main(String[] args) {
    int x = 3, y = 5;
    int b = x++ + y++ - ++y - ++x;
    System.out.println( x + " " + y + " " + b );
  }
}