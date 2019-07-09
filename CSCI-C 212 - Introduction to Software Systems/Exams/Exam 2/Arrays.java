import java.util.Scanner;

class Arrays {
  public static void main(String[] args) {
    Scanner in = new Scanner(System.in);
    int[] numbers; // declaration
    numbers = new int[0];
    System.out.println( /*java.util.*/Arrays.toString( numbers ) );
    System.out.print("type: ");
    String line = in.nextLine();
    
    while (! line.equals("bye")) {
      int number = Integer.parseInt( line );
      int[] temporary = /*java.util.*/Arrays.copyOf(numbers, numbers.length + 1);
      temporary[temporary.length - 1] = number;
      numbers = temporary;
      System.out.println( /*java.util.*/Arrays.toString( numbers ) );
      System.out.print("type: ");
      line = in.nextLine();
    }
    
    /*java.util.*/Arrays.sort( numbers );
    System.out.println( /*java.util.*/Arrays.toString( numbers ) );
    in.close();
  }
  
  /*toString : int[] -> String*/
  /*toString returns the string representation of the int[] a array*/
  public static String toString(int[] a) {
    String string = "["; // Initial bracket
    int count = 0;
    /*This loops so that each element in the array can be printed*/
    while (a.length != count) {
      string += a[count] + ", ";
      count++;
    }
    /*This is used for when string is longer than 2 characters. When the program first runs the string will be "[]" which is two characters so we want to avoid running the code below on "[]"*/
    if (string.length() > 2) {
      string = string.substring(0, (string.length() - 2));
    } else {
    }
    string += "]"; // End bracket
    return string; // Return string
  }
  
  /*copyOf : int[] int -> int[]*/
  /*copyOf returns the new int[] that is the same as int[] original except its size is 1 bigger*/
  public static int[] copyOf(int[] original, int newLength) {
    int[] copy = new int[newLength]; // Initialize a new array of length newLength
    for (int i = 0; i < original.length; i++) { // Loop to copy each element from original into copy
      copy[i] = original[i]; // Copy[i] now equals whatever original[i] equals
    }
    return copy; // Return new array
  }
  
  /*sort : int[] -> void*/
  /*sort returns the sorted version of int[] a from smallest to largest*/
  public static void sort(int[] a) {
    for (int s = 0; s <= a.length-1; s++) {
      for (int k = 0; k <= a.length-2; k++) {
        if (a[k]>a[k+1]) {
          int temp = 0;
          temp = a[k]; // temp hold a[k]
          a[k] = a[k+1]; // a[k] now equals a[k+1]
          a[k+1] = temp; // a[k+1] now equals temp. This ends moving around the two numbers
        }
      }
    }    
  }
  
}