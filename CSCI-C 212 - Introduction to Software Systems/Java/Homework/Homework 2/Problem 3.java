import java.util.Scanner;
 
class HomeworkTwo3 {
    public static void main (String [] args) {       
        double sum = 0; // Initialize sum
        int count = 0; // Initialize count
        double largest = 0; // Initialize Largest number
        double smallest = 0; // Initialize Smallest
        double range = 0; // Initialize range
        
        // Start a new scanner
        Scanner in = new Scanner(System.in);
        
        // Initialize and set value variables
        String value_s = "Hi";
        double value = 0;
        
        // First message
        System.out.println("Welcome to my Homework 2 Program!");
        System.out.println("This program will ask you for numbers and continually show you the average, largest, smallest, and range numbers. To end, simply type bye");
        System.out.print("Enter a number: ");
        value_s = in.nextLine();
        value = Double.parseDouble(value_s);
        
        // Loop: Ends when value_s equals "bye"
        while (!value_s.equals("bye")) {
          value = Double.parseDouble(value_s);
          
          //Find average
          sum = sum + value;
          count++;
          double average = sum/count;
          
          // Set largest, smallest, and range
          if ( (value > largest) && ((smallest == 0) && (count == 1))) {
            largest = value;
            smallest = value;
            range = largest - smallest;
          } else if (value > largest) {
            largest = value;
            range = largest - smallest;
          } else if (value < smallest) {
            smallest = value;
            range = largest - smallest;
          }
          
          // Print final message
          System.out.println( "(" + average + ", " + smallest + ", " + largest + ", " + range + ")" );
          
          // Ask for a new number
          System.out.print("Enter a number: ");
          value_s = in.nextLine();
        }
        // Close scanner and give farewell message
        in.close();
        System.out.println("Thank you for using this program!");
    }
}