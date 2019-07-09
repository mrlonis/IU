/*
The following code illustrates anonymous blocks.
class One {
  public static void main(String[] args) {
    { // first block starts here 
      int i = 5, j = 2;
      System.out.println( i + j );
    } // and ends here 
    { // second block starts here 
      String i = "5";
      char j = '2';
      System.out.println( i + j );
    } // and ends here 
  }
}
What happens when you try to compile and run this code? Why?

The program compiles and returns:

7
52

this is because in the first block i and j aere of the same data type and add to make 7.
The second block is merely adding strings which is why the output returns "52" without quotation marks
*/

class One_1 {
  public static void main(String[] args) {
    { // first block starts here 
      int i = 5, j = 2;
      System.out.println( i + j );
    } // and ends here 
    { // second block starts here 
      String i = "5";
      char j = '2';
      System.out.println( i + j );
    } // and ends here 
  }
}