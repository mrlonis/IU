/*Write a program that can communicate with th user in some fashion

Original:

import java.util.*;

public class Arrays {
  public static void main(String[] args) {
    Scanner in = new Scanner(System.in);
    int[] numbers;
    numbers = new int[5];
    String line;
    int count = 0;
    System.out.println("Type 'bye' at any time to end the loop.");
    System.out.println("Otherwise, I will populate an array of ints.");
    System.out.println("At the end I will show you the array.");
    while (count != 5 || !line.equals("bye")) {
      System.out.println("Type: ");
      line = in.nextLine();
      numbers[count] = count;
      count++;
    }
    System.out.println(Arrays.toString(numbers));
  }
  
  public void toString(int[] numbers) {
    System.out.print("[");
    int count = 0;
    while (count != numbers.length()) {
      System.out.print(numbers[count] + " ");
      count++;
    }
    System.out.println("]");
  }
}
*/

import java.util.*;

public class Arrays1 { //Only cause Array1 due to conflicting file names
  public static void main(String[] args) {
    Scanner in = new Scanner(System.in);
    int[] numbers;
    numbers = new int[5];
    String line = ""; //Initialized line
    int count = 0;
    System.out.println("Type 'bye' at any time to end the loop.");
    System.out.println("Otherwise, I will populate an array of ints.");
    System.out.println("At the end I will show you the array.");
    while ( (count != 5) && (!line.equals("bye")) ) { //Changed it to an && instead of an ||
      numbers[count] = count;
      count++;
      System.out.print("Type: "); //I changed the order here a bunch but it has no real affect in the code. Changed println to print for visual clarity
      line = in.nextLine();
    }
    System.out.println(Arrays.toString(numbers));
    in.close(); //Added this for the resource leak warning however this does not actually alter the functionality of the code
  }
  

  public static String toString(int[] numbers) { //Made method static and reurn string type
    String string = "["; 
    int count = 0;
    while (count != numbers.length) { //got rid of the () after length because it doesnt use parameters
      string += numbers[count] + ", "; //Added a comma for visual clarity
      count++;
    }
    string += "]";
    return string; // Return string
  }
}

/* All in all i think i did understand this problem well. Most of my mistakes were minor and only need small tweaks in order to correct. 
 * I say i deserve 0.75 out of 1 for this problem
 */

